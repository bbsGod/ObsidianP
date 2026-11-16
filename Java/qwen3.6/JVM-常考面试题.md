# JVM 常考面试题

> 📌 整理 JVM 面试中最常考的知识点和题目，按出现频率和难度分级。

---

## ⭐ 一、高频必考题（面试必问）

### Q1：JVM 的内存模型是怎样的？如何划分？

**参考答案：**

JVM 内存模型分为 **线程私有区域** 和 **线程共享区域** 两大类：

**线程私有区域（每个线程独立）：**
- **线程栈（Stack）**：存储局部变量、方法调用栈帧、方法出口。每个方法执行时创建一个栈帧，栈帧包含局部变量表、操作数栈、动态链接、方法出口。线程栈大小可通过 `-Xss` 设置。
- **程序计数器（PC Register）**：当前线程所执行的字节码行号指示器。线程私有，线程切换后能恢复到正确位置。如果执行的是 Native 方法，计数器值为 undefined。

**线程共享区域（所有线程共享）：**
- **堆（Heap）**：JVM 管理的最大内存区域，存储对象和数组。所有线程共享。堆是 GC 的主要区域。可通过 `-Xms`（初始堆大小）和 `-Xmx`（最大堆大小）设置。
- **元空间（Metaspace，JDK8+）**：存储类信息、常量、静态变量。使用本地内存（Native Memory），不限制大小（受本机内存限制）。可通过 `-XX:MetaspaceSize` 和 `-XX:MaxMetasaceSize` 设置。
- **字符串常量池（JDK7+ 移到堆中）**：存储字符串常量。通过 `String.intern()` 可以手动将字符串放入常量池。

**直接内存（Direct Memory）：**
- 不属于 JVM 运行时数据区，但会被 OOM 影响。通过 `ByteBuffer.allocateDirect()` 分配，使用 `malloc()` 在本地内存中分配。NIO 使用直接内存进行零拷贝。

**加分回答：**
- 堆的内部划分：Eden / Survivor（S0/S1）/ 老年代
- TLAB（Thread Local Allocation Buffer）：每个线程在 Eden 中分配私有区域，避免多线程竞争

---

### Q2：什么是 GC？常见的垃圾回收算法有哪些？

**参考答案：**

**GC（Garbage Collection）** 是 JVM 自动管理内存的机制，通过垃圾回收算法识别并回收不再使用的对象，释放内存。

**三种基本垃圾回收算法：**

| 算法 | 原理 | 优点 | 缺点 | 应用区域 |
|------|------|------|------|---------|
| **标记-清除** | 标记所有需要回收的对象，然后统一清除 | 实现简单 | 产生大量内存碎片，效率低 | 老年代 |
| **复制算法** | 将内存分为两块，每次只用一块，用完后将存活对象复制到另一块 | 无碎片，效率高 | 内存利用率只有 50% | **新生代** |
| **标记-整理** | 标记后让存活对象向一端移动，然后清除边界外的内存 | 无碎片 | 效率较低（需要移动对象） | **老年代** |

**JVM 的实际选择：**
- **新生代**：采用 **复制算法**（Eden + 两个 Survivor，默认比例 8:1:1）
- **老年代**：采用 **标记-整理** 或 **标记-清除**（取决于 GC 器）

**加分回答：**
- 新生代为什么用复制算法？因为新生代对象存活率低，复制开销小
- Survivor 的作用：存放一次 GC 后存活的对象，作为缓冲区，避免对象直接进入老年代

---

### Q3：什么是内存泄漏？如何排查内存泄漏？

**参考答案：**

**内存泄漏**：对象已经不再使用，但由于被其他对象引用导致无法被 GC 回收，长期占用内存，最终导致 OOM。

**常见内存泄漏场景：**

| 场景 | 说明 | 解决方案 |
|------|------|---------|
| **静态集合** | 静态 List/Map 不断添加对象，永远不会被回收 | 使用弱引用或及时 remove |
| **未关闭资源** | InputStream/Connection 未关闭 | 使用 try-with-resources |
| **内部类持有外部类引用** | 非静态内部类隐式持有外部类引用 | 使用静态内部类 |
| **监听器未注销** | 注册监听器后未注销 | 及时 removeEventListener |
| **ThreadLocal 未 remove** | ThreadLocal 导致内存泄漏 | 使用完调用 remove() |

**排查内存泄漏的步骤：**

```
1. 监控告警：通过 JMX / Prometheus 发现内存持续增长
2. Dump 堆内存：jmap -dump:format=b,file=heap.hprof <pid>
3. MAT 分析：打开 heap.hprof，查看 Leak Suspects 报告
4. Dominators 视图：查找占用内存最大的对象持有链
5. 定位代码：根据引用链找到导致泄漏的代码位置
6. 修复验证：修复后压测验证
```

**加分回答：**
- 区分内存泄漏和内存溢出：内存泄漏是原因，内存溢出是结果
- 使用 Arthas 的 `thread -n 3` 和 `gc` 命令快速定位

---

## ⭐⭐ 二、中频高频题（面试常问）

### Q4：JVM 类加载过程是怎样的？双亲委派模型是什么？

**参考答案：**

**类加载的五个阶段：**

```
加载 → 验证 → 准备 → 解析 → 初始化
```

| 阶段 | 说明 | 关键点 |
|------|------|--------|
| **加载** | 通过类的全限定名获取二进制字节流，在内存中生成 Class 对象 | 涉及类加载器 |
| **验证** | 确保 Class 文件信息符合 JVM 要求 | 文件格式、元数据、字节码、符号引用 |
| **准备** | 为静态变量分配内存，设置默认值 | 只处理静态变量，默认值（int=0, reference=null） |
| **解析** | 将符号引用替换为直接引用 | 符号引用→直接引用 |
| **初始化** | 执行 `<clinit>` 方法（类构造器） | 静态变量赋值和静态代码块 |

**双亲委派模型：**

**工作流程：**
当一个类加载器收到类加载请求时，先把请求委派给父类加载器处理。顶层的 Bootstrap 先处理，如果 Bootstrap 无法处理，才由子类加载器尝试处理，依此类推。

**为什么用双亲委派？**
1. **保证核心类的安全性**：无论谁加载，`java.lang.String` 始终由 Bootstrap 加载，不会被篡改
2. **避免类重复加载**：确保一个类只被加载一次

**打破双亲委派模型的场景：**

| 场景 | 说明 |
|------|------|
| **SPI（Service Provider Interface）** | 如 JDBC Driver，SPI 接口由 Bootstrap 加载，实现由 Application 加载，需要父类加载器委托子类加载器 |
| **Tomcat** | 每个 Web 应用需要独立的类加载器隔离，否则同名类会冲突 |
| **热部署** | 代码热替换需要重新加载类 |
| **字节码增强** | ASM/Javassist 需要在运行时动态生成类 |

**加分回答：**
- 准备阶段和初始化阶段的区别：准备阶段设默认值（int=0），初始化阶段设真实值（int=10）
- `<clinit>` 和 `<init>` 的区别：`<clinit>` 是类构造器（静态），`<init>` 是实例构造器（构造器）

---

### Q5：G1 垃圾回收器的工作原理是什么？为什么它是 JDK9 的默认 GC？

**参考答案：**

**G1 的核心设计思想：**

G1（Garbage-First）将堆划分为多个大小相同的 **Region**（1~32MB），每个 Region 可以扮演 Eden、Survivor、Old、Humongous 角色。

**Region 类型：**

| Region 类型 | 作用 |
|------------|------|
| **Eden** | 新对象分配 |
| **Survivor** | GC 后存活对象 |
| **Old** | 老年代对象 |
| **Humongous** | 大对象（超过 Region 大小 50% 的对象直接分配到 Humongous Region） |

**G1 的 GC 类型：**

| GC 类型 | 说明 |
|---------|------|
| **Young GC** | 仅清理 Eden + Survivor Region，类似 Minor GC，STW 时间短 |
| **Mixed GC** | 清理 Eden + Survivor + Old 中 GC 效率最高的 Region（优先回收 GC 后能释放最多内存的 Region） |
| **Full GC** | 清理整个堆，STW 时间长，尽量避免 |

**G1 的标记算法：SATB（Snapshot-At-The-Beginning）**

- 记录标记开始时对象的引用关系
- 标记过程中新创建的对象引用通过 SATB 保证不遗漏
- 相比 CMS 的增量更新算法，G1 的重新标记 STW 时间更短

**Remembered Set（记忆卡）：**

- 追踪跨 Region 引用（老年代引用新生代）
- 使用 Card Table（256 字节/Card）实现
- 写屏障（Write Barrier）负责更新 Remembered Set

**为什么 G1 是 JDK9 的默认 GC？**

| 优势 | 说明 |
|------|------|
| **可预测的停顿时间** | 通过 `-XX:MaxGCPauseMillis` 设定目标停顿时间 |
| **全局 GC 算法** | 能一次性管理整个堆，避免 CMS 的内存碎片 |
| **Humongous 分配** | 大对象直接分配到 Humongous Region，减少碎片 |
| **并发标记** | 标记阶段大部分并发执行，减少 STW |
| **Mixed GC** | 优先回收可释放最多内存的 Region，停顿时间可控 |

**加分回答：**
- G1 的调优参数：`-XX:MaxGCPauseMillis`（目标停顿时间）、`-XX:G1HeapRegionSize`（Region 大小）、`-XX:InitiatingHeapOccupancyPercent`（触发并发标记的阈值）
- G1 的缺点：吞吐量大（GC 时间长），不适合低延迟场景（此时应选 ZGC）

---

### Q6：volatile 关键字的作用是什么？它如何保证可见性和有序性？

**参考答案：**

**volatile 的三大特性：**

| 特性 | 是否保证 | 说明 |
|------|---------|------|
| **可见性** | ✅ | 一个线程修改 volatile 变量，其他线程立即可见 |
| **有序性** | ✅ | 禁止指令重排序 |
| **原子性** | ❌ | `i++` 这样的复合操作不保证原子性 |

**可见性如何保证？**

volatile 写操作时，JVM 会插入 **StoreStore 屏障** 和 **StoreLoad 屏障**，确保 volatile 写之前的所有写操作都在之前完成，并将缓存行写回主内存。volatile 读操作时，JVM 会插入 **LoadLoad 屏障** 和 **LoadStore 屏障**，确保 volatile 读之后的读操作不会从缓存中读取（而是从主内存读取）。

**有序性如何保证？**

volatile 禁止指令重排序：
- volatile 写之前的操作不能在 volatile 写之后执行
- volatile 读之后的操作不能在 volatile 读之前执行

**volatile 的应用场景：**

| 场景 | 示例 |
|------|------|
| **状态标志位** | `volatile boolean running = false;` |
| **DCL 单例** | `private static volatile Singleton instance;` |
| **观察者模式** | 通知标志 |

**加分回答：**
- 为什么 DCL 单例需要 volatile？`new Singleton()` 不是原子操作：分配内存 → 初始化 → 引用指向。没有 volatile 时，可能发生指令重排，导致其他线程拿到未完全初始化的对象。
- volatile 和 synchronized 的区别：volatile 不保证原子性，synchronized 保证原子性+可见性+有序性；volatile 不会导致线程阻塞，synchronized 会导致线程阻塞。

---

### Q7：synchronized 的锁升级过程是怎样的？

**参考答案：**

**锁升级过程（JDK6+）：**

```
无锁 → 偏向锁 → 轻量级锁 → 重量级锁
```

| 升级步骤 | 触发条件 | 说明 |
|----------|---------|------|
| **无锁 → 偏向锁** | 第一个线程获取锁 | 对象头记录线程 ID，后续该线程无需同步 |
| **偏向锁 → 轻量级锁** | 第二个线程尝试获取锁 | CAS 操作升级，失败则自旋 |
| **轻量级锁 → 重量级锁** | 自旋超过 10 次（默认） | 升级为重量级锁，线程阻塞 |

**Mark Word 在不同锁状态下的结构：**

| 锁状态 | Mark Word 内容 |
|--------|---------------|
| 无锁 | 对象 hashcode、年龄、偏向锁标志 |
| 偏向锁 | 偏向锁标志=1，线程 ID |
| 轻量级锁 | 指向栈中锁记录（Lock Record）的指针 |
| 重量级锁 | 指向堆中 Monitor 对象的指针 |

**锁消除和锁粗化：**

| 优化 | 说明 |
|------|------|
| **锁消除** | JIT 检测到对象无逃逸时，消除 synchronized 锁 |
| **锁粗化** | JIT 检测到一连串操作都加同一把锁时，将锁扩展到整段代码 |

**加分回答：**
- JDK6 之前 synchronized 是重量级锁，性能差。JDK6 引入偏向锁和轻量级锁优化。
- 偏向锁在 JDK15 被移除，因为实际场景中单线程获取锁的情况较少，偏向锁的开销大于收益。

---

## ⭐⭐⭐ 三、中频题（面试常问，需掌握）

### Q8：JVM 常用的调优参数有哪些？如何设置？

**参考答案：**

**堆内存参数：**

| 参数 | 说明 | 建议值 |
|------|------|--------|
| `-Xms` | 初始堆大小 | 与 `-Xmx` 相同，避免运行时扩容 |
| `-Xmx` | 最大堆大小 | 根据应用需求设置 |
| `-Xmn` | 新生代大小 | 堆的 1/3~1/4 |
| `-XX:NewRatio` | 老年代/新生代比例 | 默认 2（老年代占 2/3） |
| `-XX:SurvivorRatio` | Eden/Survivor 比例 | 默认 8（Eden 占 8/10） |
| `-XX:MaxTenuringThreshold` | 对象晋升老年代的年龄阈值 | 默认 15 |

**元空间参数：**

| 参数 | 说明 |
|------|------|
| `-XX:MetaspaceSize` | 初始元空间大小 |
| `-XX:MaxMetaspaceSize` | 最大元空间大小 |

**GC 参数：**

| 参数 | 说明 |
|------|------|
| `-XX:+UseG1GC` | 启用 G1 |
| `-XX:MaxGCPauseMillis` | G1 目标停顿时间 |
| `-XX:G1HeapRegionSize` | G1 Region 大小 |
| `-XX:InitiatingHeapOccupancyPercent` | G1 触发并发标记的阈值 |

**诊断参数：**

| 参数 | 说明 |
|------|------|
| `-XX:+PrintGCDetails` | 打印详细 GC 日志 |
| `-XX:+HeapDumpOnOutOfMemoryError` | OOM 时自动 dump |
| `-XX:HeapDumpPath` | dump 文件路径 |

**生产环境推荐参数（JDK8 + G1）：**

```bash
-Xms4g -Xmx4g                     # 堆初始=最大
-Xmn1g                             # 新生代 1G
-XX:MetaspaceSize=256m             # 元空间初始
-XX:MaxMetaspaceSize=512m          # 元空间最大
-XX:+UseG1GC                       # 启用 G1
-XX:MaxGCPauseMillis=100           # 目标停顿 100ms
-XX:InitiatingHeapOccupancyPercent=45  # 提前触发并发标记
-Xlog:gc*:file=gc.log:time,uptime:filecount=5,filesize=100m
-XX:+HeapDumpOnOutOfMemoryError
-XX:HeapDumpPath=/data/dumps/
```

**加分回答：**
- 为什么 `-Xms` 和 `-Xmx` 要设为相同值？避免 JVM 运行时动态调整堆大小带来的性能开销
- 新生代大小如何设置？根据对象存活率设置，存活率低则新生代小，存活率高则新生代大

---

### Q9：jstat、jmap、jstack 的作用是什么？如何使用？

**参考答案：**

| 工具 | 作用 | 常用命令 |
|------|------|---------|
| **jps** | 查看 Java 进程 | `jps -l` |
| **jstat** | 监控 GC 统计信息 | `jstat -gcutil <pid> 1000` |
| **jmap** | 堆内存快照 | `jmap -dump:format=b,file=heap.hprof <pid>` |
| **jstack** | 线程快照 | `jstack <pid>` |
| **jcmd** | 综合诊断 | `jcmd <pid> GC.heap_dump` |
| **jinfo** | 查看 JVM 参数 | `jinfo -flags <pid>` |

**jstat 详解：**

```bash
# 每秒刷新一次 GC 统计
jstat -gcutil <pid> 1000

# 输出字段说明：
# S0: Survivor 0 使用率
# S1: Survivor 1 使用率
# E: Eden 使用率
# O: 老年代使用率
# M: 元空间使用率
# OC: 老年代容量
# YGC: 新生代 GC 次数
# YGCT: 新生代 GC 总时间
# FGC: Full GC 次数
# FGCT: Full GC 总时间
# GCT: GC 总时间
```

**jmap 详解：**

```bash
# 堆内存快照
jmap -dump:format=b,file=heap.hprof <pid>

# 查看堆中对象统计
jmap -histo <pid>
```

**jstack 详解：**

```bash
# 线程快照
jstack <pid> > thread.dump

# 查看死锁
jstack -l <pid> | grep "Found one Java-level deadlock"
```

**加分回答：**
- Arthas 是阿里开源的线上诊断神器，功能比 JDK 自带工具更强大：`jvm`（查看 JVM 信息）、`thread -n 3`（CPU 占用最高的 3 个线程）、`dashboard`（实时监控面板）、`gc`（查看 GC 情况）

---

### Q10：CMS 垃圾回收器的工作原理是什么？它的缺点是什么？

**参考答案：**

**CMS（Concurrent Mark Sweep）基于标记-清除算法，目标是最短 GC 停顿时间。**

**CMS 的四个步骤：**

| 步骤 | 说明 | STW？ |
|------|------|-------|
| **初始标记** | 标记 GC Roots 可达对象 | ✅ STW |
| **并发标记** | 并发标记存活对象 | ❌ 并发 |
| **重新标记** | 修正并发标记期间的变化 | ✅ STW（但比初始标记快） |
| **并发清除** | 并发清除垃圾对象 | ❌ 并发 |

**CMS 的优点：**
- 并发标记和并发清除，STW 时间短
- 适合对响应时间敏感的应用

**CMS 的缺点：**

| 缺点 | 说明 |
|------|------|
| **内存碎片** | 标记-清除算法产生碎片，可能导致大对象无法分配 |
| **依赖 CPU 资源** | 并发标记占用 CPU，影响应用吞吐量 |
| **浮动垃圾** | 并发清除期间新创建的垃圾无法回收 |
| **Full GC 回退** | 内存碎片导致 Full GC，停顿时间反而比 Parallel GC 更长 |
| **JDK14 被移除** | CMS 在 JDK14 中被移除 |

**加分回答：**
- CMS 和 G1 的区别：CMS 基于标记-清除，G1 基于标记-整理；CMS 没有 Region 概念，G1 将堆划分为 Region；G1 的停顿时间更可预测。
- CMS 的适用场景：对响应时间敏感、堆内存不大、CPU 资源充足。

---

## ⭐⭐⭐ 四、低频但重要题（加分题）

### Q11：什么是 ABA 问题？如何解决？

**参考答案：**

**ABA 问题：**

CAS 操作中，线程 1 读取值为 A，线程 2 将值改为 B，然后又改回 A。线程 1 执行 CAS 时，发现值还是 A，认为没有被修改过，但实际上值已经被修改过了。

**示例：**

```java
AtomicInteger atomicInt = new AtomicInteger(1);

// 线程 1
int oldValue = atomicInt.get(); // 读取到 1
// 线程 2 执行：atomicInt.set(2); atomicInt.set(1);
// 线程 1 执行：atomicInt.compareAndSet(1, 100); // 成功！但值被线程 2 改过

// 线程 2 的修改对线程 1 不可见，这就是 ABA 问题
```

**解决方案：**

使用 `AtomicStampedReference`（带版本号的原子引用）：

```java
AtomicStampedReference<Integer> ref = new AtomicStampedReference<>(1, 0);

// 线程 1
int[] stamp = new int[1];
int oldValue = ref.get(stamp); // 读取到 1，版本号 0

// 线程 2 执行：ref.compareAndSet(1, 2, oldStamp, oldStamp+1); 
//              ref.compareAndSet(2, 1, oldStamp+1, oldStamp+2);

// 线程 1 执行：ref.compareAndSet(1, 100, 0, 1); // 失败！版本号不匹配
```

**加分回答：**
- ABA 问题本质是 CAS 只检查值是否变化，不检查值是否被"中间修改过"
- `AtomicStampedReference` 通过版本号（stamp）解决 ABA 问题，每次修改版本号 +1

---

### Q12：ThreadLocal 的内存模型是怎样的？为什么会导致内存泄漏？

**参考答案：**

**ThreadLocal 的内存模型：**

```
线程 Thread
└── ThreadLocal.ThreadLocalMap map
    ├── Entry(ThreadLocal弱引用 → Value强引用)
    └── Entry(ThreadLocal弱引用 → Value强引用)
```

**为什么会导致内存泄漏？**

| 引用类型 | 说明 |
|----------|------|
| **ThreadLocal 本身** | 弱引用（WeakReference） |
| **ThreadLocalMap.Entry.value** | 强引用（StrongReference） |

**泄漏过程：**
1. ThreadLocal 被 GC 回收（因为是弱引用）
2. ThreadLocalMap 中的 Entry.key 变为 null
3. 但 Entry.value 仍然是强引用，无法被回收
4. 如果线程长期运行（如线程池），value 一直占用内存

**如何避免内存泄漏？**

| 方法 | 说明 |
|------|------|
| **使用完调用 remove()** | 最直接的避免方式 |
| **ThreadLocalMap 自动清理** | get()/set()/remove() 时会清理 key 为 null 的 Entry |
| **使用静态 ThreadLocal** | 避免 ThreadLocal 被 GC 回收 |

**加分回答：**
- ThreadLocalMap 的 Entry 继承自 WeakReference，key 是 ThreadLocal 实例
- InheritableThreadLocal：子线程可以访问父线程的 ThreadLocal 变量
- ThreadLocal 的应用场景：用户会话信息、数据库连接（连接池）、日期格式化（SimpleDateFormat 线程安全）

---

### Q13：什么是逃逸分析？JVM 基于逃逸分析的优化有哪些？

**参考答案：**

**逃逸分析：**

JVM 分析新创建的对象是否会被方法外部访问。

**两种逃逸状态：**

| 状态 | 说明 |
|------|------|
| **全局逃逸** | 对象引用被 static 修饰，或在方法外线程中可见 |
| **方法逃逸** | 对象引用被方法返回，或在方法内传递但未被局部变量持有 |
| **无逃逸** | 对象仅在方法内可见，方法结束即销毁 |

**基于逃逸分析的优化：**

| 优化 | 说明 |
|------|------|
| **锁消除** | JIT 检测到对象无逃逸时，消除 synchronized 锁 |
| **栈上分配** | JIT 检测到对象无逃逸时，分配在栈上，随栈帧销毁而回收 |
| **标量替换** | JIT 将对象拆分为基本类型（标量），不创建对象实例 |

**示例：**

```java
// 这段代码中的 synchronized 会被 JIT 消除
public void noEscape() {
    StringBuilder sb = new StringBuilder();
    synchronized (sb) {
        sb.append("hello");
    }
}

// 这段代码中的 synchronized 不会被消除
public StringBuilder escape() {
    StringBuilder sb = new StringBuilder();
    synchronized (sb) {
        sb.append("hello");
    }
    return sb; // sb 逃逸到方法外
}
```

**加分回答：**
- 逃逸分析不是 JVM 规范的一部分，而是 HotSpot 的优化手段
- 可以通过 `-XX:-DoEscapeAnalysis` 关闭逃逸分析
- 锁消除在 JDK6+ 默认开启，是 synchronized 性能提升的重要原因

---

### Q14：线程池的核心参数和工作原理是什么？

**参考答案：**

**线程池核心参数：**

```java
new ThreadPoolExecutor(
    corePoolSize,       // 核心线程数
    maximumPoolSize,    // 最大线程数
    keepAliveTime,      // 空闲线程存活时间
    TimeUnit unit,      // 时间单位
    workQueue,          // 工作队列
    threadFactory,      // 线程工厂
    handler             // 拒绝策略
);
```

**线程池工作流程：**

```
1. 新任务提交 → 核心线程数未满？创建核心线程执行
2. 核心线程数已满 → 放入工作队列
3. 工作队列已满 → 最大线程数未满？创建非核心线程执行
4. 最大线程数已满 → 执行拒绝策略
```

**工作队列类型：**

| 队列类型 | 说明 | 适用场景 |
|----------|------|---------|
| ArrayBlockingQueue | 有界数组队列 | 需要控制最大并发数 |
| LinkedBlockingQueue | 有界/无界链表队列 | 吞吐量优先 |
| SynchronousQueue | 不存储元素，直接传递 | 高并发、低延迟 |
| PriorityBlockingQueue | 优先级队列 | 需要任务优先级 |

**拒绝策略：**

| 策略 | 说明 |
|------|------|
| AbortPolicy（默认） | 抛出 RejectedExecutionException |
| CallerRunsPolicy | 由调用线程执行任务 |
| DiscardPolicy | 静默丢弃任务 |
| DiscardOldestPolicy | 丢弃最老的任务 |

**线程数设置原则：**

| 任务类型 | 线程数建议 |
|----------|-----------|
| CPU 密集型 | N + 1（N 为 CPU 核数） |
| IO 密集型 | 2N 或 N / (1 - 阻塞系数) |

**加分回答：**
- Executors 创建的线程池问题：`newFixedThreadPool` 和 `newSingleThreadExecutor` 使用无界队列，可能导致 OOM；`newCachedThreadPool` 最大线程数是 Integer.MAX_VALUE，可能创建过多线程。
- 推荐使用 `ThreadPoolExecutor` 手动创建线程池。

---

### Q15：JVM 中哪些操作会导致 STW？

**参考答案：**

**导致 STW 的操作：**

| 操作 | 说明 |
|------|------|
| **Full GC** | 所有 GC 线程停止，所有应用线程暂停 |
| **类加载的验证/准备阶段** | 可能需要 STW |
| **偏向锁撤销** | 撤销偏向锁时需要 STW |
| **SafePoint 挂起** | 请求线程在 SafePoint 处挂起目标线程 |
| **元空间 Full GC** | 元空间满时触发 Full GC |
| **G1 Mixed GC** | 清理多个 Region 时需要短暂 STW |

**STW 时间的优化方向：**

| 方向 | 说明 |
|------|------|
| 使用 G1/ZGC | 减少 STW 时间 |
| 调整 MaxGCPauseMillis | 设定目标停顿时间 |
| 避免大对象分配 | 减少 Humongous 分配 |
| 并行处理引用处理器 | -XX:+ParallelRefProcEnabled |

**加分回答：**
- SafePoint 是 JVM 中代码可能停下来的位置，GC 可以在这些点触发
- ZGC 的 STW 时间 < 10ms，不受堆大小影响

---

## 五、实战场景题

### Q16：线上服务响应时间飙升，如何排查？

**参考答案：**

**排查步骤：**

```
第 1 步：定位进程
jps -l

第 2 步：查看 CPU 使用率
top -Hp <pid>  # 找到 CPU 占用高的线程

第 3 步：转换为十六进制
printf "%x\n" <线程ID>

第 4 步：定位线程代码
jstack <pid> | grep <十六进制线程ID>

第 5 步：分析 GC 情况
jstat -gcutil <pid> 1000

第 6 步：判断问题类型
├── CPU 高 → 死循环 / 频繁 GC / 复杂计算
├── GC 频繁 → 堆太小 / 内存泄漏
└── 线程阻塞 → 锁竞争 / 数据库慢查询

第 7 步：Dump 堆内存（如果是内存问题）
jmap -dump:format=b,file=heap.hprof <pid>

第 8 步：MAT 分析
打开 heap.hprof，查看 Leak Suspects 报告

第 9 步：修复验证
```

**加分回答：**
- Arthas 的 `dashboard` 命令可以实时监控 CPU、内存、GC、线程等信息
- Arthas 的 `thread -n 3` 可以直接查看 CPU 占用最高的 3 个线程

---

### Q17：如何排查 Full GC 频繁的问题？

**参考答案：**

**排查步骤：**

```
第 1 步：监控 GC
jstat -gcutil <pid> 1000
# 观察 O（老年代）使用率是否持续高位

第 2 步：查看 GC 日志
grep "Full GC" gc.log
# 查看 Full GC 频率和耗时

第 3 步：Dump 堆内存
jmap -dump:format=b,file=heap.hprof <pid>

第 4 步：MAT 分析
打开 heap.hprof，查看 Dominators 视图
# 找到占用内存最大的对象持有链

第 5 步：定位代码
# 根据引用链找到导致内存泄漏的代码位置

第 6 步：调优
# 增大堆内存 / 调整新生代大小 / 降低对象晋升速度
```

**常见原因：**

| 原因 | 解决方案 |
|------|---------|
| 堆内存不足 | 增大 -Xmx |
| 新生代太小 | 增大 -Xmn |
| 对象晋升过快 | 调整 MaxTenuringThreshold |
| 内存泄漏 | 排查代码 |
| 元空间不足 | 增大 -XX:MaxMetaspaceSize |

---

## 六、面试技巧总结

### JVM 面试回答框架：

```
1. 先说概念（定义）
2. 再说原理（工作机制）
3. 举例说明（应用场景）
4. 对比分析（与其他知识点对比）
5. 加分回答（进阶知识）
```

### 常见追问套路：

| 主问题 | 常见追问 |
|--------|---------|
| JVM 内存模型 | 堆的内部划分？新生代为什么用复制算法？ |
| GC 算法 | G1 和 CMS 的区别？ZGC 的原理？ |
| volatile | 为什么 DCL 需要 volatile？和 synchronized 的区别？ |
| synchronized | 锁升级过程？锁消除？JDK6 的优化？ |
| JVM 调优 | 如何排查 Full GC？生产环境参数怎么设？ |
| 类加载 | 双亲委派？打破双亲委派？内存泄漏？ |

---

> 💡 **提示**：
> 1. 高频必考题（Q1-Q3）必须能流利回答
> 2. 中频高频题（Q4-Q7）面试中至少会问到 2-3 道
> 3. 中频题（Q8-Q10）是区分初级和中级的关键
> 4. 低频题（Q11-Q15）是加分项，能让面试官眼前一亮
> 5. 实战题（Q16-Q17）考察动手能力，建议实际练习 jstat/jmap/jstack
