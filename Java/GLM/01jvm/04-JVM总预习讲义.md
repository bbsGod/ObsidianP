# JVM 总预习讲义

> 📌 本讲义综合三处来源，是 JVM 模块的**总纲**：① 你的画布笔记（94 张图，是理解的地基）；② 我梳理的诊断结论；③ 本地模型整理中仍然正确的部分。
> 已剔除已知错误（静态变量位置、程序计数器作用、G1 缺点等），可直接照背。
> 建议用法：先通读一遍建立骨架，再拿 `05-JVM测试考卷.md` 自测，错题回看本讲义对应小节。

---

# 第一单元 · JVM 内存结构

## 1.1 运行时数据区总览

JVM 运行时内存分**线程私有**和**线程共享**两类：

| 区域 | 归属 | 存什么 | 关键点 |
|------|------|--------|--------|
| 程序计数器 | 线程私有 | 当前线程执行的字节码**行号指示器** | 线程切换后靠它恢复执行位置；native 方法时为 undefined；**不会 OOM** |
| 虚拟机栈 | 线程私有 | 栈帧（局部变量表、操作数栈、动态链接、方法出口） | 深度超限抛 StackOverflowError |
| 本地方法栈 | 线程私有 | 为 native 方法服务（C/C++ 实现） | 与虚拟机栈类似，对象是本地方法 |
| 堆 | 线程共享 | 对象实例、数组 | GC 主战场 |
| 方法区 | 线程共享 | 类元信息、运行时常量池 | JDK8 起由**元空间**实现，在**本地内存** |

> ⚠ 高频坑：线程私有区是**三个**（计数器、虚拟机栈、本地方法栈），少答一个就丢分。

## 1.2 堆的内部划分

```
堆 = 新生代（Young） + 老年代（Old）
新生代 = Eden + Survivor0(From) + Survivor1(To)   // 默认 8:1:1
```

- 新对象优先 Eden；Eden 满 → Minor GC，存活对象复制到 Survivor，年龄 +1
- 年龄到阈值（默认 15，`-XX:MaxTenuringThreshold`）→ 晋升老年代
- **TLAB**：每个线程在 Eden 划一块私有分配区，分配对象只动指针（指针碰撞），消除多线程争抢

## 1.3 方法区演进（JDK 7 → 8）⭐必考

| | JDK7 及以前 | JDK8+ |
|--|------------|-------|
| 实现 | 永久代 PermGen（JVM 内存内） | 元空间 Metaspace（**本地内存**） |
| 大小 | -XX:PermSize 固定 | -XX:MaxMetaspaceSize，受本机内存限制 |
| 溢出 | 易 PermGen OOM | 不易（但类加载泄漏仍会吃光内存） |

**JDK8 的拆分（画布反复记的重点，结论是）：**
- static 静态变量 → 移到**堆**中的 Class 对象里
- 字符串常量池 → 移到**堆**

> 一句话记牢：**JDK7 起 static 变量迁出永久代；JDK8 静态变量、字符串常量池都在堆里。** 规范说"静态变量归方法区"是逻辑概念，HotSpot 实现放堆。

## 1.4 直接内存 & 栈溢出

- 直接内存：`ByteBuffer.allocateDirect()`，用本地内存，NIO 零拷贝；不属 JVM 运行时数据区但受 OOM 影响
- 栈溢出（SOFE）：无出口递归；`-Xss` 调栈大小（默认 1M）
- 对比：SOFE 是栈深超限，OOM 是空间不足——一个在栈、一个在堆/元空间

---

# 第二单元 · 类加载机制

## 2.1 类生命周期（五阶段）

```
加载 → 验证 → 准备 → 解析 → 初始化
```

| 阶段 | 做什么 | 易错点 |
|------|--------|--------|
| 加载 | 全限定名取二进制字节流 → 内存生成 Class 对象 | 由类加载器完成 |
| 验证 | 四道检查（文件格式/元数据/字节码/符号引用） | 保证符合 JVM 规范 |
| 准备 | 静态变量**分配内存、赋默认零值** | int=0、引用=null（不是代码里的值） |
| 解析 | 符号引用 → 直接引用 | 可发生在初始化之后（动态绑定） |
| 初始化 | 执行 `<clinit>`：静态变量真实赋值 + 静态代码块 | 触发时机=主动引用 |

**准备 vs 初始化**（必考）：准备给零值，初始化给代码写的真实值。

**符号引用 → 直接引用**（画布通俗版）：编译期不知道类加载到哪块内存，class 文件存字符串 `User.sayHello:()V`（符号引用）；运行到这行时找到内存真实地址替换（直接引用），之后直接跳地址执行。

## 2.2 类初始化顺序（代码题高频）

> 第一次 new 子类：**父静态 → 子静态 → 父实例代码块 → 父构造 → 子实例代码块 → 子构造**
> 静态块只执行一次（类只初始化一次）；实例块每次 new 都执行，且先于构造方法。

## 2.3 主动引用 vs 被动引用

**主动引用（触发初始化）**：① new；② 读写静态字段（非 final 常量）；③ 反射 Class.forName；④ 子类初始化先触发父类；⑤ main 所在类。

**被动引用（不触发）**：读 static final 常量（编译期入常量池）、数组定义 `A[] arr`、子类引用父类静态字段（只初始化父类）。

## 2.4 类加载器 & 双亲委派

**四类加载器**：Bootstrap（核心库 rt.jar）→ Extension（ext 目录）→ Application（classpath）→ 自定义。

**双亲委派**：子加载器先层层向上委托，父能加载就加载，不能才下放回子。
- 两大好处：①避免重复加载；②**安全**——java.lang.String 永远由 Bootstrap 加载，防篡改
- 生活类比：孙子有事找爸爸，爸爸找爷爷，爷爷干不了才自己干

**打破双亲委派**：SPI/JDBC（线程上下文类加载器反向委托）、Tomcat（webapp 隔离，先自己加载）、热部署/OSGi。
**自定义类加载器**：继承 ClassLoader，重写 `findClass()`（不是 loadClass）。

---

# 第三单元 · 垃圾回收

## 3.1 对象存活的判断

**引用计数法**：给对象配计数器，归零回收；**缺陷：无法解决循环引用**（A↔B 互相引用），主流 JVM 不用。

**可达性分析**：从 GC Roots 递归扫描，引用链达不到的即垃圾。
**GC Roots 四种**：虚拟机栈局部变量、本地方法栈 JNI 引用、类静态变量、运行时常量池常量。

**四种引用**（高频）：

| 引用 | 类 | 回收时机 | 应用 |
|------|-----|----------|------|
| 强 | 普通 new | 宁 OOM 不回收 | 普通对象 |
| 软 | SoftReference | **内存不足时** | 缓存 |
| 弱 | WeakReference | 下次 GC 必回收 | ThreadLocalMap 的 key |
| 虚 | PhantomReference | 随时，get 恒 null | 堆外内存回收通知（配引用队列） |

**finalize 自救**：不可达对象若重写 finalize() 且未执行过，有一次自救机会；已废弃（JDK9）。

## 3.2 三种回收算法

| 算法 | 优点 | 缺点 | 应用 |
|------|------|------|------|
| 标记-清除 | 简单、不动对象 | **碎片** | 老年代（CMS） |
| 复制 | 无碎片、快 | 空间减半 | **新生代**（存活率低） |
| 标记-整理 | 无碎片 | 需移动对象、慢 | 老年代 |

> 新生代用复制算法：对象 98% 朝生夕死，只搬活的，成本极低；8:1:1 空间浪费仅 10%。

## 3.3 GC 类型与触发

| 类型 | 范围 | 触发 |
|------|------|------|
| Minor GC | 新生代 | Eden 满（快、频繁、正常） |
| Major GC | 老年代 | 老年代不足 |
| Full GC | 整堆+方法区 | 老年代不足/元空间不足/System.gc()/分配担保失败/CMS 并发失败 |

**空间分配担保**：Minor 前若老年代放不下新生代全部对象，按历次晋升均值担保，没把握就直接先 Full GC。

## 3.4 三大收集器

| | ParallelGC | CMS | G1 |
|--|-----------|-----|----|
| 算法 | 复制+整理 | 标记-清除 | Region 化跨 Region 复制 |
| 停顿 | 全程 STW、长 | 低停顿 | **可预测停顿** |
| 碎片 | 少 | 多 | 无 |
| 定位 | 高吞吐 | 低延迟（已废弃） | 低延迟、服务端默认 |

**JDK 默认 GC 演进**：JDK6/7/8 → ParallelGC（你命令行验证过 `-XX:+UseParallelGC`）；JDK9+ 服务端（≥2核+≥1792M）→ G1，否则 Serial；JDK14+ 移除 CMS。

**并行 vs 并发**（易混，你专门记过）：
- 并行 = STW 暂停所有应用线程，多 GC 线程同时干活
- 并发 = GC 线程和应用线程一起跑，不 STW
- ParallelGC 全程并行无并发；CMS 并发标记+清除；G1 并发标记 + STW 并行拷贝 = 混合型

## 3.5 CMS 详解

**四阶段**：①初始标记（STW，标 GC Roots 直连）→ ②并发标记 → ③重新标记（STW，修正并发期变动）→ ④并发清除。

**四缺点**：①碎片；②并发失败退化为 Serial Old 长停顿；③**浮动垃圾**（并发清除期间新产生的垃圾本轮收不到，需预留空间）；④并发阶段抢 CPU。

## 3.6 G1 详解

- 堆拆成独立小 Region（逻辑分代、物理不分代）
- 可预测停顿：每次 GC 前估算各 Region 回收耗时收益，**动态挑选**回收哪些 Region，控总量
- `-XX:MaxGCPauseMillis`（默认 200ms，期望值非硬保证）
- Mixed GC：一轮同时回收年轻 Region + 部分高收益老年代 Region
- **缺点（标准答案）：吞吐量低于 ParallelGC**（为低延迟做的权衡），Region 维护有额外内存开销

## 3.7 ZGC（加分）

JDK11 引入、15 生产可用；停顿 <1ms 不随堆大小增长；染色指针 + 读屏障。堆 ≤8G 用 G1，超大堆/极致低延迟用 ZGC。

---

# 第四单元 · JVM 调优（你的实战强项）

## 4.1 方法论骨架

```
定目标（吞吐 or 延迟→选收集器）→ 监控 → 定位（决策树）→ 动手 → 验证
```

## 4.2 监控工具链

| 工具 | 作用 | 命令 |
|------|------|------|
| jps | 找进程 | `jps -l` |
| jstat | GC 统计（第一工具） | `jstat -gcutil <pid> 1000` |
| jmap | 堆快照 | `jmap -dump:format=b,file=heap.hprof <pid>` |
| jstack | 线程快照 | `jstack <pid>` |
| jcmd | 综合诊断 | `jcmd <pid> GC.heap_info` |
| Arthas | 线上诊断 | `dashboard` / `thread -n 3` / `heapdump` |

**jstat -gcutil 列**：S0 S1 E O M YGC YGCT FGC FGCT GCT（**O=老年代使用率**，排查 Full GC 看它和 FGC）。

## 4.3 GC 日志解读

- 打印（JDK8）：`-XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:gc.log`
- 打印（JDK9+）：`-Xlog:gc*:file=gc.log:...`（⚠ JDK8 不支持 -Xlog 语法）
- 看一条 Full GC：`Tenured: 6142M->2048M->8192M` = 老年代回收前→后→容量；**回收后仍接近容量=泄漏或堆太小**
- 诊断口径：FGC 持续涨 + O 列不落 → 老年代问题；YGC 频繁但 FGC 少 → Eden 偏小

## 4.4 问题定位决策树

```
频繁 Minor GC → Eden 太小 → 调 -Xmn
频繁 Full GC：
  回收后 O 明显降 → 堆太小/晋升过快 → -Xmx、MaxTenuringThreshold
  回收后 O 不降 → 内存泄漏 → jmap 导堆 → MAT 看 Dominator/Leak Suspects
    → 定位（未关闭资源、长生命周期大对象、无上限缓存）→ 改代码
单次停顿长 → STW 不可控 → 换 G1 + MaxGCPauseMillis
Metaspace 顶满 → 动态类生成（CGLIB）→ 加大上限 / 查类泄漏
```

## 4.5 OOM 类型大全

| OOM | 原因 | 处理 |
|-----|------|------|
| Java heap space | 堆放不下 | -Xmx / MAT 查泄漏 |
| Metaspace | 类元数据超限 | MaxMetaspaceSize / 查类泄漏 |
| GC overhead limit exceeded | 98% 时间 GC 却回收不到 2% | 等价堆耗尽 |
| unable to create new native thread | 线程到系统上限 | **减小** -Xss、降线程、ulimit |
| Direct buffer memory | 直接内存耗尽 | MaxDirectMemorySize |

**泄漏 vs 溢出**：泄漏是原因（该死不死），溢出是结果（装不下）。

## 4.6 容器化 JVM（你的实战区）

- `-XX:+UseContainerSupport`：JDK8u191+ 感知容器 limit（否则按宿主机算默认堆，易被 OOMKilled）
- `-XX:MaxRAMPercentage=75.0`：按容器 limit 比例给堆
- **HeapDumpPath 坑**：容器重启 dump 丢失，必须挂载卷
- `-Djava.security.egd=file:/dev/./urandom`：修容器熵不足启动慢
- `-Dfile.encoding=UTF-8`：信创麒麟乱码

## 4.7 生产参数模板（你的 Docker 12 条精华）

```bash
-Xms1024m -Xmx4096m                 # 容器 limit 要 5~6G，给元空间/栈/native 留量
-XX:MetaspaceSize=128m              # 初始即高水位，避免启动频繁 Full GC
-XX:MaxMetaspaceSize=512m           # 防类加载泄漏吃光内存
-XX:+UseG1GC -XX:MaxGCPauseMillis=200
-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/dump.hprof
```

---

# 第五单元 · 版本差异速查

| 项 | JDK8 | JDK9+ |
|----|------|-------|
| 默认 GC | ParallelGC | G1（条件自动）/Serial |
| 方法区 | 元空间 | 同 |
| 静态变量 | 堆中 Class 对象 | 同 |
| GC 日志 | PrintGCDetails | -Xlog:gc* |
| CMS | 手动可用 | 9~13 废弃，14+ 移除 |
| 偏向锁 | 默认开 | 15 起默认禁 |

---

# 附 · 一分钟速记卡

- 线程私有 3 个：计数器、虚拟机栈、本地方法栈
- JDK8 三件套：元空间（本地内存）、静态变量→堆、字符串常量池→堆
- 类加载五阶段：加载→验证→准备→解析→初始化（准备给零值，初始化给真值）
- 双亲委派两大好处：防重复、保安全；打破靠 findClass / 线程上下文
- GC 判断：引用计数（循环引用死穴）→ 可达性分析（GC Roots 四种）
- 四种引用：强软弱虚，软=内存不足才收，弱=GC 就收
- 新生代复制、老年代整理、CMS 清除（碎片）
- CMS 四阶段：初始标记→并发标记→重新标记→并发清除
- G1 = Region + 可预测停顿 + Mixed GC；缺点=吞吐低于 Parallel
- ParallelGC 全程 STW 高吞吐；CMS 低停顿已废；G1 服务端默认
- 频繁 Full GC：jstat 看 O 列 → 不降=泄漏（jmap+MAT），降=堆小
- 泄漏是原因，溢出是结果

---

*配套：`05-JVM测试考卷.md`（自测）+ `06-JVM考卷答案解析.md`（对答案）· 画布未改动*
