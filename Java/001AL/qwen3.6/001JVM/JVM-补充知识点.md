# JVM 补充知识点

> 📌 以下内容在预习填空笔记中未覆盖或覆盖不足，但面试和实战中非常重要。

---

## 一、对象内存布局（补充！高频考点）

### 1.1 对象在内存中的结构

Java 对象在堆中的内存布局分为三个部分：

```
┌─────────────────────────────────────────┐
│  对象头（Header）     8~16 字节          │  ← 必须存在
│    - Mark Word（标记字）                 │
│    - Class Pointer（类元数据指针）       │
│    - Array Length（数组长度，仅数组）     │
├─────────────────────────────────────────┤
│  实例数据（Instance Data）  对齐填充      │  ← 实际对象数据
├─────────────────────────────────────────┤
│  对齐填充（Padding）    0~7 字节          │  ← 可选
└─────────────────────────────────────────┘
```

**三部分说明：**

| 部分 | 大小 | 说明 |
|------|------|------|
| **对象头** | 8~16 字节 | 必须存在，包含运行时元数据 |
| **实例数据** | 不定 | 对象真正有效的信息，最占空间 |
| **对齐填充** | 0~7 字节 | JVM 自动填充，因为要求对象起始地址必须是 8 字节的整数倍 |

### 1.2 Mark Word 的结构（重点！）

Mark Word 在不同锁状态下的布局不同：

**32 位 JVM 下 Mark Word 结构：**

| 锁状态 | 31-32 bit | 30 bit | 29-25 bit | 24-1 bit |
|--------|----------|--------|----------|---------|
| 无锁 | 01 | 年龄 | hashcode | 对象数据 |
| 偏向锁 | 10 | 线程ID（23 bit） | epoch | 年龄 |
| 轻量级锁 | 00 | 指向栈中锁记录的指针 | — | — |
| 重量级锁 | 10 | 指向堆中 Monitor 对象的指针 | — | — |
| GC 标记 | 11 | — | — | — |

**64 位 JVM 下 Mark Word 结构（压缩指针开启时）：**

| 锁状态 | 63-62 bit | 61 bit | 60-53 bit | 52-0 bit |
|--------|----------|--------|----------|---------|
| 无锁 | 01 | 年龄 | hashcode | 对象数据 |
| 偏向锁 | 10 | 线程ID（54 bit） | epoch | 年龄 |
| 轻量级锁 | 00 | 指向栈中锁记录的指针 | — | — |
| 重量级锁 | 10 | 指向堆中 Monitor 对象的指针 | — | — |

### 1.3 对象分配策略（补充！）

| 策略 | 说明 |
|------|------|
| **栈上分配** | 通过逃逸分析，对象未逃出方法时分配在栈上，方法结束自动回收 |
| **TLAB 分配** | 每个线程在 Eden 中分配私有区域，避免竞争 |
| **直接分配到大对象区域** | 大对象（如大数组）直接分配到老年代或 Humongous Region |
| **长生命周期对象** | 长期存活的对象直接分配到老年代 |

---

## 二、JIT 编译与逃逸分析（补充！进阶考点）

### 2.1 JIT 编译概述

JVM 中的代码执行分为两种模式：

| 模式 | 说明 |
|------|------|
| **解释执行** | 逐条解释执行字节码，速度慢 |
| **JIT 编译** | 将热点代码编译为本地机器码，速度快 |

**C1 vs C2 编译器：**

| 编译器 | 定位 | 适用场景 |
|--------|------|---------|
| **C1（Client Compiler）** | 侧重快速编译，优化较少 | 客户端应用、内存受限场景 |
| **C2（Server Compiler）** | 侧重性能优化，编译耗时更长 | 服务端应用、高吞吐场景 |

**JDK8 默认使用哪个编译器？**
- Server 模式（默认）：`-server` → 使用 **C2** 编译器
- Client 模式：`-client` → 使用 **C1** 编译器

### 2.2 逃逸分析（Escape Analysis）

**什么是逃逸分析？**

JVM 分析新创建的对象是否会被方法外部访问。

**两种逃逸状态：**

| 状态 | 说明 |
|------|------|
| **全局逃逸** | 对象引用被 static 修饰、或在方法外线程中可见 |
| **方法逃逸** | 对象引用被方法返回、或在方法内传递但未被局部变量持有 |
| **无逃逸** | 对象仅在方法内可见，方法结束即销毁 |

**JIT 基于逃逸分析的优化：**

| 优化技术 | 说明 |
|----------|------|
| **锁消除（Lock Elimination）** | 检测到对象无逃逸时，消除 synchronized 锁 |
| **栈上分配（Stack Allocation）** | 检测到对象无逃逸时，分配在栈上，随栈帧销毁而回收 |
| **标量替换（Scalar Replacement）** | 将对象拆分为基本类型（标量），不创建对象实例 |

**锁消除示例：**

```java
// 这段代码中的 synchronized 会被 JIT 消除，因为 sb 无逃逸
public void noEscape() {
    StringBuilder sb = new StringBuilder();
    synchronized (sb) {
        sb.append("hello");
    }
}

// 这段代码中的 synchronized 不会被消除，因为 sb 逃逸了
public StringBuilder escape() {
    StringBuilder sb = new StringBuilder();
    synchronized (sb) {
        sb.append("hello");
    }
    return sb; // sb 逃逸到方法外
}
```

### 2.3 方法内联（Method Inlining）

**什么是方法内联？**

JIT 将方法调用直接替换为方法体，消除方法调用的开销。

**方法内联的好处：**
- 消除方法调用开销（压栈/出栈）
- 为其他优化（如逃逸分析、常量传播）创造条件
- 减少分支预测失败

**内联失败的场景：**
- 方法体过大
- 方法被动态替换（如接口实现）
- 方法有 synchronized 修饰
- 方法有递归调用

---

## 三、SafePoint 与 STW（补充！）

### 3.1 SafePoint 机制

**什么是 SafePoint？**

SafePoint 是 JVM 中代码可能停下来的位置，JVM 可以在这些点触发 GC 或执行其他操作。

**SafePoint 的位置：**
- 方法返回处
- 跳转指令处（循环回跳）
- 方法调用处

**为什么 GC 需要 SafePoint？**
- GC 需要知道所有线程的状态，SafePoint 是线程暂停的"安全位置"
- 在 SafePoint，对象的引用关系是确定的

### 3.2 Stop-The-World（STW）的本质

**STW 触发的场景：**

| 场景 | 说明 |
|------|------|
| **Full GC** | 所有 GC 线程停止，所有应用线程暂停 |
| **类加载** | 验证阶段可能需要 STW |
| **偏向锁撤销** | 撤销偏向锁时需要 STW |
| **SafePoint 挂起** | 请求线程在 SafePoint 处挂起目标线程 |

**STW 时间的优化方向：**
- 使用 G1/ZGC 减少 STW 时间
- 调整 `-XX:MaxGCPauseMillis` 目标停顿时间
- 避免大对象分配（Humongous）
- 使用 `-XX:+ParallelRefProcEnabled` 并行处理引用处理器

---

## 四、G1 的高级特性（补充！）

### 4.1 G1 的并发标记机制

**G1 使用 SATB（Snapshot-At-The-Beginning）标记算法：**

| 算法 | 说明 |
|------|------|
| **SATB** | 记录标记开始时对象的引用关系，未出现在新引用关系中的对象被回收 |
| **增量标记** | 标记过程中可以并发处理引用关系，减少 STW |

**SATB vs CMS 的并发标记区别：**

| 对比项 | CMS | G1 |
|--------|-----|----|
| 标记算法 | 增量更新（Incremental Update） | SATB |
| 并发标记期间新创建的对象 | 可能漏标 | 通过 SATB 保证不遗漏 |
| 重新标记 STW 时间 | 较长 | 较短 |

### 4.2 G1 的 Remembered Set（记忆卡）

**为什么需要 Remembered Set？**

G1 需要追踪**跨 Region 引用**（老年代 Region 引用新生代 Region），否则无法准确判断对象存活。

**Remembered Set 的实现：**

| 结构 | 说明 |
|------|------|
| **Card Table** | 将堆划分为 256 字节的 Card，每个 Region 维护自己的 Card Table |
| **Remembered Set** | 记录引用该 Region 的源 Region 集合 |

**写屏障（Write Barrier）的作用：**

当对象引用关系发生变化时（如 `a.field = b`），写屏障负责更新 Remembered Set。

---

## 五、线程池深入（补充！与 JVM 调优密切相关）

### 5.1 线程池核心参数

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

### 5.2 工作队列类型

| 队列类型 | 说明 | 适用场景 |
|----------|------|---------|
| **ArrayBlockingQueue** | 有界数组队列 | 需要控制最大并发数 |
| **LinkedBlockingQueue** | 有界/无界链表队列（默认 Integer.MAX_VALUE） | 吞吐量优先 |
| **SynchronousQueue** | 不存储元素的队列，直接传递 | 高并发、低延迟 |
| **PriorityBlockingQueue** | 优先级队列 | 需要任务优先级 |
| **LinkedTransferQueue** | 无界队列，支持 transfer | 需要生产者-消费者模式 |

### 5.3 拒绝策略

| 策略 | 说明 |
|------|------|
| **AbortPolicy（默认）** | 抛出 `RejectedExecutionException` |
| **CallerRunsPolicy** | 由调用线程执行任务 |
| **DiscardPolicy** | 静默丢弃任务 |
| **DiscardOldestPolicy** | 丢弃最老的任务，执行新任务 |

### 5.4 线程池调优

**线程数设置原则：**

| 任务类型 | 线程数建议 | 说明 |
|----------|-----------|------|
| **CPU 密集型** | N + 1（N 为 CPU 核数） | 减少上下文切换 |
| **IO 密集型** | 2N 或 N / (1 - 阻塞系数) | 阻塞系数 0.8~0.9 |
| **混合型** | 根据任务拆分 | CPU 密集型和 IO 密集型分开 |

---

## 六、CAS 与 AQS 深入（补充！）

### 6.1 CAS 的三大问题

| 问题 | 说明 | 解决方案 |
|------|------|---------|
| **ABA 问题** | 值从 A→B→A，CAS 无法察觉变化 | 使用 `AtomicStampedReference`（带版本号） |
| **自旋开销** | 长时间 CAS 不成功消耗 CPU | 使用 `LockSupport.park()` 挂起线程 |
| **只能保证一个变量** | CAS 只能保证一个共享变量的原子性 | 使用 `AtomicReference` 包装对象 |

### 6.2 AQS（AbstractQueuedSynchronizer）核心原理

**AQS 的核心组件：**

| 组件 | 说明 |
|------|------|
| **volatile int state** | 同步状态，0 表示空闲，>0 表示被占用 |
| **CLH 队列** | FIFO 队列，存放获取锁失败的线程 |
| **acquire()** | 获取锁，失败则入队并挂起 |
| **release()** | 释放锁，唤醒队列后继节点 |

**AQS 的应用：**
- `ReentrantLock`
- `ReentrantReadWriteLock`
- `CountDownLatch`
- `CyclicBarrier`
- `Semaphore`

---

## 七、并发工具类（补充！）

### 7.1 CountDownLatch vs CyclicBarrier vs Semaphore

| 特性 | CountDownLatch | CyclicBarrier | Semaphore |
|------|---------------|---------------|-----------|
| **用途** | 一个或多个线程等待其他线程完成 | 多个线程互相等待 | 控制同时访问的线程数 |
| **可重用** | ❌ 不可重用 | ✅ 可重用 | ✅ 可重用 |
| **核心方法** | `countDown()` / `await()` | `await()` | `acquire()` / `release()` |
| **应用场景** | 初始化完成通知 | 多线程计算结果汇总 | 限流、连接池 |

### 7.2 volatile + double-check 实现单例（DCL）

```java
public class Singleton {
    // volatile 保证可见性和有序性
    private static volatile Singleton instance;
    
    private Singleton() {}
    
    public static Singleton getInstance() {
        // 第一次检查：避免每次获取都加锁
        if (instance == null) {
            synchronized (Singleton.class) {
                // 第二次检查：避免多线程重复创建
                if (instance == null) {
                    instance = new Singleton();
                }
            }
        }
        return instance;
    }
}
```

**为什么需要 volatile？**
- `new Singleton()` 不是原子操作：分配内存 → 初始化 → 引用指向
- 没有 volatile 时，可能发生指令重排，导致其他线程拿到**未完全初始化的对象**
- volatile 禁止指令重排，保证 DCL 的线程安全

---

## 八、ThreadLocal 深入（补充！）

### 8.1 ThreadLocal 内存模型

```
线程 Thread
├── ThreadLocal.ThreadLocalMap map
│   ├── Entry(ThreadLocal弱引用 → Value强引用)
│   └── Entry(ThreadLocal弱引用 → Value强引用)
└── ...
```

### 8.2 ThreadLocal 的内存泄漏

**为什么 ThreadLocal 会导致内存泄漏？**

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
- 使用完 ThreadLocal 后，**必须调用 `remove()` 方法**
- ThreadLocalMap 在 `get()/set()/remove()` 时会清理 key 为 null 的 Entry

---

## 九、类文件结构（补充！）

### 9.1 类文件结构

```
class_file
├── magic_number（魔数：0xCAFEBABE）
├── minor_version（次版本号）
├── major_version（主版本号）
├── constant_pool_count（常量池计数）
├── constant_pool（常量池）
│   ├── CONSTANT_Class（类信息）
│   ├── CONSTANT_Fieldref（字段引用）
│   ├── CONSTANT_Methodref（方法引用）
│   ├── CONSTANT_String（字符串常量）
│   ├── CONSTANT_Integer（整型常量）
│   ├── CONSTANT_Float（浮点常量）
│   ├── CONSTANT_NameAndType（名称和类型）
│   └── ...
├── access_flags（访问标志）
│   ├── public / private / protected
│   ├── final / static / abstract
│   └── ...
├── this_class（当前类索引）
├── super_class（父类索引）
├── interfaces_count（接口数量）
├── interfaces[]（接口列表）
├── fields_count（字段数量）
├── fields[]（字段表）
├── methods_count（方法数量）
├── methods[]（方法表）
│   ├── access_flags
│   ├── name_index
│   ├── descriptor_index
│   └── attributes[]（属性：Code/Exceptions/LineNumberTable等）
└── attributes_count（属性数量）
```

### 9.2 字节码指令分类

| 分类 | 示例指令 | 说明 |
|------|---------|------|
| **常量指令** | ldc, bipush, sipush | 加载常量 |
| **字段指令** | getfield, putfield, getstatic, putstatic | 访问字段 |
| **方法指令** | invokevirtual, invokestatic, invokespecial, invokeinterface | 调用方法 |
| **对象创建** | new, dup | 创建对象 + 复制操作数栈顶 |
| **控制转移** | if_icmpne, goto, tableswitch, lookupswitch | 条件跳转/无条件跳转 |
| **数组操作** | aload, astore, arraylength | 数组访问 |
| **异常处理** | athrow | 抛出异常 |

---

## 十、JVM 安全与沙箱（补充！）

### 10.1 安全管理器（Security Manager）

**作用：** 限制代码对系统的访问权限。

```java
// JDK8 及之前
System.setSecurityManager(new SecurityManager());

// JDK17 移除安全管理器
```

### 10.2 类加载沙箱

| 沙箱 | 说明 |
|------|------|
| **信任类（Bootstrap）** | rt.jar 中的类，无限制访问 |
| **扩展类（Extension）** | ext 目录中的类，有限访问 |
| **应用类（Application）** | classpath 中的类，受安全管理器限制 |

---

## 十一、其他重要知识点（补充！）

### 11.1 方法区 OOM 的原因

| 原因 | 说明 |
|------|------|
| **动态生成大量类** | 使用 CGLIB、Javassist、ASM 等字节码库 |
| **常量池溢出** | String.intern() 大量使用 |
| **Groovy/Scala 动态类** | 动态语言运行时生成大量类 |
| **元空间配置过小** | -XX:MaxMetaspaceSize 设置过小 |

### 11.2 常见 OOM 类型及解决方案

| OOM 类型 | 原因 | 解决方案 |
|----------|------|---------|
| **Java heap space** | 堆内存不足 | 增大 -Xmx / 排查内存泄漏 |
| **Metaspace** | 元空间不足 | 增大 -XX:MaxMetaspaceSize / 减少动态类生成 |
| **unable to create new native thread** | 线程数过多 / 操作系统限制 | 减少线程数 / 增大 ulimit / 增大 -Xss |
| **GC overhead limit exceeded** | GC 开销过大 | 排查内存泄漏 / 增大堆内存 |
| **unable to create new native memory** | Native 内存不足 | 增大 Direct Memory / 排查 ByteBuffer 泄漏 |
| **too many open files** | 文件描述符耗尽 | 增大 ulimit / 关闭未关闭的流 |

### 11.3 JVM 参数调优实战建议

**生产环境推荐参数（JDK8）：**

```bash
# 基础堆设置（根据实际内存调整）
-Xms4g -Xmx4g                    # 堆初始=最大，避免运行时扩容
-Xmn1g                            # 新生代占 1/4
-XX:MetaspaceSize=256m            # 元空间初始值
-XX:MaxMetaspaceSize=512m         # 元空间最大值

# G1 GC
-XX:+UseG1GC
-XX:MaxGCPauseMillis=100          # 目标停顿时间 100ms
-XX:G1HeapRegionSize=4m           # Region 大小（自动选择通常更好）
-XX:InitiatingHeapOccupancyPercent=45  # 降低触发阈值，提前并发标记

# GC 日志
-Xlog:gc*:file=gc.log:time,uptime:filecount=5,filesize=100m

# OOM 时自动 dump
-XX:+HeapDumpOnOutOfMemoryError
-XX:HeapDumpPath=/data/dumps/

# 其他
-XX:+UseStringDeduplication       # G1 字符串去重（减少内存占用）
-XX:+ParallelRefProcEnabled       # 并行处理引用处理器
```

---

> 💡 **总结**：以上补充知识点覆盖了：
> 1. 对象内存布局（Mark Word 结构）
> 2. JIT 编译与逃逸分析
> 3. SafePoint 与 STW
> 4. G1 高级特性（SATB、Remembered Set）
> 5. 线程池深入
> 6. CAS 与 AQS
> 7. 并发工具类
> 8. ThreadLocal 内存泄漏
> 9. 类文件结构与字节码
> 10. JVM 安全与沙箱
> 11. 常见 OOM 类型及解决方案
> 
> 这些内容在面试中属于**中高级考点**，尤其是对象内存布局、JIT 编译、G1 高级特性、线程池调优。
