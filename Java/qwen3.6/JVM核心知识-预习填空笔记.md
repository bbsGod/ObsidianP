# JVM 核心知识 · 预习填空笔记

> 📌 **使用说明**：空白处（下划线）需要你自己填写，这是引发你自主思考的关键。不要看答案先填空！

---

## 一、JVM 内存模型

### 1.1 JVM 内存区域的划分

JVM 内存模型分为 **线程私有区域** 和 **线程共享区域** 两大类：

**线程私有区域（每个线程独立）：**
- `______`：存储局部变量、方法出口、栈帧（栈帧包含局部变量表、操作数栈、动态链接、方法出口）
- `______`：线程安全，无需垃圾回收，主要用于字节码编译优化

**线程共享区域（所有线程共享）：**
- `______`：JVM 管理的最大内存区域，存储 `new` 出来的对象和数组
- `______`（JDK8 及之后）：存储类信息、常量、静态变量、即时编译后的代码
- `______`（JDK7 及之前叫"永久代"）：存储字符串常量池

**直接内存（Direct Memory）：**
- 不属于 JVM 运行时数据区，但会被 OOM 影响
- 通过 `______` 类操作，避免 Java 堆到 Native 缓冲区的拷贝

### 1.2 堆的内部划分（重点！）

堆分为：

```
堆（Heap）
├── Eden 区（新生代）：新创建的对象主要分配在这里
├── Survivor 区（新生代）
│   ├── S0（From 区）
│   └── S1（To 区）
└── 老年代（Old Gen）
```

**对象分配流程（填空）：**

1. 新对象创建时，优先在 `______` 分配内存
2. 如果 Eden 满了，触发 `______`（Minor GC）
3. 存活对象被复制到 `______` 区，年龄 +1
4. 当对象年龄达到 `______`（默认 15，可配置）时，晋升到老年代
5. 大对象直接分配到 `______`（如果超过 G1 的 Humongous 阈值）

**TLAB（Thread Local Allocation Buffer）：**
- 作用：每个线程在 Eden 中分配一块私有内存区域
- 目的：避免多线程同时分配对象时的 `______` 问题
- 通过 `______` 参数开启/关闭

### 1.3 元空间 vs 永久代

| 对比项 | 永久代（JDK7 及之前） | 元空间（JDK8 及之后） |
|--------|----------------------|----------------------|
| 内存限制 | 固定大小（-XX:PermSize） | `______`（使用本地内存） |
| 默认大小 | 较小 | `______` |
| 内存溢出风险 | `______` | 较低（受本机内存限制） |

**元空间常用参数：**
- `-XX:MetaspaceSize`：初始大小，达到后触发 GC
- `-XX:MaxMetaspaceSize`：最大大小，防止无限增长

---

## 二、类加载机制

### 2.1 类加载的五个阶段

```
加载 → 验证 → 准备 → 解析 → 初始化
```

**阶段详解（填空）：**

**（1）加载（Loading）：**
- 通过类的全限定名获取定义此类的 `______`
- 在内存中生成该类的 `______`
- 创建 `java.lang.Class` 对象

**（2）验证（Verification）：**
- 确保 Class 文件的字节流信息符合 JVM 要求
- 包括：文件格式验证、元数据验证、字节码验证、符号引用验证

**（3）准备（Preparation）：**
- 为 `______` 变量分配内存并设置 `______` 默认值
- 注意：这里只处理静态变量，不处理实例变量
- 默认值：int=0, long=0, reference=`______`

**（4）解析（Resolution）：**
- 将常量池中的 `______` 引用替换为 `______` 引用
- 符号引用：以一组符号描述的引用（字符串形式）
- 直接引用：直接指向目标的指针/偏移量/句柄

**（5）初始化（Initialization）：**
- 执行 `______` 方法（类构造器）
- 执行 `______` 方法（实例构造器，构造器）
- 线程安全：JVM 保证 `<clinit>` 方法的线程安全（类加载机制保证）

### 2.2 类加载器

**JVM 内置的类加载器：**

| 类加载器 | 职责 | 加载哪些类 |
|----------|------|-----------|
| `______` | 核心库 | rt.jar 中的类（如 java.lang.*） |
| `______` | 扩展库 | ext 目录下的扩展包 |
| `______` | 应用程序 | classpath 下的类（应用自己的类） |
| `______` | 自定义 | 用户自定义的类加载器 |

**双亲委派模型（重点！填空）：**

**工作流程：**
当一个类加载器收到类加载请求时，先把请求委派给 `______` 类加载器处理
- 顶层的 Bootstrap 先处理
- 如果 Bootstrap 无法处理，才由 `______` 尝试处理
- 依此类推，最终由最底层的 `______` 尝试加载

**为什么要用双亲委派？**
1. 保证核心类的 `______`（如 java.lang.String 不会被篡改）
2. 避免类重复加载

**打破双亲委派模型的场景：**

| 场景 | 说明 |
|------|------|
| `______` | 通过 SPI 机制（如 JDBC Driver） |
| `______` | 每个 Web 应用需要独立的类加载器隔离 |
| `______` | 代码热替换、OSGi 框架 |
| `______` | 字节码增强（如 ASM、Javassist） |

---

## 三、垃圾回收算法与回收器

### 3.1 判断对象是否存活

**可达性分析算法（GC Roots）：**

从 `______` 出发，沿着引用链向下搜索，搜索不到的对象即为不可达（可回收）。

**GC Roots 包括：**
- 虚拟机栈（栈帧中的局部变量表）中引用的对象
- 方法区中类静态属性引用的对象
- 方法区中常量引用的对象
- 本地方法栈中 JNI 引用的对象

### 3.2 四种引用类型（JDK7 新增）

| 引用类型 | 说明 | 回收时机 |
|----------|------|---------|
| `______` 引用 | `new` 出来的对象，非 GC 不能回收 | Full GC 或 Mixed GC |
| `______` 引用 | `java.lang.ref.SoftReference`，内存不足时回收 | OOM 之前 |
| `______` 引用 | `java.lang.ref.WeakReference`，下次 GC 时回收 | Minor GC |
| `______` 引用 | `java.lang.ref.PhantomReference`，最弱，必须配合引用队列 | 任意 GC |

**应用：**
- 软引用：`______` 缓存实现
- 弱引用：`______` 与类加载器结合防止内存泄漏

### 3.3 垃圾回收算法

| 算法 | 优点 | 缺点 | 应用区域 |
|------|------|------|---------|
| 标记-清除 | 无需移动对象 | 产生 `______`，效率低 | 老年代 |
| 复制算法 | 无碎片，效率高 | 内存减半 | `______` |
| 标记-整理 | 无碎片 | 效率较低 | `______` |

### 3.4 垃圾回收器

**JDK8 默认 GC 器：`______`（Parallel Scavenge + Parallel Old）**

**G1 回收器（JDK9+ 默认）：**

G1 将堆划分为多个 `______`（Region），每个 Region 大小相同（1~32MB）

**Region 类型：**
- Eden Region：新对象分配
- Survivor Region：GC 后存活对象
- Old Region：老年代对象
- `______` Region：大对象直接分配的 Region（超过 Region 大小 50%）

**G1 的三色标记算法：**
- 白色：未标记对象
- 灰色：正在标记对象
- 黑色：标记完成对象
- 记忆卡（Remembered Set）：用于追踪 `______` 引用（跨 Region 引用）

**G1 的 GC 类型：**
- `______`：仅清理 Eden + Survivor，类似 Minor GC
- `______`：清理 Eden + Survivor + Old 中 GC 效率最高的 Region
- `______`： Full GC，清理整个堆

**G1 调优参数：**
- `-XX:MaxGCPauseMillis`：目标 GC 停顿时间（默认 200ms）
- `-XX:G1HeapRegionSize`：Region 大小（默认自动选择）
- `-XX:InitiatingHeapOccupancyPercent`：触发并发标记的堆占用百分比

**CMS 回收器（已被遗弃）：**

CMS 基于 `______` 算法，目标是最短 GC 停顿时间

**CMS 的四个步骤：**
1. `______`：标记 GC Roots 可达对象（STW）
2. `______`：并发标记存活对象
3. `______`：重新标记（STW，修正并发标记期间的变化）
4. `______`：并发清除垃圾对象

**CMS 的问题：**
- 产生 `______`（浮动垃圾）
- 依赖 CPU 资源
- 内存碎片问题
- JDK14 被移除

---

## 四、JMM（Java Memory Model）

### 4.1 JMM 的核心概念

JMM 定义了线程与主内存的交互方式：

- `______`：所有实例字段、静态字段、数组元素共享
- `______`：每个线程私有，存储工作变量的副本

**happens-before 原则（填空）：**

| 规则 | 说明 |
|------|------|
| 程序顺序规则 | 一个线程中的每个操作 `______` 该线程之后的任意操作 |
| 监视器规则 | `______` 操作 happens-before 于后续对同一锁的 unlock |
| 传递性 | 若 A happens-before B，B happens-before C，则 A happens-before C |
| volatile 规则 | volatile 写 `______` 于后续对同一变量的读 |
| 线程启动规则 | Thread.start() happens-before 该线程中的每个操作 |
| 终值规则 | 对象构造的结束 happens-before finalize() 的开始 |

### 4.2 volatile 关键字

**volatile 的三大特性：**

| 特性 | 是否保证 | 说明 |
|------|---------|------|
| 可见性 | ✅ | 一个线程修改 volatile 变量，其他线程立即可见 |
| 有序性 | ✅ | 禁止指令重排序 |
| 原子性 | ❌ | `______` 操作不保证原子性 |

**volatile 的内存语义实现：**
- 写 volatile 变量：`______` 内存屏障（StoreStore + StoreLoad）
- 读 volatile 变量：`______` 内存屏障（LoadLoad + LoadStore）

**volatile 的应用场景：**
- 状态标志位（`______`）
- 单例模式的双重检查锁定（DCL）
- 观察者模式的通知标志

### 4.3 synchronized 的内存语义

**synchronized 保证：**
- `______`（原子性）
- `______`（可见性，通过 Monitor 的释放前刷新、获取前刷新实现）
- `______`（有序性，禁止指令重排）

**synchronized 的锁升级过程（JDK6+）：**

```
无锁 → 偏向锁 → 轻量级锁 → 重量级锁
```

**锁升级过程（填空）：**

1. 无锁 → 偏向锁：当只有一个线程访问时，对象头记录 `______`，后续该线程无需同步
2. 偏向锁 → 轻量级锁：当另一个线程尝试获取锁时，偏向锁通过 CAS 操作升级，失败则 `______`
3. 轻量级锁 → 重量级锁：自旋超过 `______` 次（默认 10 次），升级为重量级锁
4. 重量级锁：线程阻塞，依赖 OS 的 `______` 机制

**对象头（Mark Word）在不同状态下的结构：**

| 锁状态 | 对象头内容 |
|--------|-----------|
| 无锁/偏向锁 | 对象 hashcode、年龄、偏向锁标志 |
| 轻量级锁 | 指向栈中 `______` 的指针 |
| 重量级锁 | 指向堆中 `______` 的指针 |

---

## 五、JVM 调优（核心！）

### 5.1 常用 JVM 参数（必须记住！）

**堆内存参数：**

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `-Xms` | 初始堆大小 | `______`（物理内存的 1/64） |
| `-Xmx` | 最大堆大小 | `______`（物理内存的 1/4） |
| `-Xmn` | 新生代大小 | `______`（通常设为堆的 1/3~1/4） |
| `-XX:NewRatio` | 老年代/新生代比例 | `______`（默认 2，即老年代占 2/3） |
| `-XX:SurvivorRatio` | Eden/Survivor 比例 | `______`（默认 8，即 Eden 占 8/10） |
| `-XX:MaxTenuringThreshold` | 对象晋升老年代的年龄阈值 | `______` |

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
| `______` | 线上诊断神器 | 阿里开源，支持实时线程监控、CPU 使用率分析、JVM 参数查看 |
| `______` | 堆内存分析 | 内存泄漏检测、对象引用链分析 |
| `______` | 商业级性能分析 | 实时监控、火焰图、线程分析 |
| `______` | 可视化监控 | Prometheus + Grafana 组合 |

### 5.3 GC 日志解读（重点！）

**GC 日志示例（G1）：**

```
[2024-01-01T10:00:00.000+0800]: GC(0) Pause Young (Normal) (Minor GC)
  - Young Usage: 50.00% -> 10.00%
  - Old Usage: 30.00% -> 30.00%
  - 0.100ms
```

**关键指标解读（填空）：**

- `Young Usage`：新生代使用率，GC 后应该 `______`
- `Old Usage`：老年代使用率，GC 后应该 `______`（如果上升说明有对象晋升）
- `Pause Time`：停顿时间，应该控制在 `______` 以内
- `GC Frequency`：GC 频率，频繁 Minor GC 说明 `______` 设置过小

**Full GC 触发条件：**

1. `______` 空间不足
2. `______` 空间不足
3. `______` 触发（-XX:+DisableExplicitGC 可关闭）
4. `______` 统计表明新生代 GC 平均所花时间超过阈值
5. Humongous 分配不足（G1）

### 5.4 JVM 调优实战流程（核心！）

**调优流程（填空）：**

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

**现象：**
- GC 日志显示 Full GC 频繁触发
- 老年代使用率持续高位

**排查步骤：**
1. `jstat -gcutil <PID> 1000` 观察老年代使用率变化
2. `jmap -dump` 导出堆快照
3. MAT 分析 `______`（Dominators 视图）
4. 找到 `______` 的根源

**调优方向：**
- 增大堆内存：`-Xmx`
- 调整新生代大小：`-Xmn`
- 降低对象晋升老年代的速度：调整 `______`

**场景 2：OOM（OutOfMemoryError）**

**常见类型：**
- `java.lang.OutOfMemoryError: Java heap space` → `______`
- `java.lang.OutOfMemoryError: Metaspace` → `______`
- `java.lang.OutOfMemoryError: unable to create new native thread` → `______`
- `java.lang.OutOfMemoryError: GC overhead limit exceeded` → `______`

**排查步骤：**
1. 确认 OOM 类型
2. 开启堆 dump：`-XX:+HeapDumpOnOutOfMemoryError`
3. MAT 分析 dump 文件
4. 定位 `______`（Leak Suspects 报告）

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
- 特点：停顿时间 `______`（< 10ms），不受堆大小影响
- 原理：`______` + `______` + 彩色指针
- 适用场景：大堆（TB 级）+ 低延迟要求

---

## 六、JVM 调优 · 速查表

### 6.1 参数速查

```bash
# 基础堆设置
java -Xms4g -Xmx4g -Xmn1g -jar app.jar

# 元空间设置
java -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=512m -jar app.jar

# G1 调优
java -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -jar app.jar

# GC 日志
java -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:gc.log -jar app.jar

# JDK9+ GC 日志
java -Xlog:gc*:file=gc.log:time,uptime:filecount=5,filesize=100m -jar app.jar

# OOM 时自动 dump
java -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./dump.hprof -jar app.jar
```

### 6.2 监控命令速查

```bash
# 查看 Java 进程
jps -l

# 监控 GC（每秒刷新）
jstat -gcutil <PID> 1000

# 查看线程快照
jstack <PID> > thread.dump

# 堆内存快照
jmap -dump:format=b,file=heap.hprof <PID>

# 查看 JVM 参数
jinfo -flags <PID>

# 使用 Arthas（推荐！）
java -jar arthas-boot.jar
# 选择进程后：
# jvm 命令：查看 JVM 信息
# thread -n 3：查看 CPU 占用最高的 3 个线程
# dashboard：实时监控面板
# gc：查看 GC 情况
# vmtool：查看堆内对象
```

---

## 七、自检清单

在空白处打勾，确认每个知识点是否真正掌握：

### JVM 内存模型
- [ ] 能画出 JVM 内存区域的完整划分图
- [ ] 能说出堆的内部划分（Eden/Survivor/Old）
- [ ] 能解释 TLAB 的作用
- [ ] 能说出元空间和永久代的区别

### 类加载机制
- [ ] 能画出类加载的五个阶段
- [ ] 能解释双亲委派模型的工作流程
- [ ] 能说出打破双亲委派的场景
- [ ] 能解释准备阶段和初始化阶段的区别

### 垃圾回收
- [ ] 能解释三色标记算法
- [ ] 能说出 G1 的 Region 类型
- [ ] 能说出 CMS 的四个步骤
- [ ] 能区分 Minor GC / Major GC / Full GC

### JMM
- [ ] 能解释 volatile 的三大特性
- [ ] 能列出 happens-before 原则
- [ ] 能画出锁升级过程
- [ ] 能解释 synchronized 的内存语义

### JVM 调优
- [ ] 能说出常用 JVM 参数
- [ ] 能看懂 GC 日志
- [ ] 能使用 jstat/jmap/jstack
- [ ] 能说出调优实战流程
- [ ] 能处理典型调优场景（Full GC / OOM / STW）

---

> 💡 **提示**：这份笔记的填空部分是你 JVM 知识的薄弱环节，建议：
> 1. 先看答案填空（答案在我发的下一份详细笔记中）
> 2. 遮住答案，自己尝试填写
> 3. 填不出的地方就是你的知识盲区，重点复习
> 4. 对照自检清单，确保每个知识点都真正掌握
