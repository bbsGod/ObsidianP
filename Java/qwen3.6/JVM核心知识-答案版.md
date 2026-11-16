# JVM 核心知识 · 答案版

> 📌 这份是填空笔记的答案版，对照检查你的记忆情况。

---

## 一、JVM 内存模型

### 1.1 JVM 内存区域的划分

**线程私有区域（每个线程独立）：**
- **线程栈（Stack）**：存储局部变量、方法出口、栈帧（栈帧包含局部变量表、操作数栈、动态链接、方法出口）
- **程序计数器（Program Counter Register）**：线程安全，无需垃圾回收，主要用于字节码编译优化

**线程共享区域（所有线程共享）：**
- **堆（Heap）**：JVM 管理的最大内存区域，存储 `new` 出来的对象和数组
- **元空间（Metaspace）**（JDK8 及之后）：存储类信息、常量、静态变量、即时编译后的代码
- **字符串常量池**（JDK7 及之前叫"永久代"）：存储字符串常量池

**直接内存（Direct Memory）：**
- 不属于 JVM 运行时数据区，但会被 OOM 影响
- 通过 `ByteBuffer` 类操作，避免 Java 堆到 Native 缓冲区的拷贝

### 1.2 堆的内部划分

**对象分配流程：**

1. 新对象创建时，优先在 **Eden** 分配内存
2. 如果 Eden 满了，触发 **Minor GC**（新生代 GC）
3. 存活对象被复制到 **Survivor** 区，年龄 +1
4. 当对象年龄达到 **15**（默认 15，可配置 MaxTenuringThreshold）时，晋升到老年代
5. 大对象直接分配到 **Humongous**（如果超过 G1 的 Humongous 阈值，即 Region 大小的 50%）

**TLAB（Thread Local Allocation Buffer）：**
- 作用：每个线程在 Eden 中分配一块私有内存区域
- 目的：避免多线程同时分配对象时的 **竞争（CAS/全局 Eden）** 问题
- 通过 **-XX:+/-UseTLAB** 参数开启/关闭

### 1.3 元空间 vs 永久代

| 对比项 | 永久代（JDK7 及之前） | 元空间（JDK8 及之后） |
|--------|----------------------|----------------------|
| 内存限制 | 固定大小（-XX:PermSize） | **本地内存（Native Memory）** |
| 默认大小 | **较小** | **较大（受本机内存限制）** |
| 内存溢出风险 | **高** | **较低（受本机内存限制）** |

**元空间常用参数：**
- `-XX:MetaspaceSize`：初始元空间大小，达到后触发 GC
- `-XX:MaxMetaspaceSize`：最大元空间大小，防止无限增长

---

## 二、类加载机制

### 2.1 类加载的五个阶段

**阶段详解：**

**（1）加载（Loading）：**
- 通过类的全限定名获取定义此类的 **二进制字节流**
- 在内存中生成该类的 **Class 对象（字节码数据结构）**
- 创建 `java.lang.Class` 对象

**（2）验证（Verification）：**
- 确保 Class 文件的字节流信息符合 JVM 要求
- 包括：文件格式验证、元数据验证、字节码验证、符号引用验证

**（3）准备（Preparation）：**
- 为 **静态（static）** 变量分配内存并设置 **静态（static）** 默认值
- 注意：这里只处理静态变量，不处理实例变量
- 默认值：int=0, long=0, reference=`null`

**（4）解析（Resolution）：**
- 将常量池中的 **符号** 引用替换为 **直接** 引用
- 符号引用：以一组符号描述的引用（字符串形式）
- 直接引用：直接指向目标的指针/偏移量/句柄

**（5）初始化（Initialization）：**
- 执行 **<clinit>** 方法（类构造器）
- 执行 **<init>** 方法（实例构造器，构造器）
- 线程安全：JVM 保证 `<clinit>` 方法的线程安全（类加载机制保证）

### 2.2 类加载器

**JVM 内置的类加载器：**

| 类加载器 | 职责 | 加载哪些类 |
|----------|------|-----------|
| **Bootstrap ClassLoader** | 核心库 | rt.jar 中的类（如 java.lang.*） |
| **Extension ClassLoader** | 扩展库 | ext 目录下的扩展包 |
| **Application ClassLoader** | 应用程序 | classpath 下的类（应用自己的类） |
| **自定义类加载器** | 自定义 | 用户自定义的类加载器 |

**双亲委派模型：**

**工作流程：**
当一个类加载器收到类加载请求时，先把请求委派给 **父** 类加载器处理
- 顶层的 Bootstrap 先处理
- 如果 Bootstrap 无法处理，才由 **子** 类加载器尝试处理
- 依此类推，最终由最底层的 **自己（应用类加载器）** 尝试加载

**为什么要用双亲委派？**
1. 保证核心类的 **安全性/一致性**（如 java.lang.String 不会被篡改）
2. 避免类重复加载

**打破双亲委派模型的场景：**

| 场景 | 说明 |
|------|------|
| **SPI（Service Provider Interface）** | 通过 SPI 机制（如 JDBC Driver） |
| **Web 容器（Tomcat）** | 每个 Web 应用需要独立的类加载器隔离 |
| **热部署（Hot Swap）** | 代码热替换、OSGi 框架 |
| **字节码增强** | 字节码增强（如 ASM、Javassist） |

---

## 三、垃圾回收算法与回收器

### 3.1 判断对象是否存活

**可达性分析算法（GC Roots）：**

从 **GC Roots 对象** 出发，沿着引用链向下搜索，搜索不到的对象即为不可达（可回收）。

**GC Roots 包括：**
- 虚拟机栈（栈帧中的局部变量表）中引用的对象
- 方法区中类静态属性引用的对象
- 方法区中常量引用的对象
- 本地方法栈中 JNI 引用的对象

### 3.2 四种引用类型

| 引用类型 | 说明 | 回收时机 |
|----------|------|---------|
| **强** 引用 | `new` 出来的对象，非 GC 不能回收 | Full GC 或 Mixed GC |
| **软** 引用 | `java.lang.ref.SoftReference`，内存不足时回收 | OOM 之前 |
| **弱** 引用 | `java.lang.ref.WeakReference`，下次 GC 时回收 | Minor GC |
| **虚** 引用 | `java.lang.ref.PhantomReference`，最弱，必须配合引用队列 | 任意 GC |

**应用：**
- 软引用：**缓存** 缓存实现
- 弱引用：**ThreadLocal** 与类加载器结合防止内存泄漏

### 3.3 垃圾回收算法

| 算法 | 优点 | 缺点 | 应用区域 |
|------|------|------|---------|
| 标记-清除 | 无需移动对象 | 产生 **内存碎片**，效率低 | 老年代 |
| 复制算法 | 无碎片，效率高 | 内存减半 | **新生代** |
| 标记-整理 | 无碎片 | 效率较低 | **老年代** |

### 3.4 垃圾回收器

**JDK8 默认 GC 器：Parallel GC（Parallel Scavenge + Parallel Old）**

**G1 回收器（JDK9+ 默认）：**

G1 将堆划分为多个 **Region**（Region），每个 Region 大小相同（1~32MB）

**Region 类型：**
- Eden Region：新对象分配
- Survivor Region：GC 后存活对象
- Old Region：老年代对象
- **Humongous** Region：大对象直接分配的 Region（超过 Region 大小 50%）

**G1 的三色标记算法：**
- 白色：未标记对象
- 灰色：正在标记对象
- 黑色：标记完成对象
- 记忆卡（Remembered Set）：用于追踪 **跨 Region** 引用（跨 Region 引用）

**G1 的 GC 类型：**
- **Young GC**：仅清理 Eden + Survivor，类似 Minor GC
- **Mixed GC**：清理 Eden + Survivor + Old 中 GC 效率最高的 Region
- **Full GC**： Full GC，清理整个堆

**G1 调优参数：**
- `-XX:MaxGCPauseMillis`：目标 GC 停顿时间（默认 200ms）
- `-XX:G1HeapRegionSize`：Region 大小（默认自动选择）
- `-XX:InitiatingHeapOccupancyPercent`：触发并发标记的堆占用百分比

**CMS 回收器（已被遗弃）：**

CMS 基于 **标记-清除** 算法，目标是最短 GC 停顿时间

**CMS 的四个步骤：**
1. **初始标记**：标记 GC Roots 可达对象（STW）
2. **并发标记**：并发标记存活对象
3. **重新标记**：重新标记（STW，修正并发标记期间的变化）
4. **并发清除**：并发清除垃圾对象

**CMS 的问题：**
- 产生 **内存碎片**（浮动垃圾）
- 依赖 CPU 资源
- 内存碎片问题
- JDK14 被移除

---

## 四、JMM（Java Memory Model）

### 4.1 JMM 的核心概念

- **主内存（Main Memory）**：所有实例字段、静态字段、数组元素共享
- **工作内存（Working Memory）**：每个线程私有，存储工作变量的副本

**happens-before 原则：**

| 规则 | 说明 |
|------|------|
| 程序顺序规则 | 一个线程中的每个操作 **happens-before** 该线程之后的任意操作 |
| 监视器规则 | 对同一锁的 **lock** 操作 happens-before 于后续对同一锁的 unlock |
| 传递性 | 若 A happens-before B，B happens-before C，则 A happens-before C |
| volatile 规则 | volatile 写 **happens-before** 于后续对同一变量的读 |
| 线程启动规则 | Thread.start() happens-before 该线程中的每个操作 |
| 终值规则 | 对象构造的结束 happens-before finalize() 的开始 |

### 4.2 volatile 关键字

**volatile 的三大特性：**

| 特性 | 是否保证 | 说明 |
|------|---------|------|
| 可见性 | ✅ | 一个线程修改 volatile 变量，其他线程立即可见 |
| 有序性 | ✅ | 禁止指令重排序 |
| 原子性 | ❌ | **i++** 操作不保证原子性 |

**volatile 的内存语义实现：**
- 写 volatile 变量：**Store** 内存屏障（StoreStore + StoreLoad）
- 读 volatile 变量：**Load** 内存屏障（LoadLoad + LoadStore）

**volatile 的应用场景：**
- 状态标志位（**开关/标志位**）
- 单例模式的双重检查锁定（DCL）
- 观察者模式的通知标志

### 4.3 synchronized 的内存语义

**synchronized 保证：**
- **原子性**（原子性）
- **可见性**（可见性，通过 Monitor 的释放前刷新、获取前刷新实现）
- **有序性**（有序性，禁止指令重排）

**synchronized 的锁升级过程：**

```
无锁 → 偏向锁 → 轻量级锁 → 重量级锁
```

**锁升级过程：**

1. 无锁 → 偏向锁：当只有一个线程访问时，对象头记录 **线程 ID**，后续该线程无需同步
2. 偏向锁 → 轻量级锁：当另一个线程尝试获取锁时，偏向锁通过 CAS 操作升级，失败则 **自旋**
3. 轻量级锁 → 重量级锁：自旋超过 **10** 次（默认 10 次），升级为重量级锁
4. 重量级锁：线程阻塞，依赖 OS 的 **互斥量（Mutex Lock）** 机制

**对象头（Mark Word）在不同状态下的结构：**

| 锁状态 | 对象头内容 |
|--------|-----------|
| 无锁/偏向锁 | 对象 hashcode、年龄、偏向锁标志 |
| 轻量级锁 | 指向栈中 **锁记录（Lock Record）** 的指针 |
| 重量级锁 | 指向堆中 **Monitor 对象** 的指针 |

---

## 五、JVM 调优

### 5.1 常用 JVM 参数

**堆内存参数：**

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `-Xms` | 初始堆大小 | **物理内存的 1/64** |
| `-Xmx` | 最大堆大小 | **物理内存的 1/4** |
| `-Xmn` | 新生代大小 | **堆的 1/3~1/4** |
| `-XX:NewRatio` | 老年代/新生代比例 | **2**（默认 2，即老年代占 2/3） |
| `-XX:SurvivorRatio` | Eden/Survivor 比例 | **8**（默认 8，即 Eden 占 8/10，每个 Survivor 占 1/10） |
| `-XX:MaxTenuringThreshold` | 对象晋升老年代的年龄阈值 | **15** |

**元空间参数：**

| 参数 | 说明 |
|------|------|
| `-XX:MetaspaceSize` | 初始元空间大小，达到后触发 GC |
| `-XX:MaxMetaspaceSize` | 最大元空间大小，防止无限增长 |

**GC 参数：**

| 参数 | 说明 |
|------|------|
| `-XX:+UseG1GC` | 启用 G1 垃圾回收器 |
| `-XX:+UseParallelGC` | 启用 Parallel GC（JDK8 默认） |
| `-XX:MaxGCPauseMillis` | G1 目标停顿时间 |
| `-XX:G1HeapRegionSize` | G1 Region 大小 |
| `-XX:InitiatingHeapOccupancyPercent` | G1 触发并发标记的阈值 |

**诊断与日志参数：**

| 参数 | 说明 |
|------|------|
| `-XX:+PrintGCDetails` | 打印详细 GC 日志 |
| `-XX:+PrintGCDateStamps` | 打印 GC 时间戳 |
| `-XX:+HeapDumpOnOutOfMemoryError` | OOM 时自动 dump 堆 |
| `-XX:HeapDumpPath` | dump 文件保存路径 |
| `-Xlog:gc*:file=gc.log` | JDK9+ 的 GC 日志输出（替代 PrintGCDetails） |

### 5.2 JVM 调优工具链

**JDK 自带工具：**

| 工具 | 用途 | 常用命令/参数 |
|------|------|--------------|
| `jps` | 查看 Java 进程 | `jps -l` |
| `jstat` | 监控 GC 统计信息 | `jstat -gcutil <pid> 1000`（每秒刷新） |
| `jmap` | 堆内存快照 | `jmap -dump:format=b,file=heap.hprof <pid>` |
| `jstack` | 线程快照 | `jstack <pid>` |
| `jcmd` | 综合诊断工具 | `jcmd <pid> GC.heap_dump` |
| `jinfo` | 查看/修改 JVM 参数 | `jinfo -flags <pid>` |

**第三方工具：**

| 工具 | 用途 | 特点 |
|------|------|------|
| **Arthas** | 线上诊断神器 | 阿里开源，支持实时线程监控、CPU 使用率分析、JVM 参数查看 |
| **MAT (Memory Analyzer Tool)** | 堆内存分析 | 内存泄漏检测、对象引用链分析 |
| **JProfiler** | 商业级性能分析 | 实时监控、火焰图、线程分析 |
| **Prometheus + Grafana** | 可视化监控 | Prometheus + Grafana 组合 |

### 5.3 GC 日志解读

**关键指标解读：**

- `Young Usage`：新生代使用率，GC 后应该 **显著下降**
- `Old Usage`：老年代使用率，GC 后应该 **不变或微升**（如果上升说明有对象晋升）
- `Pause Time`：停顿时间，应该控制在 **MaxGCPauseMillis** 以内
- `GC Frequency`：GC 频率，频繁 Minor GC 说明 **新生代** 设置过小

**Full GC 触发条件：**

1. **老年代** 空间不足
2. **元空间** 空间不足
3. **System.gc()** 触发（-XX:+DisableExplicitGC 可关闭）
4. **GC 开销** 统计表明新生代 GC 平均所花时间超过阈值
5. Humongous 分配不足（G1）

### 5.4 JVM 调优实战流程

**调优流程：**

```
第 1 步：发现问题（监控告警 / 用户反馈 / 性能测试）
    ↓
第 2 步：定位问题（使用 jps 找到进程 PID）
    ↓
第 3 步：分析 GC 情况（使用 jstat -gcutil <PID> 1000 观察 GC 频率）
    ↓
第 4 步：判断问题类型
    ├── 频繁 Minor GC → 新生代太小 / 对象生命周期短
    ├── 频繁 Full GC → 堆空间不足 / 内存泄漏
    ├── STW 时间过长 → GC 参数设置不当 / G1 目标停顿时间过短
    └── OOM → 堆内存不足 / 内存泄漏
    ↓
第 5 步：Dump 堆内存（jmap -dump:format=b,file=heap.hprof <PID>）
    ↓
第 6 步：分析堆快照（使用 MAT / JProfiler 分析）
    ↓
第 7 步：调整 JVM 参数 / 修复代码
    ↓
第 8 步：验证调优效果（对比调优前后的 GC 日志、响应时间）
```

### 5.5 典型调优场景

**场景 1：频繁 Full GC**

**排查步骤：**
1. `jstat -gcutil <PID> 1000` 观察老年代使用率变化
2. `jmap -dump` 导出堆快照
3. MAT 分析 **Dominators 视图**（Dominators 视图）
4. 找到 **内存泄漏** 的根源

**调优方向：**
- 增大堆内存：`-Xmx`
- 调整新生代大小：`-Xmn`
- 降低对象晋升老年代的速度：调整 **MaxTenuringThreshold**

**场景 2：OOM（OutOfMemoryError）**

**常见类型：**
- `java.lang.OutOfMemoryError: Java heap space` → **堆内存不足**
- `java.lang.OutOfMemoryError: Metaspace` → **元空间不足**
- `java.lang.OutOfMemoryError: unable to create new native thread` → **线程数过多/操作系统限制**
- `java.lang.OutOfMemoryError: GC overhead limit exceeded` → **GC 开销过大/内存泄漏**

**排查步骤：**
1. 确认 OOM 类型
2. 开启堆 dump：`-XX:+HeapDumpOnOutOfMemoryError`
3. MAT 分析 dump 文件
4. 定位 **内存泄漏点**（Leak Suspects 报告）

**场景 3：STW 时间过长**

**调优方向：**
- 使用 G1：`-XX:+UseG1GC`
- 设置目标停顿时间：`-XX:MaxGCPauseMillis=100`
- 调整 Region 大小：`-XX:G1HeapRegionSize`
- 避免大对象：`-XX:G1HeapRegionSize` 调大或设置 `-XX:LargeObjectRatio`

**场景 4：CPU 使用率飙升**

**排查步骤：**
1. `top` 找到 CPU 占用高的进程 PID
2. `top -Hp <PID>` 找到 CPU 占用高的线程
3. `printf "%x\n" <线程ID>` 转换为十六进制
4. `jstack <PID> | grep <十六进制线程ID>` 定位线程代码
5. 分析代码逻辑（死循环？频繁 GC？）

### 5.6 不同场景的 GC 选择

| 场景 | 推荐 GC 器 | 理由 |
|------|-----------|------|
| 批量处理 / 高吞吐 | Parallel GC | 吞吐量最高 |
| 低延迟 / 交互式应用 | G1 | 停顿时间可控 |
| 低延迟 / 大堆 | ZGC / Shenandoah | 停顿时间 < 10ms |
| 小内存 / 短生命周期 | Serial GC | 无额外开销 |

**ZGC（JDK15+ 生产可用）：**
- 特点：停顿时间 **可预测（< 10ms）**（< 10ms），不受堆大小影响
- 原理：**并发标记** + **读写屏障** + 彩色指针
- 适用场景：大堆（TB 级）+ 低延迟要求

---

## 六、调优实战：从发现问题到解决问题

### 6.1 完整案例

**问题描述：**
某线上服务响应时间从 200ms 飙升到 5s，用户反馈卡顿。

**排查过程：**

```bash
# 第 1 步：查看 Java 进程
jps -l
# 输出：12345 com.example.MyApp

# 第 2 步：监控 GC
jstat -gcutil 12345 1000
# 输出：
#   S0     S1    E      O      M     OC    YGC   YGCT    FGC   FGCT     GCT
#   0.00  50.00  95.00  85.00  90.00  10000  500   2.500   50   15.000   17.500

# 分析：
# - E (Eden) 使用率 95% → 频繁 Minor GC
# - O (Old) 使用率 85% → 接近老年代上限
# - FGC (Full GC) 50 次，耗时 15s → Full GC 频繁且耗时

# 第 3 步：查看线程快照
jstack 12345 > thread.dump
# 分析 thread.dump，发现大量线程 BLOCKED

# 第 4 步：Dump 堆内存
jmap -dump:format=b,file=heap.hprof 12345

# 第 5 步：MAT 分析
# 打开 heap.hprof，查看 Leak Suspects 报告
# 发现大量 com.example.CacheEntry 对象未被释放
# Dominators 视图显示：CacheEntry -> HashMap -> ... -> GC Root

# 第 6 步：定位代码
# 在 CacheEntry 的创建位置打日志，发现：
# com.example.CacheManager.put() 方法没有过期策略，缓存无限增长

# 第 7 步：修复
# 方案 1：添加缓存过期策略（推荐）
# 方案 2：限制缓存大小，使用 LRU 淘汰

# 第 8 步：调整 JVM 参数（临时方案）
# 增大堆内存，降低对象晋升速度
# -Xmx8g -Xmn2g -XX:MaxTenuringThreshold=5

# 第 9 步：验证
# 部署修复后的代码，对比 GC 日志和响应时间
```

### 6.2 调优原则

1. **先监控，后调优**：不要盲目改参数，先通过 jstat/jmap 了解实际情况
2. **一次只改一个参数**：避免多个参数同时变化，无法定位问题
3. **小步快跑，持续验证**：每次调整后观察 GC 日志和响应时间
4. **关注 GC 时间占比**：GC 时间占比应 < 10%，否则需要调优
5. **区分场景**：低延迟场景优先 G1/ZGC，高吞吐场景优先 Parallel GC

---

> 💡 **提示**：对比这份答案版和预习填空笔记，检查哪些空填对了，哪些填错了或填不出。填不出的地方就是你的知识盲区，需要重点复习。
