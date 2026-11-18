# JVM 预习填空卷 · 标准答案

> 📌 对应 `07-JVM预习填空卷.md`（73 题 + 3 思考题），按题号给出标准答案。
> 填错或填不出的题，回看【来源】标注处的原文（画布对应卡片 / 02补充文档章节 / 04讲义章节）。

---

## 第一单元 · JVM 内存结构

| 题号 | 标准答案 |
|------|----------|
| 1 | 线程私有、线程共享 |
| 2 | 程序计数器、虚拟机栈、本地方法栈 |
| 3 | 行号指示器、恢复执行位置 |
| 4 | 栈帧、StackOverflowError |
| 5 | native（本地）、C/C++ |
| 6 | 最大、GC（垃圾回收） |
| 7 | Eden、Survivor0(From)、Survivor1(To)、8:1:1 |
| 8 | Eden、Minor GC |
| 9 | +1、15 |
| 10 | 线程本地分配缓冲（Thread Local Allocation Buffer）、避免多线程分配对象时争抢（分配只动指针/指针碰撞） |
| 11 | 永久代（PermGen）、元空间（Metaspace） |
| 12 | 本地内存 |
| 13 | 堆（中的 Class 对象）、堆 |
| 14 | 堆中的 Class 对象 |
| 15 | ByteBuffer、零拷贝 |
| 16 | StackOverflowError、栈深度、空间 |
| 17 | 对象头、对齐填充、Mark Word（标记字） |
| 18 | 禁用 |

---

## 第二单元 · 类加载机制

| 题号 | 标准答案 |
|------|----------|
| 19 | 验证、准备、解析 |
| 20 | 默认零值、代码里的真实值 |
| 21 | 符号引用、直接引用 |
| 22 | new 对象 / 读写非 final 静态字段 / 反射 Class.forName / 子类初始化触发父类 / main 所在类（任写三种） |
| 23 | static final（编译期常量） |
| 24 | 实例代码块、构造方法 |
| 25 | 类（`<clinit>`）、1（一） |
| 26 | 启动类加载器（Bootstrap）、应用程序类加载器（Application） |
| 27 | 父加载器、下放回子加载器自己加载 |
| 28 | 避免类重复加载、保证核心类库安全（防篡改） |
| 29 | SPI/JDBC、Tomcat（webapp 隔离）、热部署/OSGi |
| 30 | findClass |

---

## 第三单元 · 垃圾回收

| 题号 | 标准答案 |
|------|----------|
| 31 | 引用计数法、可达性分析 |
| 32 | 循环引用、可达性分析 |
| 33 | GC Roots、（虚拟机栈局部变量 / 本地方法栈 JNI 引用 / 类静态变量 / 运行时常量池常量 任写一种） |
| 34 | 软引用、弱引用 |
| 35 | 内存不足、缓存 |
| 36 | GC、ThreadLocalMap（的 Entry key） |
| 37 | null、堆外内存回收通知（配合引用队列） |
| 38 | finalize、一（1）、废弃 |
| 39 | 标记-清除、复制、标记-整理 |
| 40 | 复制、清除、整理 |
| 41 | 低、少量存活 |
| 42 | 新生代、Eden |
| 43 | 老年代空间不足 / 元空间不足 / System.gc() / 空间分配担保失败 / CMS 并发失败（任写三种） |
| 44 | 老年代、晋升平均（历次晋升平均大小） |
| 45 | ParallelGC、G1 |
| 46 | STW（暂停应用线程）、应用线程 |
| 47 | 标记-清除、并发标记、重新标记 |
| 48 | 内存碎片、浮动垃圾 |
| 49 | 浮动 |
| 50 | Region、动态（估算耗时收益后） |
| 51 | -XX:MaxGCPauseMillis、200、期望值（不是硬保证） |
| 52 | 年轻（Eden/Survivor）、老年代（高收益的 Old） |
| 53 | 低 |
| 54 | 小于、染色指针 |
| 55 | Shenandoah、G1 |

---

## 第四单元 · JVM 调优

| 题号 | 标准答案 |
|------|----------|
| 56 | 监控、验证 |
| 57 | jps、jstat、jmap |
| 58 | O、FGC |
| 59 | -XX:+PrintGCDetails（及 -XX:+PrintGCDateStamps、-Xloggc）、-Xlog:gc* |
| 60 | 回收后 |
| 61 | 内存泄漏、堆太小 |
| 62 | MAT（Memory Analyzer Tool）、Dominator（Dominators 支配树） |
| 63 | 溢出 |
| 64 | Java heap space / Metaspace / GC overhead limit exceeded / unable to create new native thread / Direct buffer memory（任写三种） |
| 65 | GC 花费了 98% 以上时间却只回收不到 2% 的内存 |
| 66 | 减小 |
| 67 | -XX:+UseContainerSupport、-XX:MaxRAMPercentage |
| 68 | 丢失、挂载卷（emptyDir/PVC 到 dump 路径） |
| 69 | 5~6G |
| 70 | 容器内熵源不足导致启动慢（随机数阻塞） |

---

## 第五单元 · 版本差异

| 题号 | 标准答案 |
|------|----------|
| 71 | 废弃（警告还能跑）、移除 |
| 72 | -XX:+PrintGCDetails、-Xlog:gc* |
| 73 | 堆（中的 Class 对象） |

---

## 附 · 开放式思考题参考答案要点

**A. 为什么新生代用复制算法、老年代用标记-整理/清除？**
新生代对象绝大多数"朝生夕死"（存活率低），复制算法只需搬运少量存活对象，成本极低，且无碎片；配合 8:1:1 分区，空间浪费仅 10%。老年代存活率高，复制代价大，故用标记-整理（无碎片）或标记-清除（CMS，有碎片）。

**B. 你是用什么命令验证 JDK8 默认 GC 的？**
`java -XX:+PrintCommandLineFlags -version`，输出里能看到 `-XX:+UseParallelGC`。

**C. OOM 后容器重启，去 /dump.hprof 找不到文件，原因和解法？**
原因：dump 文件写在容器可写层，容器重启后丢失。解法：把 HeapDumpPath 指向挂载的持久卷（emptyDir/PVC），或改路径到挂载目录。

---

*配套：`07-JVM预习填空卷.md`（题目）· 原文核对：画布 / `02-JVM补充知识点.md` / `04-JVM总预习讲义.md` · 画布未改动*
