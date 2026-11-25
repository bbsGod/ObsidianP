# 001OB · Spring家族 模块 · 预习填空题

> 📂 **源资料**
> - **所在路径**：`D:\Works\Interview\004-ObsidianCanvas\ObsidianP\Java`（项目内相对路径 `Java/`）
> - **源文件**：`多线程并发.canvas`
> - **参考模块**：画布顶层分组 `Spring家族`（含其下全部子分组、文本笔记、嵌入图片）
> - **生成日期**：2026-11-20　｜　**画布快照**：基于当日画布内容；画布改动后请对照 `00-源节点覆盖台账.md` 复核

> 📌 基于 `多线程并发.canvas` 画布 Spring家族 模块（含 205 条文本笔记、450 张嵌入图片，已全部读取整理）及外部知识整理。
>
> 📌 每题后标注：⭐ 重要程度 + 来源。目的是让你填空 → 对答案 → 面试能讲出来。
>
> 📌 使用方式：直接做填空 → 对照答案版 → 错题回画布看原笔记。

---

## 模块一 · IOC 容器与 Bean 生命周期

### 1.1 Spring 与 IOC/DI 核心概念

（1）Spring 框架的两大核心思想：IOC 控制反转和 **____AOP____** 面向切面编程。⭐⭐⭐ [来源：画布 Spring主体 `AOP面向切面编程`]

（2）IOC 控制反转：把对象创建和依赖关系管理的控制权，从业务代码转移到 **______容器__**。⭐⭐⭐ [来源：画布 Spring主体 `将对象创建和对象之间依赖关系的控制权，从业务代码转移到容器`]

（3）DI 依赖注入是实现 IOC 的具体方式：容器在创建 Bean 时自动把 Bean 需要的 **___ 依赖_____** 注入进去（setter、构造器、字段注入）。⭐⭐⭐ [来源：画布 Spring主体 `DI 描述的是怎么实现 IOC 的具体方式`]

（4）Spring 生态分工：SpringBoot 快速开发、SpringMVC 处理 Web 请求、**___ springDATA_____** 简化数据库连接、SpringCloud 搭建微服务。⭐⭐ [来源：画布 Spring主体 `丰富的生态`]

### 1.2 Bean 的定义与扫描

（5）Bean 的本质：由 Spring 容器管理的 Java 对象（普通对象是我们自己 new 的）；定义 Bean 的三种方式：注解 @Component、   **___  ？<xml=bea_xml配置文件____**（老项目 bean 标签）、Java 配置 @Configuration + @Bean。⭐⭐⭐ [来源：画布 如何定义bean `Bean 是被交给 Spring 容器来管理` `Bean 的配置⽅式有哪些`]

（6）@Configuration + @Bean 主要用来包装第三方类（DruidDataSource、RedisTemplate），因为这些类 **______ 无法修改 __** 源码，没法加 @Component。⭐⭐⭐ [来源：画布 如何定义bean `使用场景：第三方类，不修改源代码的`]	

（7）@Configuration 类是工厂 Bean，@Bean 方法就是 **___ ？实例---@bean注册的方法是工厂方法_____** 方法，Spring 反射调用它、把返回值注册成 Bean。⭐⭐ [来源：画布 如何定义bean `@Bean 方法是工厂方法`] 

- [ ] （8）包扫描的真正执行者：@ComponentScan 只声明扫描路径，真正解析 @Configuration、@ComponentScan、@Import、@PropertySource 的是 **__ ？配置文件类后置处理器ConfigurationClassPostProcessor 就记成 configclasPostProcessor______**。⭐⭐⭐ [来源：画布 实例化 `真正干活的是 ConfigurationClassPostProcessor`]
  - [ ] configclassPostProcess 好记忆 



（9）扫描完成后，Spring 把类上的注解、类名、scope、是否懒加载、依赖信息等元数据封装成 **___ ？BeanDefinition_____**，存进 BeanFactory 的 beanDefinitionMap。⭐⭐⭐ [来源：画布 bean实例化之前需要扫描、优化，创建bean的后置post处理器 `生成包含bean元信息的Bean定义（BeanDefinition）`]

（10）BeanDefinition 存的是类的 **______ 元数据 __**（beanClass、scope、lazyInit、initMethod、destroyMethod），它不是对象，只是一份"Bean 的图纸"。⭐⭐⭐ [来源：画布 bean实例化之前需要扫描、优化，创建bean的后置post处理器 `BeanDefinition 里面存的是类的元信息`]

### 1.3 Bean 的实例化（4 种方式）  -----BEAN 是豆子的意思 RedBean 红豆

（11）实例化阶段：Spring 通过 **___ 反射 _____** 调用构造方法创建原始对象，此时对象里的属性都还是 **______ null __**。⭐⭐⭐ [来源：画布 实例化过程 `只是调用了 new 来生成，此时对象里面的属性都是 null`]  

- [ ] 运行状态动态的获取对象的方式是反射	

（12）为什么不直接 new：`new` 要求 **____ 编译器 ____** 期就能确定类，而 Spring 是运行时才通过扫描 class、解析注解拿到类信息（类名是字符串解析出来的）。⭐⭐⭐ [来源：画布 实例化过程 `new Xxx() 要求编译期就能确定 Xxx 这个类`]

- [ ] （13）Spring 实例化 Bean 的 4 种方式：构造方法实例化（@Component/@Service）、静态工厂方法（@Bean + static）、实例工厂方法（@Bean 非 static）、**___ ？实现  正确答案：（FactoyrBean）工厂接口_____** 接口实例化。⭐⭐⭐ [来源：画布 实例化过程 `Spring 提供了 4 种方式来实例化 Bean`]
  - [ ] 两个工厂方法都存在配置文件中 ，@configuration ，方法上是@Bean 

  - [ ] bean工厂接口

- [ ] （14）FactoryBean 实例化：容器管理 FactoryBean 本身，调用它的 **___ ？构造方法___正确答案：getObject()__** 方法拿到的对象才是容器里真正使用的 Bean，MyBatis 的 SqlSessionFactory 就是典型。⭐⭐⭐ [来源：画布 实例化过程 `调用它的 getObject() 方法，拿到我们真正需要的目标 Bean 对象`]
  - [ ] bean的实例化通过bean工厂的方式，获取bean的方式是getObject



- [ ] （15）@Bean 实例化的本质：Spring 反射调用 @Bean 标注的方法、方法内部是我们手写的 new，这属于 **______？工厂 __** 方法实例化。⭐⭐ [来源：画布 实例化过程 `这就是【工厂方法实例化】和【构造器实例化】本质区别`]


- [ ] （16）@Import 支持导入三种东西：普通配置类、**___ ？____ImportSelector _** 实现类（动态返回要导入的配置类名数组）、ImportBeanDefinitionRegistrar 实现类（手动注册 BeanDefinition）。⭐⭐⭐ [来源：画布 实例化 `@Import...共支持 3 种导入类型`]


（17）@Import 直接导入普通类的适用场景：**___第三方jar包_____** 的类——改不了源码没法加 @Component，用 @Import 导进来交给容器。⭐⭐ [来源：画布 实例化 `适用场景：第三方 jar 包的类，你改不了源码`]

### 1.4 DI 三种注入方式

（18）DI 三种注入方式中，Spring 官方首选推荐 **___ 构造器 _____** 注入：可以给依赖加 final 保证不可变。⭐⭐⭐ [来源：画布 实例化之后的属性赋值；DI三种注入方式，字段，setter，构造器 `可以加 final，依赖不可变，官方首选推荐`]

（19）类中只有一个构造器时，@Autowired 可以省略——这是 Spring **___ 最新 Srping_____** 4.3+ 的特性。⭐⭐ [来源：画布 实例化之后的属性赋值；DI三种注入方式，字段，setter，构造器 `Spring4.3+，仅有一个构造器时 ，@Autowired 可以省略`]

- [ ] （20）IDEA 不推荐 @Autowired 字段注入的三个原因：不利于 **__？单元测试______**、会隐藏循环依赖问题（构造器注入启动时就暴露）、不能用 final。⭐⭐⭐ [来源：画布 Bean `为什么IDEA不推荐使用@Autowired注解注入Bean`]
  - [ ] 字段注入 ，隐藏循环依赖 、不利于测试



（21）注入时机区分：构造器注入发生在 **__ 实例化______** 阶段（new 对象时把依赖直接传进去）；字段/setter 注入发生在实例化之后的 populateBean 属性填充阶段。⭐⭐⭐ [来源：画布 实例化之后的注入 `构造器注入：注入动作发生在【实例化阶段】`]

（22）实例化与注入的关系：实例化是先把对象 **______ new __** 出来，注入是给对象的属性赋值。⭐⭐⭐ [来源：画布 实例化之后的注入 `注入，是给对象的属性赋值；实例化，是先把对象造出来`]

- [ ] （23）从循环依赖角度：**___？ 字段注入和构造器注入___ 正确答案：构造器 __** 注入无法解决循环依赖，字段/setter 注入可以（靠三级缓存）。⭐⭐⭐ [来源：画布 实例化之后的属性赋值；DI三种注入方式，字段，setter，构造器 `构造器注入无法解决循环依赖，字段 /setter 注入可以（三级缓存）`]


### 1.5 Bean 生命周期完整流程

- [ ] （24）Bean 生命周期的触发入口：IOC 容器 ApplicationContext （应用程序上下文）的 **___ Refresh（）_____** 方法内部（Bean 实例化、完整生命周期都在这里面触发）。⭐⭐⭐ [来源：画布 Bean的生命周期 `是在 IOC 容器ApplicationContext的refresh()方法内部触发的`]


- [ ] （25）refresh 中真正实例化所有非懒加载单例 Bean 的阶段：**______ ？finishBeanFactoryInitialization 完成bean工厂初始化__**。⭐⭐ [来源：画布 Bean的生命周期 `在 refresh 内部的finishBeanFactoryInitialization阶段`]

  - [ ] finish  BeanFactory  Initialization 方法



（26）Bean 生命周期五大阶段：实例化 → **___ DI依赖注入的属性填充 _____** → 初始化 → 使用中 → 销毁。⭐⭐⭐ [来源：画布 Bean `实例化 → 属性赋值 → 初始化 → 使用中 → 销毁`]

- [ ] （27）属性填充阶段（populateBean / DI 依赖注入）：给对象的字段赋值，由 **__ @Autowired ______**、xml 注入等方式完成。⭐⭐⭐ [来源：画布 bean的生命周期 `属性填充（PopulateBean / DI 依赖注入）：给对象的字段赋值（@Autowired、xml 注入）`]
  - [ ] DI的三种方式：构造器、setter、@Autowire字段注入

- [ ] （28）初始化阶段三个回调的执行顺序：先 **__ 注解@PostConstruct（构建）______** 注解方法 → 再 InitializingBean 接口的 afterPropertiesSet() → 最后 init-method指定方法。⭐⭐⭐ [来源：画布 bean的生命周期 `先执⾏ @PostConstruct 标注的⽅法...最后再执⾏ init-method 指定的⽅法`]  
  - [ ] 先注解@PostConstruct---接口---方法
  - [ ] 初始化注解@PostConstruct



- [ ] （29）单例 Bean 销毁阶段在容器关闭时触发，销毁回调顺序：@PreDestroy → **_ PreDestoryBean 正确答案是：（一次性的）DisposabBean_______** 接口的 destroy() → @Bean 的 destroyMethod。⭐⭐⭐ [来源：画布 bean的生命周期 `销毁阶段（Destruction）容器关闭时执行顺序`] 先注解@PreDestroy -接口-destroyMethod

  - [ ] 销毁注解 @PreDestroy



- [ ] （30）实际开发中通常用 @PostConstruct（构造之后） 和 **______注解2：@PreDestroy 销毁之前__** 两个注解就够了，它们最简洁。⭐⭐ [来源：画布 bean的生命周期 `实际开发中，通常⽤ @PostConstruct 和 @PreDestroy 就够了`]


（31）初始化完成后，单例 Bean 就绪放入 **___ 单例池子_____**，之后进入正常使用阶段（业务调用）。⭐⭐⭐ [来源：画布 bean的生命周期 `单例Bean 就绪，放入单例池（singletonObjects）`]

### 1.6 两大后置处理器与高频坑点（含纠错清单）

（32）两大后置处理器区分：BeanFactoryPostProcessor 作用于 **___ BeanDeifne_____**（Bean 还没实例化）；BeanPostProcessor 作用于每个 Bean 实例（初始化前后拦截）。⭐⭐⭐ [来源：画布 生命周期高频坑点 `BeanFactoryPostProcessor：作用于 BeanDefinition，不属于 Bean 实例生命周期`]

- [ ] （33）ConfigurationClassPostProcessor 是 **__？ BeanFactoryPostProcessor  --正确： BeanFactoryPostProcessor______** 的实现类，是 Spring 优先级最高、最先执行的 BeanFactory 后置处理器。⭐⭐⭐ [来源：画布 bean实例化之前需要扫描、优化，创建bean的后置post处理器 `ConfigurationClassPostProcessor（它本身就是一个 BeanFactoryPostProcessor！）`]
  - [ ] 扫描Bean的是bean工厂的后置处理器 



- [ ] （34）BeanFactoryPostProcessor 的执行时机：BeanFactory 就绪之后、Bean 实例还没创建时，在 refresh() 的 **___ ？实例化 _正确：invokeBeanFactoryPostProcessors____** 步骤执行，做包扫描、解析配置类、注册 BeanDefinition。⭐⭐⭐ [来源：画布 两个post后置处理器 `它的工作时机是 BeanFactory 已经就绪、但是 Bean 实例还没有创建的时候`]

  - [ ] invoke是调用给的意思



（35）❌ BeanFactoryPostProcessor 属于 Bean 实例的生命周期？→ ✅ 错。它属于 **___ BeanDefine bean定义阶段_____** 阶段的事情，不属于 Bean 实例生命周期。⭐⭐⭐ [来源：画布 生命周期高频坑点（需纠错）]

- [ ] （36）❌ @PostConstruct 属于构造方法/实例化阶段？→ ✅ 错。@PostConstruct 属于 Bean 的 **__ ？实例化 --正确：初始化 ______** 阶段，构造方法才是实例化。⭐⭐⭐ [来源：画布 生命周期高频坑点（需纠错）`@PostConstruct 属于初始化阶段，不是构造方法`]
  - [ ] bean初始化后置处理器也是AOP功能加强的阶段



（37）单例 Bean 生命周期完全交给 IOC 容器（容器创建、容器销毁）；多例 Bean 容器只负责创建，**___ 销毁_____** 不会被容器调用。⭐⭐⭐ [来源：画布 生命周期高频坑点 `多例 Bean 容器只负责创建...销毁回调不会被容器调用`]

- [ ] （38）BeanPostProcessor 的两个方法：postProcessBeforeInitialization（前置处理）和 ？**___aferBeanPostProcess___  --正确postProcessAfterInitialization__**（后置处理，AOP 代理就在这里生成）。⭐⭐⭐ [来源：画布 bean的生命周期 `BeanPostProcessor 后置处理（postProcessAfterInitialization）👉 AOP 代理就是在这里生成！`]
  - [ ] bean初始化阶段前置处理器  ----- 初始化 ----- 初始化后置处理器



### 1.7 Aware 接口与手写 IOC

- [ ] （39）Aware 接口的本质：一种 **______？回调__** 机制，让 Bean 能感知到容器内部组件，最常用的是 ApplicationContextAware（拿到容器本身）。⭐⭐ [来源：画布 aware接口 `Aware 接口实现了一种"回调"机制`]


- [ ] （40）手写简易 IOC（SimpleIoC）验证 IOC 本质：Map 存 Bean、**___ ？构造器 正确：反射 _____** 完成实例化和 @Autowired 字段赋值（registerBean → inject → getBean 三步）。⭐⭐ [来源：画布 IOC容器类 + 手写ioc]


### 容器体系：ApplicationContext 与 BeanFactory

- [ ] （41）Spring 容器体系的组合关系：高级容器 ApplicationContext 内部组合持有一个 **___ ？默认的DefaultBeanFactory 正确：DefaultListableBeanFactory _____**（低级 Bean 工厂的实现实例，真正干活、存 Bean 的就是它）——refresh() 等容器流程都委托给它执行。⭐⭐⭐ [来源：画布 Bean工厂和IOC容器 `IOC 容器（ApplicationContext）内部持有 Bean 工厂（DefaultListableBeanFactory）` + ApplicationContext 和 DefaultableBeanFactory]
  - [ ] applicationContext 应用程序上下文，  bean工厂 + 附加能力+bean的生命周期
  - [ ] bean工厂实际上干活的类是子类 defaultBeanFactory



（42）BeanFactory 与 ApplicationContext 的能力差异：BeanFactory 是最底层接口，能力极简，**__ 只能获取bean ______**；ApplicationContext 在其之上扩展，提供事件发布、国际化（什么是国际化 难道是英语？）、资源加载、AOP、注解扫描等能力。⭐⭐ [来源：画布 Bean工厂和IOC容器 `能力极简：没有资源加载、事件、国际化、AOP 支持`]

（43）Bean 创建时机的默认差异：BeanFactory 默认 **___ ？懒加载_____**，第一次 getBean 时才实例化；ApplicationContext 则在 refresh 阶段就提前实例化所有单例 Bean，启动更慢但运行时不再卡顿。⭐⭐ [来源：画布 Bean工厂和IOC容器 `默认懒加载…ApplicationContext 提前实例化所有单例 Bean（refresh 阶段就全部创建好）`] （我的疑问：在refresh阶段中不就是包含beanFactory吗 就是bena生命周期中的定义阶段？）

---

## 模块二 · 三级缓存与循环依赖

### 2.1 循环依赖与三级缓存结构

（1）循环依赖：A 注入 B、B 又注入 A。Spring 解决单例 Bean 循环依赖的核心机制是 **___ 三级缓存 _____**。⭐⭐⭐ [来源：画布 三级缓存 `Spring解决循环依赖的核心机制是通过使用三级缓存`]

- [ ] （2）三级缓存三个 Map：一级 **_____ 真忘了记得是个 ？singletonObject___** 存完全初始化好的成熟 Bean；二级 earlySingletonObjects 存提前暴露的半成品 Bean；三级 singletonFactories 存 ObjectFactory 工厂。⭐⭐⭐ [来源：画布 三级缓存 `一级 → 成熟 Bean`]


（3）三级缓存里存的是 **___ ？singeltonFactories_--正确：ObjectFactory____**（对象工厂），不是 Bean 本身——需要被依赖时才调用产出早期引用。⭐⭐⭐ [来源：画布 三级缓存 `三级：ObjectFactory，是一个【对象工厂】，不是Bean本身`]

- [ ] （4）❌ 三个缓存 Map 直接声明在 DefaultListableBeanFactory（这个是真正干活的bean工厂beanFactory） 里？→ ✅ 不精确。它们声明在 DefaultListableBeanFactory 的父类 **__ ？ApplicationContext（应用上下文） 正确：DefaultSingletonBeanRegistry______** 中。⭐ [来源：画布 三级缓存（表述需纠错）`DefaultListableBeanFactory 里面有三个 Map`] [来源：外部 DefaultSingletonBeanRegistry 源码]


### 2.2 三级缓存解决流程

（5）流程起点：A 实例化（反射 new 出原始对象）后，把 A 的 ObjectFactory 放入 **__ 工厂对象 三级级缓存中  ______**，然后进行属性填充。⭐⭐⭐ [来源：画布 三级缓存 `A 实例化（反射得对象），A 的 ObjectFactory 加入三级缓存`]

- [ ] A实例化的时候 放到三级缓存，提前暴漏给B，B拿到三级缓存的工厂对象，调用方法获取A的早期对象，完整初始化

（6）B 属性填充需要 A 时：查三级缓存拿到 A 的 ObjectFactory，调用 getObject() 触发 **___？ 实例化--正确：getEarlyBeanReference _____**，提前生成 A 的代理对象，并把 A 放入二级缓存、从三级缓存移除。⭐⭐⭐ [来源：画布 三级缓存 `objectFactory.getObject()` `查三级缓存 singletonFactories：找到了 A 的 ObjectFactory`]

（7）B 拿到没完工的 A 半成品继续完成自己；A 后面拿到完工的 B，最后 A 自己完工——**___ 流程 _____** 打通，两边都能完成创建。⭐⭐⭐ [来源：画布 三级缓存 `闭环打通了：B 拿到了还没完工的 A 半成品`]

（8）A 拿到 B 继续走完初始化和后续 AOP 步骤时，会判断已经提前生成过代理、**__ 不在重复创建代理 ______**。⭐⭐ [来源：画布 三级缓存 `会判断已经提前生成过代理，不再重复创建`]

### 2.3 为什么不能删缓存（面试深挖）

- [ ] （9）❌ 三级缓存可以删？→ ✅ 错。三级缓存存 ObjectFactory，提供 **___ AOP 工厂对象延迟创建 _____** 创建代理的能力；删掉后在循环依赖 + AOP 场景下，注入给依赖方的是原始对象、单例池里是代理对象，两者不一致，AOP 增强失效。⭐⭐⭐ [来源：画布 三级缓存 `不能删三级缓存：三级缓存存放 ObjectFactory，提供延迟创建代理的能力`]
  - [ ] 删除三级缓存会带来哪些问题？
    - [ ] AOP场景，B是从三级缓存中拿到A的工厂对象，然后通过getObject，生成A的代理对象放到二级缓存中，
    - [ ] 如果只有二级缓存，代理对象是A 初始化后置处理生成的
    - [ ] 延迟创建的解释：工厂（ObjectFactory）先放进去，**代理创建动作延迟**，不实例化完就立刻造代理；

- [ ] （10）❌ 二级缓存可以删？→ ✅ 错。二级缓存缓存工厂产出的早期 Bean/代理；删掉后同一个 Bean 被多个依赖方需要时会反复调用 ObjectFactory、**_ 多次生成代理对象 _______**，破坏单例。⭐⭐⭐ [来源：画布 三级缓存 `不能删二级缓存...会反复调用 ObjectFactory，多次生成不同的代理实例，破坏单例`]
  - [ ] 删除二级缓存会带来哪些问题
    - [ ] 早期对象无法被保存，所有会存在多次被调用生成的情况

（11）面试深挖：项目没用 AOP 时三级缓存能不能删？→ Spring 统一按"可能有 AOP"设计，用 **__ ？ 加载  正确：ObjectFactory ______** 延迟决策，保证任何场景下注入给依赖方的对象和最终单例池里的是同一个。⭐ [来源：画布 三级缓存 `高频追问原题`] [补充：百度搜索「Spring 三级缓存 没用AOP 能否删除」]

### 2.4 无法解决的情况（纠错清单）

（12）❌ 所有循环依赖 Spring 都能解决？→ ✅ 错。三级缓存只解决 **__ 单例 sington ______** 作用域 Bean 的循环依赖，多例 Bean 根本不走这套逻辑。⭐⭐⭐ [来源：画布 AOP（需纠错）`三级缓存本身就只用来解决单例 Bean 的循环依赖，多例 Bean 根本不走三级缓存这套逻辑`]

（13）❌ 构造器注入的循环依赖也能靠三级缓存解决？→ ✅ 错。构造器注入发生在 **__ 实例化吗 两个对象都没创建的时候 ，构造器可以进行实例化和DI依赖注入，那么循环依赖应该发生在实例化之后的DI ______** 阶段，两个对象都还没创建出来，无法提前暴露到缓存。⭐⭐⭐ [来源：画布 三级缓存（需纠错）`构造方法注入是发生在实例化阶段`]

- [ ] （14）循环依赖支持情况速记：A、B 均构造器注入 ❌；均 **___ ？@Autowired 的字段注入和setting方法注入__-正确的是setter_ __** 注入 ✅；均属性自动注入 ✅。⭐⭐⭐ [来源：画布 三级缓存 `AB循环依赖 依赖注入方式 是否支持`]


---

## 模块三 · AOP 面向切面编程

### 3.1 AOP 概念与应用场景

（1）AOP 面向切面编程一句话：把业务逻辑中的 **___ 相同代码 _____** 抽取到独立模块统一管理（日志、权限、监控、事务），让业务代码更清爽。⭐⭐⭐ [来源：画布 aop提炼相同代码、通过动态代理实现的jdk、cglib `把一些业务逻辑中的相同代码抽取到一个独立的模块中`]

（2）AOP 两大典型应用：**___ 接口日志 _____**（入参出参、执行时间，便于 bug 溯源和性能调优）和事务管理（@Transactional）。⭐⭐⭐ [来源：画布 aop写日志，自带的事务 `AOP的应用场景有哪些？`]

（3）Spring AOP 的拦截范围：只拦截 **___ 方法 _____** 级别的执行，且只能拦截 Spring 容器管理的 Bean。⭐⭐⭐ [来源：画布 aop 切面、切点、通知、织入 `只会拦截方法级别的拦截，而且只能拦截 Spring 容器管理的 Bean`]

### 3.2 核心概念与通知类型

（4）切面 Aspect = 切点 Pointcut + **__  切点和通知 ______** Advice：@Aspect 注解把两者打包在一起。⭐⭐⭐ [来源：画布 aop 切面、切点、通知、织入 `切面：把切点+通知打包在一起`]

（5）切点 Pointcut 是筛选规则（execution 表达式）；**__ 连接点 ______** 则是每个被拦截到的具体方法点。⭐⭐⭐ [来源：画布 aop 切面、切点、通知、织入 LogAspect 代码 `连接点：service包下所有方法（候选），切点从中挑选符合规则的`]

（6）五种通知：@Before 前置、@After 后置、@AfterReturning 返回通知、@AfterThrowing 异常通知、**___ @Around _____** 环绕通知。⭐⭐⭐ [来源：画布 aop 切面、切点、通知、织入 `通知 Advice = @Before / @After / @AfterReturning / @AfterThrowing / @Around`]

- [ ] （7）@AfterReturning 是方法正常返回后执行、可拿到返回值；@AfterThrowing 是方法抛异常时执行；@After 则 **___ ？方法执行完毕 __--正确：不管正常返回还是抛异常___** 都执行。⭐⭐⭐ [来源：画布 aop 切面、切点、通知、织入 LogAspect 代码 `后置通知 @After：方法执行完毕（不管正常返回还是抛异常都执行）`]


- [ ] （8）@Around 是功能最强的通知：参数类型 **______？可以控制是否执行目标方法   正确：ProceedingJoinPoint__**（JoinPoint 的子类），通过 proceed() 控制目标方法什么时候执行、执不执行。⭐⭐⭐ [来源：画布 aop 切面、切点、通知、织入 LogAspect 代码 `ProceedingJoinPoint 是 JoinPoint 的子类，可以控制是否执行目标方法`]

  - [ ] 织入是自动完成的，是Spring读到你定义的规则后，把通知逻辑织入到原始逻辑中进行加强的过程 
  - [ ] 切面、切点 类和拦截正则



（9）织入 Weaving 的定义：Spring 运行期 **___ 生成代理对象 _____**（target + extra logic），把通知逻辑加到目标 Bean 外面；是容器内自动完成的黑盒过程、一次性动作。⭐⭐⭐ [来源：画布 织入 `织入就是生成代理对象（target + extra logic）`] （疑问：忘记织入是什么了 干啥用的了）

（10）Spring AOP 是 **___ ？ 运行时 _____** 织入（动态代理实现）；AspectJ 才支持编译时织入、类加载时织入。⭐⭐⭐ [来源：画布 bean初始化阶段的后置处理 `Spring AOP 的织入方式是运行时织入，而 AspectJ 支持编译时织入、类加载时织入`]

### 3.3 动态代理：JDK vs CGLIB

（11）Spring AOP 代理选择：目标类实现了接口用 **___JDK_____** 动态代理（代理对象也实现该接口）；没实现接口用 CGLIB 生成目标类的子类代理。⭐⭐⭐ [来源：画布 aop提炼相同代码、通过动态代理实现的jdk、cglib `如果⽬标类，实现了接⼝，Spring 会使⽤ JDK 的动态代理技术`]

（12）JDK 动态代理的核心工具类 **__ 代理类Prox ______**：JDK 原生专门用来生成接口代理类（newProxyInstance 三参数：类加载器、接口数组、handler）。⭐⭐⭐ [来源：画布 原生的JDK、CGLib代理的写法 `Proxy（普若克西），JDK 原生专门用来生成接口代理类的工具类`]

（13）JDK 代理：代理对象任何方法被调用都会进入 InvocationHandler 的 **___ invoke _____** 方法，内部 method.invoke(target, args) 反射调用真实目标。⭐⭐⭐ [来源：画布 原生的JDK、CGLib代理的写法 `任何方法被调用，都会自动交给这个 handler 的 invoke() 方法执行`]

- [ ] （14）CGLIB 的核心工具类 **__  这个类是Java核心提供的吧？答不是：**CGLIB** 第三方库的类 Enhancer ______**：专门生成目标类的子类代理（setSuperclass + setCallback + create）。⭐⭐⭐ [来源：画布 原生的JDK、CGLib代理的写法 `Enhancer，CGLib 提供专门用来生成目标类子类代理类的工具类`]
  - [ ] CGLIB** 第三方库的类 Enhancer



（15）JDK 与 CGLIB 调用方式区别：JDK 用 method.invoke 走反射；CGLIB 的 methodProxy.**___ invoke supper_____** 直接调用父类原方法（invokespecial），无反射、性能更高。⭐⭐ [来源：画布 原生的JDK、CGLib代理的写法 `methodProxy.invokeSuper 不是反射！`]

- [ ] （16）反射与 AOP 的关系：反射是 Java 语言本身提供的功能（java.lang.reflect 包），AOP 的 **___  功能加强 执行额外的方法____--正确 动态代理_** 又是基于反射实现的。⭐⭐ [来源：画布 反射和增强 `反射是 Java 语言本身提供的功能`]


（17）反射与 AOP 的区别：反射是运行状态获取自身信息，Spring AOP 是运行状态对方法进行 **___ 功能增强 执行二外的额方法_____**。⭐⭐ [来源：画布 反射和增强 `反射是运行状态获取自身信息，而 spring aop 是运行状态对方法进行功能加强`]

### 3.4 AOP 发生时机（纠错清单）

- [ ] （18）Spring AOP 的发生时机：Bean 实例化完成、属性填充完成后的 **___ 初始化 后置处理阶段_____** 阶段，由 AbstractAutoProxyCreator（BeanPostProcessor）完成代理创建。⭐⭐⭐ [来源：画布 织入 + bean初始化阶段的后置处理 `由 AbstractAutoProxyCreator（BeanPostProcessor）在 Bean 初始化之后完成`]


（19）❌ 容器启动时就会执行切面代码？→ ✅ 错。容器启动只是创建代理；切面逻辑是 **___ 被调用 _____** 时才触发。最终放进单例池的是代理对象，@Autowired 注入的就是它。⭐⭐⭐ [来源：画布 AOP（需纠错）`切面逻辑的执行，是等你调用 Bean 方法的时候才触发，不是容器启动的时候执行切面代码`]

---

## 模块四 · Spring 事务

### 4.1 声明式事务实现原理

（1）Spring 声明式事务 @Transactional 的底层本质是 **___ AOP _____**——事务也是一个切面，注解由 AOP 切面识别、给 Bean 加上事务增强。⭐⭐⭐ [来源：画布 aop事务 `底层本质：AOP！事务也是一个切面`]

（2）事务代理两阶段：阶段一容器启动时扫描 @Transactional 方法并创建代理对象；阶段二方法 **__? 被调用的是 ______** 时，实际执行的是代理对象的方法。⭐⭐⭐ [来源：画布 事务实现 `第二个阶段发生在方法调用的运行阶段`]

（3）事务拦截器开启事务：根据注解获取事务属性（传播行为、隔离级别），通过事务管理器开启新事务，从连接池获取连接并关闭 **___ 关闭之前的自动提交了，然后提交阶段交给注解事务来执行_____**。⭐⭐⭐ [来源：画布 事务实现 `关闭其自动提交`]

（4）提交与回滚：业务方法正常执行完毕则提交；抛出异常则拦截器捕获并通过事务管理器 **__ 回滚事务 ______**，撤销之前的数据库操作。⭐⭐⭐ [来源：画布 事务实现 `通过事务管理器回滚事务，将之前的所有数据库操作撤销`]

### 4.2 事务 ACID

（5）事务四大特性：**___ 原子性 _____**、一致性 C、隔离性 I、持久性 D。⭐⭐⭐ [来源：画布 事物的特效，原子性、隔离性、持久性都是为了保证一致性 `事务的ACID`]

（6）ACID 中，原子性、隔离性、持久性都是手段，最终目标都是保证 **__ 一致性 ______**。⭐⭐⭐ [来源：画布 事物的特效，原子性、隔离性、持久性都是为了保证一致性 `原子性、隔离性、持久性都是为了保证一致性`]

（7）一致性的含义：事务执行前后，数据库从一个合法状态变成 **___ 另外一个合法的状态 _____**。⭐⭐⭐ [来源：画布 事物的特效 `事务执行前后，数据库从一个合法状态，变成另一个合法状态`]

（8）持久性的含义：提交之后数据 **__ 持久化到硬盘 ，不会丢失______**，宕机也不丢。⭐⭐⭐ [来源：画布 事物的特效 `提交之后数据永久落盘，宕机也不丢`]

### 4.3 隔离级别与并发异常

（9）脏读、不可重复读、幻读的本质：并发下一个事务读到了 **___ 另外一个事务修改但是没有就是未提交的数据_____** 的数据，导致业务计算结果非法、不一致。⭐⭐⭐ [来源：画布 脏读、不可重复读、幻读的本质 `并发下，一个事务读到了不稳定的数据`]

（10）隔离级别的本质：在「**___ 一致性 _____**」和「性能」之间做选择——允许业务能接受的轻微读取不稳定现象，换更高并发。⭐⭐ [来源：画布 事务的隔离级别 `隔离级别就是在「一致性强度」和「性能」之间做选择`]

（11）读未提交：最低隔离级别，允许 **__ 读取脏数据 ______**（B 能读到 A 未提交的修改，A 回滚后 B 读到的就是脏数据），实际项目基本不用。⭐⭐⭐ [来源：画布 事务的隔离级别 `读未提交...允许脏读`]

（12）读已提交：杜绝脏读，但还有 **___ 不可以重复度 _____** 问题（同一事务内两次读同一条数据值不一样）；这是 **__ oracle ______** 数据库的默认隔离级别。⭐⭐⭐ [来源：画布 事务的隔离级别 `对于 Oracle 来说，默认是读已提交`]

（13）可重复读：杜绝脏读、不可重复读；MySQL 的 **___ InnoDB _____** 引擎默认级别，还通过临键锁在很大程度上解决幻读。⭐⭐⭐ [来源：画布 事务的隔离级别 `MySQL 的 InnoDB 存储引擎通过临键锁在很大程度上解决了幻读问题`]

（14）串行化：最高隔离级别，事务完全排队执行，解决所有读问题，但 **___ 性能 _____** 最差，实际很少使用。⭐⭐ [来源：画布 事务的隔离级别 `性能是最差的，因为事务基本上是排队执行的`]

（15）幻读的典型表现：同一事务内多次执行同一查询，看到 **___ 表中的记录条数不一样 _____** 的记录数（B 插入并提交一条符合条件的记录，A 从 10 条看到 11 条）。⭐⭐⭐ [来源：画布 事务的隔离级别 `A 事务查询某个条件的记录数是 10 条...再次查询时可能会看到 11 条`]

（16）Isolation.DEFAULT 的含义：使用底层数据库的默认隔离级别（MySQL 是 **___ 可以重复读取 _____**、Oracle 是读已提交），实际项目通常用 DEFAULT。⭐⭐⭐ [来源：画布 事务的隔离级别 `对于 MySQL 来说，默认的隔离级别是可重复读`]

- [ ] （17）@Transactional 指定隔离级别：不会修改数据库全局配置，只是执行 **___ 当前代码的是连接有效：正确： SET SESSION xxx：当前会话（当前连接），只对这一条连接生效；别的连接不受影响，连接断开就没了_____** 修改当前会话的隔离级别，只对当前连接本次事务生效。⭐⭐ [来源：画布 事务的隔离级别 `执行 SET SESSION 修改当前会话的隔离级别，只对当前连接本次事务生效`]


- [ ] （18）行锁补充：S 共享锁（读锁，lock in share mode）多个事务可同时持有；X **__ 互斥锁 -- 排他锁一个意思______** 锁（写锁，for update）谁拿到后其他事务的 S、X 都拿不到。⭐⭐ [来源：画布 数据行锁 `排他锁 X（Exclusive）`]  ----互斥锁和排他锁一个意思


- [ ] （19）行锁是基于 **___ ? 行锁___--正确是：索引__** 加的，没有索引会退化成表锁；普通快照读 select 不加 S/X 行锁，走 MVCC。⭐⭐ [来源：画布 数据行锁 `行锁是基于索引加的！没有索引会退化成表锁`]

  - [ ] 行锁需要在索引的基础上



### 4.4 事务传播行为

（20）事务传播的实现基础：事务绑定在 **___ 当前线程上 _____** 上（ThreadLocal 保存），A 调 B 同线程时 B 拿到已存在的事务、按自己的策略配合。⭐⭐⭐ [来源：画布 AOP事务 `事务是绑定在当前线程上的`]

（21）传播行为是写在 **______B方法中__**（被调用方）注解上的配置——是 B 面对「当前线程已有事务」怎么配合的策略，不是 A 的。⭐⭐⭐ [来源：画布 AOP事务 `传播行为，是写在 B（被调用方）的注解上的配置，是 B 的策略，不是 A 的`]

（22）❌ 没加 @Transactional 的方法 B 也参与传播机制判断？→ ✅ 错。传播机制只对 **___ 加上事务注解的_____** 的方法生效；没注解的方法不做事务增强，直接跑在 A 的事务里、共用 A 的连接。⭐⭐⭐ [来源：画布 AOP事务（需纠错）`B 根本不参与传播机制判断！`]

- [ ] （23）@Transactional 的默认传播行为是 **___ B默认加入A事务中一起执行_--- REQUIRES_NEW ____**：有事务就加入，没有就新建（加入式事务）。⭐⭐⭐ [来源：画布 事物的两个属性：propagration、isolation 传播、隔离 `Propagation propagation() default Propagation.REQUIRED` + AOP事务 `加入式事务（默认传播）`]


- [ ] （24）7 种传播行为：REQUIRED、SUPPORTS、MANDATORY、**___ ？ requiredes_new _____**、NOT_SUPPORTED、NEVER、NESTED。⭐⭐⭐ [来源：画布 AOP事务 `public enum Propagation`]


（25）REQUIRES_NEW：不管当前有没有事务，都额外开启一个全新的 **__ 独立的 ______** 事务，和主业务互不干扰（典型场景：主业务回滚，操作日志也要保存下来）。⭐⭐⭐ [来源：画布 AOP事务 `不管当前有没有事务，都额外开启一个全新的、独立的事务`]

（26）NESTED 嵌套事务：父事务回滚它必回滚，但它自己回滚 **__ 不影响 ______** 父事务；需要数据库支持 Savepoint（MySQL 支持）。⭐⭐⭐ [来源：画布 AOP事务 `嵌套事务父子事务，子事务回滚不影响父事务`]

（27）NESTED vs REQUIRES_NEW：REQUIRES_NEW 是两个独立事务、**__   两个连接 ______**；NESTED（nested 类似next下一个） 是一个事务 + savepoint、同一个连接。⭐⭐⭐ [来源：画布 AOP事务 `REQUIRES_NEW：两个独立事务，新连接。NESTED：一个事务 + savepoint，同一个连接`]

（28）NEVER 与 MANDATORY 的区别：NEVER 是有事务就报异常，MANDATORY 是 **___  无事务 _____** 报异常。⭐⭐ [来源：画布 AOP事务 `never是有事务报异常，mandatory是没事务报异常`] （疑问 现在知道了 NESTED vs REQUIRES_NEW 和NEVER 与 MANDATORY  这四个事务，但是这些题中没有另外三种事务传播行为的题 或者解释啊 ）

- [ ] | 传播类型                                           | 外层已有事务                                                 | 外层无事务           | 异常影响                                                     |
  | -------------------------------------------------- | ------------------------------------------------------------ | -------------------- | ------------------------------------------------------------ |
  | **SUPPORTS**（支持的一起事务，无事务就非事务执行） | 加入外层同一个事务，共用连接、同一个回滚边界                 | 非事务执行，自动提交 | 方法抛异常 → 外层事务一起回滚                                |
  | **NOT_SUPPORTED**（不支持事务我自己非事务执行）    | **挂起外层事务**，本方法独立非事务执行；本方法的 SQL 即时提交，不受外层控制 | 非事务执行           | 本方法抛异常，**不影响外层事务**；外层异常回滚也不会回滚 NOT_SUPPORTED 里已经提交的数据 |


- [ ] | 传播级别                     | 外层存在事务               | 外层无事务 | 异常行为重点                                                 |
  | ---------------------------- | -------------------------- | ---------- | ------------------------------------------------------------ |
  | REQUIRED（必须的有一个事务） | 加入外层，同一个事务       | 创建新事务 | 任意一处抛异常，整体一起回滚                                 |
  | REQUIRES_NEW（必须是新事务） | **挂起外层，新开独立事务** | 创建新事务 | 内层、外层是两个独立事务：内层异常只回滚内层；外层异常不会回滚内层已提交数据 |


- [ ] | 传播级别         | 外层存在事务                                      | 外层无事务 | 异常行为重点                                                 |
  | ---------------- | ------------------------------------------------- | ---------- | ------------------------------------------------------------ |
  | REQUIRES_NEW     | **挂起外层，新开独立事务**                        | 创建新事务 | 内外是两个独立事务：内层提交后不受外层回滚影响；内层异常只回滚内层 |
  | NESTED--嵌套事务 | 开启**保存点（savepoint）**，作为外层事务的子事务 | 创建新事务 | 内层异常只回滚到保存点（不影响外层）；**外层一旦回滚，子事务一定跟着回滚** |


- [ ] （29）事务传播基于 ThreadLocal，所以被调方法在 **___？ 新线程_____** 中执行时，事务传播会失效（不在调用方事务范围内）。⭐⭐⭐ [来源：画布 AOP事务 `如果调用的方法是在新线程中，事务传播就会失效`]

  - [ ] REQUIRED 必须有一个事务，REQUIRES_NEW 两个独立的事务 、NESTED-嵌套事务，回滚相互影响、SUPPORTS 支持事务，有事务支持执行，没有我无事务执行、NOT_SUPPORTED 不支持有事务，有事务我也得非事务执行 



### 4.5 事务失效清单（纠错清单）

（30）失效场景①：@Transactional 加在非 **___ public _____** 修饰的方法上——private 方法代理类无法覆盖，完全不生效（protected/default 也应避免）。⭐⭐⭐ [来源：画布 事务失效原因，代理无效和异常无效 `用在非 public 修饰的方法上`]

（31）失效场景②：同一个类里方法 A 直接 **___ 直接调用_____** 调用带事务的方法 B——this 引用绕过了代理对象，代理里的事务逻辑没机会执行。⭐⭐⭐ [来源：画布 事务失效原因，代理无效和异常无效 `直接调用本类...使用的是 this 引用，绕过了 Spring 的代理对象`]

（32）失效场景③：事务方法内部 **____ 异常被捕获了____** 了异常且没有重新抛出——事务拦截器无法感知异常，不会回滚。⭐⭐⭐ [来源：画布 事务失效原因，代理无效和异常无效 `try-catch 捕获了异常，但没有在 catch 块中将异常重新抛出`]

（33）失效场景④：默认只对 **___ runtimeExceptiong _____** 和 Error 类型的异常回滚；Checked 异常不配 rollbackFor = Exception.class 就不回滚。⭐⭐⭐ [来源：画布 事务失效原因，代理无效和异常无效 `Spring 事务默认只对 RuntimeException 和 Error 类型的异常进行回滚`]

---

## 模块五 · Bean 作用域与单例线程安全

### 5.1 五大作用域

- [ ] （1）Bean 的 5 种作用域：singleton、prototype、request、session、**___ ？application _正确：_global-session___**（画布记法；新版本 web 环境还有 application、websocket）。⭐⭐⭐ [来源：画布 bean作用域@scope] [补充：百度搜索「Spring Bean 作用域 application websocket」]


（2）singleton（默认作用域）：整个 Spring 容器中只有 **___ 一个_____** 实例，不管多少地方注入拿到的都是同一个。⭐⭐⭐ [来源：画布 bean作用域@scope `整个 Spring 容器中只有一个 Bean 实例`]

- [ ] （3）prototype：每次从容器获取 Bean 都会创建一个 **___ Bean 新实例_____**，不放入单例池，容器也不管理它的销毁回调。⭐⭐⭐ [来源：画布 bean作用域@scope `prototype 每次获取时 new 新对象，不放入单例池，容器不管理销毁的回调`]


- [ ] （4）request / session 作用域：分别在每个 **___  ？每个会话 --正确的是每个http请求_____** / 每个 HTTP 会话创建一个新实例，结束即销毁。⭐⭐ [来源：画布 bean作用域@scope `每个 HTTP 请求都会创建一个新的 Bean 实例`]


- [ ] （5）singleton Bean 注入 prototype Bean 的坑：singleton 只创建一次，prototype 也只注入一次；解法是用 **___ ？ lookup是是干啥的_--正确：`@Lookup` 标注在方法，Spring 会动态生成这个方法的代理实现：____** 注解（Spring 重写该方法，每次调用返回新实例）或 ApplicationContext 动态获取。⭐⭐ [来源：画布 bean作用域@scope `可以用 @Lookup 注解或者 ApplicationContext 来动态获取`]

  - [ ] @Lookup 我看着你呢单例，可以创建多个



### 5.2 Spring 单例的实现（纠错清单）

（6）❌ Spring 单例是 JVM 进程内全局唯一？→ ✅ 错。Spring 单例是 **___ 容器 _____** 级别的单例，不是类级别的单例。⭐⭐⭐ [来源：画布 spring单例模式（需纠错）`容器级别的单例，不是类级别的单例`]

（7）❌ Spring 单例主要靠 @Scope 注解实现？→ ✅ 错。@Scope 只是声明；真正实现单例的核心：创建 Bean 前先查一级缓存，**___ 一级缓冲中存在这创建好的单例bean 存在就返回_____**，创建完存入——保证同容器同 beanName 只有一个实例。⭐⭐⭐ [来源：画布 spring单例模式（需纠错）`创建单例 Bean 前先查询缓存，存在直接返回`]

（8）二、三级缓存是为了解决单例 Bean 的 **___ 循环依赖的问题_____** 问题，不是实现单例本身所必需的。⭐⭐⭐ [来源：画布 spring单例模式 `二、三级缓存是为了解决单例 Bean 的循环依赖问题`]

### 5.3 单例 Bean 线程安全（纠错清单）

（9）❌ Spring 会保证单例 Bean 线程安全？→ ✅ 错。Spring 只保证创建过程的单例，Bean 使用过程的 **___ 线程安全 _____** 问题它不管。⭐⭐⭐ [来源：画布 单例下线程安全（需纠错）`Spring 不会保证单例 Bean 的线程安全问题`]

（10）单例 Bean 线程安全问题的根源：Bean 里有 **__ 可变的 ______** 的状态变量，多线程修改就出并发问题。⭐⭐⭐ [来源：画布 单例下线程安全 `可变的状态变量`]

- [ ] （11）解决思路：①无状态设计（**___ 局部变量 _____** 变量、数据全靠参数传递）②改作用域（prototype/request）③用线程安全容器（ConcurrentHashMap 替代 HashMap）④加锁（synchronized / ReentrantLock）。⭐⭐⭐ [来源：画布 单例下线程安全 `使用局部变量...把所有状态都通过方法参数传递`]
  - [ ] 线程安全，如果不存在共享变量不就好了、如果有锁不就好了、如果有安全的容器不就好了、如果参数每个人一份互不影响不就好了ThreadLocal.reamve

- [ ] （12）需要维护跨请求/跨线程的状态时，可用 **__ ThreadLocal______**：每个线程独立变量副本互不干扰（用完记得 remove 防内存泄漏）。⭐⭐ [来源：画布 单例下线程安全 `可以使用 ThreadLocal 来保存状态`]


（13）懒加载：加 **___ @Lazy_____** 注解的 Bean 不在 refresh 时提前创建，第一次获取时才创建。⭐⭐ [来源：画布 bean作用域@scope `加 @Lazy 懒加载，第一次获取时创建`]

---

## 模块六 · SpringBoot 核心原理？

### 6.1 SpringBoot 定位与理念

（1）SpringBoot 的定位：基于 Spring 框架的 **___ 快速开发框架_____**（脚手架），核心是自动装配 + 内嵌服务器，解决 XML 配置繁琐、版本冲突、部署复杂三大痛点。⭐⭐⭐ [来源：画布 SpringBoot和spring/SpringMVC的区别 `Spring Boot 不是一个独立的框架，而是基于 Spring 框架的脚手架`]

- [ ] （2）SpringBoot 最核心的理念：**__  约定大于配置 ，就是用月的好的配置，别自己贱嗖嗖的自己写______**——预设一整套默认规则（内嵌 Tomcat、默认日志 Logback），不想用默认的才手动改配置。⭐⭐⭐ [来源：画布 介绍一下springboot `约定大于配置是 Spring Boot 最核心的理念`]


（3）部署方式变化：SpringBoot 内嵌 Servlet 容器，打包成 **______ jar __** 文件直接 java -jar 运行，不需要单独搭 Tomcat、导 war 包。⭐⭐⭐ [来源：画布 SpringBoot和spring/SpringMVC的区别 `打包成一个 JAR 文件，就可以直接通过 java -jar 命令运行`]

（4）starter 解决的问题：手动管理 jar 版本容易冲突；引入 spring-boot-starter-web 一个依赖就包含所有相关 jar，且 **___ 兼容 _ 版本兼容（经过测试）____**。⭐⭐⭐ [来源：画布 SpringBoot和spring/SpringMVC的区别 `版本都是测试过的，可以兼容的`]

### 6.2 自动配置原理

- [ ] （5）@SpringBootApplication 是组合注解 = @SpringBootConfiguration（等价 **__ @Configuration______**）+ @EnableAutoConfiguration + @ComponentScan。⭐⭐⭐ [来源：画布 SpringBoot的启动原理 + spring常用注解]


（6）@ComponentScan 默认扫描 **__ 启动类 ______** 所在包及其子包。⭐⭐⭐ [来源：画布 spring常用注解 `默认扫描主类所在包及其子包`]

- [ ] （7）@EnableAutoConfiguration 通过 **__ ？__正确：AutoConfigurationImportSelector__ __**（ImportSelector 实现类）读取所有 starter 里 META-INF 的自动配置类清单。⭐⭐⭐ [来源：画布 SpringBoot的启动原理 + import注解]


- [ ] （8）SpringBoot 2.7+ 的自动配置清单文件：META-INF/spring/ 下的 **__ autoConfiguration.imports ，自动配置导入______**（每行一个自动配置类全类名），替代旧版 spring.factories（Boot 3 已移除）。⭐⭐⭐ [来源：画布 Starter理解 `SpringBoot 3.x 后不再用 spring.factories，改用 META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports`]


- [ ] （9）❌ 每个官方 starter 都自带 imports 文件？→ ✅ 不对。官方所有 starter 共用 **__ ？___正确：spring-boot-autoconfigure ___**.jar 里唯一一份 imports 清单；starter 本身只负责引入依赖（web → spring-webmvc + tomcat 等）。⭐⭐⭐ [来源：画布 spring-boot-autoconfigure.jar和improts（需纠错）`starter 不会自带 imports`]


- [ ] （10）❌ classpath 上永远只有一份 imports？→ ✅ 不一定。第三方/自定义 starter 可以自带自己的 imports，此时会有 **_ 自动配置类--正确：多分imoports_______** 文件，SpringBoot 启动时全部收集合并成候选列表。⭐⭐⭐ [来源：画布 spring-boot-autoconfigure.jar和improts `收集 classpath 下全部的 imports 文件，合并所有候选自动配置类`]


- [ ] （11）清单里的自动配置类是否生效，由 **___ @condition 条件注解吗 差不多：@ConditionalOnClass_____** 条件注解逐个判断：classpath 有 DispatcherServlet → WebMvcAutoConfiguration 生效；有 Redis 相关类 → RedisAutoConfiguration 生效；没有就跳过。⭐⭐⭐ [来源：画布 spring-boot-autoconfigure.jar和improts `再逐个执行每个 @ConditionalOnClass 判断`]


- [ ] （12）三大条件注解：@ConditionalOnClass（类存在才开启）、**______？正确：@ConditionalOnMissingBean 当前容器里【不存在这个 Bean】的时候，才会注册当前这个 Bean是 存在就不注册，不存在才注册 __**（用户自己定义了 Bean 就优先用户的、自动配置跳过）、@ConditionalOnProperty（配置属性条件）。⭐⭐⭐ [来源：画布 SpringBoot Starter `@ConditionalOnMissingBean：用户自己定义了 Bean，就优先用户的`]


### 6.3 @Import 与 @EnableXXX

（13）@Import 是 Spring **____ 原始____** 注解（Spring 时代就有，不是 Boot 新增的）。⭐⭐⭐ [来源：画布 import注解 `它是 Spring 原生注解，不是 Boot 新增的，在 Spring 时代就有了`]

（14）@EnableXXX 注解的设计套路：门面注解 + **__ 原始注解@import______**（选择器/注册器）——@EnableAutoConfiguration、@EnableCaching、@EnableAspectJAutoProxy 底层都封装了 @Import。⭐⭐⭐ [来源：画布 import注解 `@EnableXXX 只是一个门面注解，里面写上 @Import(选择器/注册器)`]

### 6.4 Starter 原理与自定义

（15）Starter 本质 = 一套制好的 **___ pom文件 _____** + 配套自动配置类，引入一个 starter 依赖就能获得完整功能模块。⭐⭐⭐ [来源：画布 Starter理解 `starter 本质就是一套被制好的 pom 依赖组合 + 自动配置类`]

- [ ] （16）自定义 Starter 的规范结构：xxx-spring-boot-**___？功能描述_--正确：autoconfigure____**（自动配置模块，核心代码所在）+ xxx-spring-boot-starter（空壳，只负责引入依赖）；也可以像 springdoc 那样单 jar 合并。⭐⭐⭐ [来源：画布 Starter理解 + SpringBoot Starter]


（17）spring-boot-starter-web 是依赖聚合包，内含：spring-boot-starter-**__ tomcat ______**（内嵌容器，可排除换 Jetty/Undertow）、spring-web + spring-webmvc、jackson-databind（JSON 序列化）、hibernate-validator（参数校验）。⭐⭐⭐ [来源：画布 Starter-springboot-starter-web `spring-boot-starter-tomcat 默认嵌入式 Tomcat 容器`]

（18）自定义 Starter 的价值：把第三方对接细节（重试、异常封装、日志、回调）**__ 封装 ______** 在 starter 内部，业务层不关心对接细节。⭐⭐⭐ [来源：画布 Starter启动器流程 `全部封装在 starter 内部...屏蔽底层第三方 SDK/HTTP 对接细节`]

- [ ] （19）自动配置类的关键注解组合：@Configuration + @EnableConfigurationProperties(SmsProperties.class) + @ConditionalOnClass + **___ @Condition 条件注解 正确：@ConditionalOnProperty_____**（配置开关 sms.enabled=true 才生效）+ @Bean + @ConditionalOnMissingBean。⭐⭐⭐ [来源：画布 Starter启动器流程]


- [ ] （20）@ConfigurationProperties(prefix="sms") 定义配置映射规则；**___ @ConfigurationProperties  正确的是：@EnableConfigurationProperties_____** 负责开启注册+绑定能力，把这个类创建成 Bean 并填充 yml 配置。⭐⭐⭐ [来源：画布 Starter启动器流程 `@EnableConfigurationProperties：开启【注册 + 绑定能力】`]


- [ ] （21）@ConditionalOnProperty(prefix="sms", name="enabled", havingValue="true", **___ ？正确：matchIfMissing _____**=true)：yml 根本没配 sms.enabled 这一行时，当作 true 处理、自动开启。⭐⭐ [来源：画布 Starter启动器流程 `matchIfMissing：如果 yml 根本没写 sms.enable 这一行，就当作 true`]


- [ ] （22）SpringBoot 自动配置的核心思想一句话：**______？默认提供配置 __**，允许用户自定义覆盖。⭐⭐⭐ [来源：画布 Starter启动器流程 `默认提供，允许用户自定义覆盖`]


（23）自定义 Starter 完整串联：引入 starter → Boot 扫描所有 jar 的 AutoConfiguration.imports 加载配置类 → **______ 条件注解 __** 筛选（类存在/配置开关/容器缺 Bean 判断）→ @EnableConfigurationProperties 读 yml → @Bean 创建服务 Bean → 业务 @Autowired 使用。⭐⭐⭐ [来源：画布 Starter启动器流程 `三、整体串一遍完整执行流程`]

### 6.5 启动流程与事件

- [ ] （24）SpringApplication.run() 大流程：new SpringApplication（组装工具箱）→ prepareEnvironment → 创建 **__ ？正确：ApplicationContext ______** → prepareContext → refresh() → callRunners → 发布启动完成事件。⭐⭐⭐ [来源：画布 SpringBoot的启动原理 + 程序入口SpringApplication.run（）方法]


（25）new SpringApplication(启动类) 只是普通 Java 对象实例化：推断 web 应用类型、SPI 加载 **___ ？ _正确：ApplicationContextInitializer（初始化器）____** 和 ApplicationListener、保存配置源——此时还没有容器、没有 Bean。⭐⭐⭐ [来源：画布 SpringBoot的启动原理 `SPI加载ApplicationContextInitializer、ApplicationListener、保存配置源`]

- [ ] （26）prepareContext 阶段：把启动类注册为 **__ 配置源 ______**，执行初始化器、发布 ApplicationPreparedEvent；此阶段只注册不扫描，解析工作交给 refresh。⭐⭐⭐ [来源：画布 SpringBoot的启动原理 `只注册配置源，不扫描、不解析@Import、不实例化Bean，解析工作交给refresh`]（疑问这个源 是什么来着忘记了 ）


- [ ] （27）refresh() 内部关键四步：invokeBeanFactoryPostProcessors（执行 BeanFactory 后置处理器）→ 注册 **__ ？正确：BeanPostProcessor ______** → 实例化所有非懒加载单例 Bean → 内嵌 Tomcat 启动、端口监听。⭐⭐⭐ [来源：画布 SpringBoot的启动原理 `5.2 注册BeanPostProcessor（AOP的代理创建器就在这里）`]


- [ ] （28）容器就绪后执行 Runner：**______ ApplicationRunner __** 拿到封装好的 ApplicationArguments（方便解析 --key=value），CommandLineRunner 拿到原始字符串数组；都是 refresh 完成、Tomcat 启动后才同步执行。⭐⭐⭐ [来源：画布 SpringBoot的启动原理 `ApplicationRunner：拿到封装好的 ApplicationArguments，方便解析 --key=value 参数`]


- [ ] （29）启动事件链：ApplicationEnvironmentPreparedEvent（环境就绪）→ ContextRefreshedEvent（refresh 完成）→ ApplicationStartedEvent（Runner 之前）→ **______？正确的是：ApplicationReadyEvent__**（Runner 全部跑完，服务完全就绪）。⭐⭐⭐ [来源：画布 SpringBoot的启动原理 `ApplicationReadyEvent：Runner 全部跑完，代表整个启动流程就绪`]


- [ ] （30）监控利器 Actuator：引入 spring-boot-starter-actuator 自动暴露 **___ health 正确的是 差不多/actuator/health _____**（健康检查）和 /actuator/metrics（JVM 内存、QPS 指标）等监控接口。⭐⭐ [来源：画布 介绍一下springboot `Actuator（监控）`]


---

## 模块七 · SpringMVC 与 RESTful ？

### 7.1 核心组件与请求流程

（1）SpringMVC 的入口和核心调度器是 **___ DispatchServelet（前端控制器） _____**：接收 HTTP 请求、分发给合适的处理器、协调其他组件工作。⭐⭐⭐ [来源：画布 SpringMVC整体结构和RestFull风格 `前端控制器 DispatcherServlet，这是 Spring MVC 的入口和核心调度器`]

（2）SpringMVC 核心组件：DispatcherServlet、**___ HadelerMapping（处理器映射器） _____**（根据 @RequestMapping 匹配 URL）、HandlerAdapter、ViewResolver、Handler（Controller 方法）。⭐⭐⭐ [来源：画布 SpringMVC整体结构和RestFull风格 `SpringMVC的核心组件`]

- [ ] （3）HandlerMapping 找到处理器后返回 **___ controller ？正确的是： HandlerExecutionChain_____**（处理器 + 拦截器的组合），供 DispatcherServlet 执行。⭐⭐ [来源：画布 SpringMVC整体结构和RestFull风格 `返回HandlerExecutionChain（处理器与拦截器的组合）`]
  - [ ] HandlerMapping 找到处理器后返回不就是Controller吗 然后通过HandlerAdapter 执行这个controller
  - [ ] 算对啊 
  - HandlerMapping 根据 url 匹配，找到对应的 handler（就是我们写的 Controller 里面那个方法，也叫 HandlerMethod）
  - 然后把这个 handler + 匹配上的所有拦截器 `HandlerInterceptor`，打包组装成 **HandlerExecutionChain（执行链）** 返回



（4）HandlerAdapter 存在的意义：处理器有多种类型（注解方式、实现接口方式），适配器为它们提供 **___ 统一_____** 的调用方式，并处理参数绑定、类型转换。⭐⭐⭐ [来源：画布 SpringMVC整体结构和RestFull风格 `适配器提供统一调用的方式`]

（5）Controller 方法可返回的三种结果：视图名称、**_ modelAndView_______**、直接返回 JSON 数据（前后端分离主流）。⭐⭐ [来源：画布 SpringMVC整体结构和RestFull风格 `返回视图名、ModelAndView 或直接返回 JSON 数据`]

（6）SpringMVC 请求处理流程四步概括：请求接收 → **___ 路由分发 _____** → 控制器处理 → 视图解析。⭐⭐⭐ [来源：画布 SpringMVC整体结构和RestFull风格 `请求接收 → 路由分发 → 控制器处理 → 视图解析`]

（7）SpringBoot 中 DispatcherServlet 由 **__ 自动配置  ______** 自动注册并默认映射到 "/"。⭐⭐ [来源：画布 SpringMVC整体结构和RestFull风格 `DispatcherServlet 的启动逻辑是自动配置完成的`]	

- [ ] DispatcherServlet 还和自动配置有关系吗？

  - [ ] 引入 `spring-boot-starter-web` → 触发 `DispatcherServletAutoConfiguration` 里面干两件事：

    1. `@ConditionalOnMissingBean`：容器没有 DispatcherServlet，就 new 一个出来放进 Spring 容器
    2. 通过 `ServletRegistrationBean` 把这个 Servlet 注册给内嵌 Tomcat，**默认映射路径 `/`**

  - 还会自动注入WebMvcConfigurer

    - 没有WebMvcConfigurer  就没办法注册拦截器了吗

      - 不实现 WebMvcConfigurer 也可以注册拦截器，可以直接操作 RequestMappingHandlerMapping 设置拦截器列表；但是 WebMvcConfigurer 是官方推荐、最轻量的扩展方式，不会破坏 MVC 默认装配。

      - 

      - ```
        @Configuration
        public class MvcConfig implements WebMvcConfigurer {
            @Override
            public void addInterceptors(InterceptorRegistry registry) {
                registry.addInterceptor(new LoginInterceptor())
                        .addPathPatterns("/**");
            }
        }
        ```

    - ```
      public interface WebMvcConfigurer {
          // 跨域配置
          default void addCorsMappings(CorsRegistry registry) {}
          // 拦截器注册（addInterceptor）⭐高频
          default void addInterceptors(InterceptorRegistry registry) {}
          // 静态资源映射
          default void addResourceHandlers(ResourceHandlerRegistry registry) {}
          // 视图控制器，简单跳转
          default void addViewControllers(ViewControllerRegistry registry) {}
          // 配置视图解析器
          default void configureViewResolvers(ViewResolverRegistry registry) {}
          // 消息转换器扩展
          default void configureMessageConverters(List<HttpMessageConverter<?>> converters) {}
      }
      ```

- [ ] **自动配置 是不是也可以叫做自动注入呢** 

  - [ ] 自动配置：根据 starter 和条件 → **创建 Bean，放进容器**
  - 自动注入：你写`@Autowired` → **从容器取出 Bean 注入给你的类**

  > 没有自动配置，Bean 不会自动创建；就算有 Bean，你不写注入注解，也不会自动赋值给你。

### 7.2 RESTful 与 JSON 序列化

（8）@RestController = @Controller + **___ @ResponseBody _____**：类中所有方法返回值直接写入 HTTP 响应体，不再解析为视图。⭐⭐⭐ [来源：画布 SpringMVC整体结构和RestFull风格 `@RestController 相当于 @Controller 加 @ResponseBody`]

- [ ] （9）@ResponseBody 的底层：匹配 RequestResponseBodyMethodProcessor，用 **___ 转换Convert --正确： HttpMessageConverter _____** 把返回对象序列化成 JSON 写入 response 输出流，然后返回 null 的 ModelAndView、跳过视图解析。⭐⭐⭐ [来源：画布 SpringMVC整体结构和RestFull风格 `它使用 HttpMessageConverter 把返回对象序列化，直接写入 response 输出流`]


- [ ] （10）默认 JSON 转换器：类路径下有 Jackson 时自动配置 **__ 转换类Convert --正确：MappingJackson2HttpMessageConverter  ______** 处理对象与 JSON 互转（@RequestBody 反序列化同理）。⭐⭐ [来源：画布 SpringMVC整体结构和RestFull风格 `Spring Boot 会自动配置 MappingJackson2HttpMessageConverter 来处理 JSON 的转换`]


（11）REST 动词约定：查询用 GET、新建用 POST、更新用 **__ put ______** 或 PATCH、删除用 DELETE。⭐⭐⭐ [来源：画布 SpringMVC整体结构和RestFull风格 `PUT 或 PATCH：更新资源（改）`]

（12）RESTful 接口"抄了近道"：@RestController + HttpMessageConverter 直接序列化返回，省略 ViewResolver 和 View 渲染，适合 **___ 前端后端分离 _____** 应用场景。⭐⭐⭐ [来源：画布 SpringMVC整体结构和RestFull风格 `非常适合前后端分离的应用场景`]

---

## 模块八 · 常用注解、设计模式与事件机制 ？

### 8.1 常用注解

（1）@Component 是最基础的组件注解，@Service、@Repository、**__ @Controller ______** 都是它的派生（特化）注解，分别用在 Service 层、Dao 层、Controller 层。⭐⭐⭐ [来源：画布 spring常用注解 `@Service、@Repository、@Controller 这些都是 @Component 的特化版本`]

- [ ] ​	Component  的派生注解

- [ ] （2）配置相关四件套：@Configuration 标识配置类、@Bean 定义 Bean、**__ ？ @Value______** 注入配置文件属性值（Redis、MQ 连接信息常用）、@PropertySource 指定配置文件位置。⭐⭐⭐ [来源：画布 spring常用注解 `@Value 用来注入配置文件中的属性值`]
  - [ ] 配置相关的四个注解 配置类、bean、字段、配置文件



- [ ] （3）@PropertySource 在 SpringBoot 里很少用的原因：Boot 默认已自动加载 application.yml/properties，且 @PropertySource **___  不支持 _____** yml 文件。⭐⭐ [来源：画布 spring常用注解 `@PropertySource 不支持 yml`]


- [ ] （4）Web 参数注解：@PathVariable 读路径参数、**___ @RequestParam _____** 读请求参数、@RequestBody 读 JSON 请求体。⭐⭐⭐ [来源：画布 spring常用注解 `@PathVariable 读取路径参数。@RequestParam 读取请求参数`]

  - [ ] web参数：接口参数、路径上的参数、读取请求体、请求体和响应体


（5）@Transactional 基本上加在 **___ server层业务层 _____** 层需要保证事务原子性的方法上。⭐⭐⭐ [来源：画布 spring常用注解 `基本上 Service 层需要保证事务原子性的方法都会加上这个注解`]

- [ ] 事务注解

### 8.2 设计模式

 **单例和工厂 是一对 **

 **AOP代理、RedisTemplate模板 **

**拦截器责任链、事件发布监听观察者**

（6）工厂模式：Spring 中的 **___ BeanFactory _____** 就是典型工厂，负责创建和管理所有 Bean；@Autowired 获取 Bean 底层走的就是工厂模型。⭐⭐⭐ [来源：画布 spring设计模式 `BeanFactory 就是一个典型的工厂`]

（7）**___ 单例模式 _____** 模式是 Spring 的默认行为（默认作用域 singleton），好处是节省内存、加速创建，@Scope 可改。⭐⭐⭐ [来源：画布 spring设计模式 `单例模式是 Spring 的默认行为`]

（8）代理模式：Spring AOP 底层就是 **__ 动态代理 ______** 代理——有接口 JDK、无接口 CGLIB；@Transactional 时为类创建代理对象、方法前后加事务逻辑。⭐⭐⭐ [来源：画布 spring设计模式 `Spring AOP 的底层实现就是基于动态代理的`]

（9）模板方法模式：**___ jdcTemplate _____** 定义了数据库操作骨架（获取连接、执行 SQL、处理结果、关闭连接），具体 SQL 和结果处理由我们实现。⭐⭐⭐ [来源：画布 spring设计模式 `jdbcTemplate，它定义了数据库操作的基本流程`]

- [ ] （10）观察者模式：Spring 事件机制 = ApplicationEvent（事件）+ **___ ApplicationListener _____**（监听器），如用户注册后发布事件、多个监听器发邮件/记日志。⭐⭐⭐ [来源：画布 spring设计模式 `通过 ApplicationEvent 和 ApplicationListener 来实现事件发布/监听`]
  - [ ] 观察者模式，这个观察者是指的事件的监听者吧，观察者和 发布订阅不是描述的一回事吗
  - [ ] **观察者模式：没有中间人，发布者直接通知观察者，同进程内**（Spring 事件、Guava EventBus）
  - **发布订阅：有 Broker 中间人，发布者和订阅者隔离，分布式跨服务**（MQ） 多了一层中间件（Broker，消息队列：RocketMQ、RabbitMQ、Kafka）



- [ ] （11）责任链模式经典例子：SpringMVC 的 **__ ？ 拦截器执行链路吗  是的：Interceptor（拦截器） ______** 链（preHandle 依次执行，任一返回 false 直接中断）和 Servlet 的 FilterChain（doFilter 往下传）。⭐⭐⭐ [来源：画布 spring设计模式 `SpringMVC 的拦截器 Interceptor 链`]


（12）责任链 vs 观察者一句话：责任链像 **__ 接力赛 ______**（一个处理不了传下一个），观察者像广播（大家都收到消息）。⭐⭐ [来源：画布 spring设计模式 `责任链：接力赛...观察者：广播`]

### 8.3 事件机制

- [ ] （13）自定义事件：继承 **___ 类 ApplicationEvent _____**，用 context.publishEvent() 发布（ApplicationContext 继承了 ApplicationEventPublisher）。⭐⭐⭐ [来源：画布 DEMO `CustomEvent extends ApplicationEvent`]


- [ ] （14）事件监听器两种写法：主流是 **__  @EventListener ______** 注解方法，老方式是实现 ApplicationListener 接口。⭐⭐⭐ [来源：画布 DEMO `@EventListener 注解（现在主流）`]


（15）❌ Spring 事件发布默认异步？→ ✅ 错。默认是 **___ 同步 _____** 观察者：publishEvent 在当前线程依次调用所有监听器、全部跑完才返回；监听器抛异常会搞崩发布方。异步是 MQ 的印象。⭐⭐⭐ [来源：画布 spring设计模式（需纠错）`Spring 默认的同步观察者`]

- [ ] （16）事件广播组件 **______ ？ ApplicationEventMulticaster  __**：负责把事件广播给所有监听器（publishEvent 底层就是它）。⭐⭐ [来源：画布 spring设计模式 `ApplicationEventMulticaster（事件广播器）`]


---

## 模块九 · SpringCloud 微服务

### 9.1 微服务与核心组件

（1）微服务：把单体架构按业务拆成 **__ 多个独立的 小服务 ______**、各自部署的小服务；好处是边界清晰、独立开发发布、独立扩缩容；代价是复杂度上升（注册发现、远程调用、分布式事务、链路追踪）。⭐⭐ [来源：画布 SpringCloud `每个服务各自部署，独立扩缩容`]

（2）Spring Cloud Alibaba 的 Nacos 一个组件两用：**___ 注册中心_____** + 配置中心（支持动态配置刷新）。⭐⭐⭐ [来源：画布 SpringCloud `Nacos：注册中心 + 配置中心`]

- [ ] （3）OpenFeign：**___？声明式 _____** HTTP 客户端——@FeignClient("服务名") 定义接口，底层 JDK 动态代理组装请求，配合 LoadBalancer 负载均衡。⭐⭐⭐ [来源：画布 SpringCloud `声明式服务调用【OpenFeign】`]

  - [ ] 什么是声明式啊 

    - [ ] 

    - ```
      @FeignClient("order-service")
      public interface OrderApi {
          @GetMapping("/order/get")
          OrderDTO getOrder(@RequestParam Long id);
      }
      ```

      你只告诉框架：

      - 调用哪个服务
      - 请求路径、请求方式、参数 **不用写 RestTemplate / HttpClient 去拼接 url、发 http、解析响应**。 底层 JDK 动态代理帮你生成这个接口的实现类，自动发起远程调用。

      > 重点：**声明，就是描述目标，不描述执行步骤**。



- [ ] （4）Sentinel 的职责：流量控制、熔断降级、系统保护，防止 **___ 故障被放大  正确：服务雪崩 _____**（下游故障逐级放大拖垮整个链路），SCA 官方推荐替代 Hystrix。⭐⭐⭐ [来源：画布 SpringCloud `服务雪崩：下游故障逐级放大，拖垮整个链路`]

  - [ ] 熔断降级区分

    - [ ] **熔断规则写在【调用方】身上！ ** 熔断配置在 A → A 发现 B 不稳，A 主动停止调用 B。A 是调用方，熔断在 A。**等一段时间自动探测恢复（保险丝）**
    - [ ] 兜底方案 也写在A 上 
    - [ ] **熔断**：A 统计调用 B 的异常，达到阈值 → A 主动停止发请求给 B
    - **降级**：A 不发请求了（熔断拦住），此时 A 执行自己写好的兜底逻辑，返回兜底数据



- [ ] （5）Spring Cloud Gateway 三大核心概念：Route 路由、**___ 断言 正确的是：Predicate_____** 断言（匹配请求）、Filter 过滤器；底层 WebFlux 响应式。⭐⭐⭐ [来源：画布 SpringCloud `Predicate 断言：匹配请求（路径、Header、参数等）`]

  - [ ] 看不懂 Route 路由 是接收到请求后，分配匹配请求连接到服务吗，那么路由和断言又有什么区别呢
  
    - [ ]  **Route 路由**：是一条完整的路由条目，**由【断言 + 目标 uri + 过滤器集合】组成**
    - [ ] **Predicate 断言**：是**匹配规则**，用来判断「这个请求能不能走这条路由」 例子：
  - [ ] 过滤啥 黑白名单Ip限制
  
    - [ ] 过滤器分两类：**前置过滤器（pre）、后置过滤器（post）**
  
      - pre：转发给微服务**之前**执行 ✅ 常见：IP 黑白名单、鉴权校验、参数修改、请求头增加、限流
      - post：微服务返回结果**之后**，返回给前端之前执行 ✅ 常见：修改响应头、统一包装返回结果、日志记录
  
      > 注意：Gateway 内置过滤器，也可以自定义全局 Filter 做 IP 拦截。
  - [ ] 底层 WebFlux 响应式 啥意思
  
    - [ ] Spring Cloud Gateway **不是基于 Servlet（Tomcat 那套）**，底层是 Spring WebFlux，基于 Netty。 对比传统 Servlet（阻塞模型）：
      - Servlet（阻塞）：一个请求占一个线程，请求卡在 IO（等数据库、等下游服务）的时候，线程卡住不动，线程资源被占死，并发高了线程池打满就崩。
      - WebFlux（响应式非阻塞）：少量线程，线程不会卡在等待 IO 上；等待下游返回的时候，线程可以去处理别的请求。等 IO 结果回来，再接着处理这个请求。
      - BIO：同步阻塞，一连接一线程
      - NIO：同步非阻塞，多路复用，Netty、Gateway 底层用它 核心：Selector 多路复用，少量线程管理大量连接 **IO 操作本身还是要自己去轮询查结果，但是线程不会被卡住等数据**
      - AIO：异步非阻塞，Linux 场景很少用
      - WebFlux 的 “非阻塞响应式” = 基于 NIO 多路复用，不是 AIO


（6）分布式事务组件 **__ seata 水塔______**：解决微服务跨库事务一致性（AT/TCC/SAGA/XA 模式）。⭐⭐⭐ [来源：画布 SpringCloud `分布式事务【Seata】：解决微服务跨库事务一致性`]

- [ ] 默认用seat的AT，什么情况下需要手动写代码，进行ATT呢？ 不是ATT 是 TCC

- [ ] Seata AT 模式基于 undo_log 自动回滚，只适合 MySQL 这类关系库的普通 DML 

  - [ ] MySQL 自己的 undo log：innodb 用来支持本地事务 MVCC、事务回滚  存的就是操作之前的数据  数据库内核层面；
  - [ ] Seata undo_log：Seata 自己用的，用来做**分布式事务的补偿回滚**，业务层面的快照日志 

- [ ] 为什么**非关系型数据库** Redis、**调用第三方外部接口**AT 不能用？ 👉 Redis 没有办法让 Seata 拦截 SQL、自动生成 before/after 镜像写入 undo_log，没有 undo_log 就没法自动回滚，只能手写 TCC。

  - [ ] AT 靠代理 JDBC，拦截 SQL，自动记录 `undo_log` 前后镜像，自动回滚；**只支持关系型数据库（MySQL/Oracle）+ 标准 DML（update/insert/delete）**，只需要入口加 `@GlobalTransactional`，业务代码不用写补偿逻辑

  

### 9.2 负载均衡与链路追踪

- [ ] （7）客户端负载均衡：Spring Cloud **___ ？ 正确的是：LoadBalancer_____** 是官方原生组件（替代 Ribbon），@LoadBalanced 修饰 RestTemplate，默认轮询策略。⭐⭐ [来源：画布 SpringCloud `Spring官方原生负载均衡，替代Ribbon`]
  - [ ] LoadBalancer 是在ribbon 之后出的吧？
  - [ ] Ribbon 是 Netflix 的老组件，停止新特性开发后，Spring 官方推出 LoadBalancer 作为原生替代，@LoadBalanced 注解复用，2020 版本之后默认使用 LoadBalancer。



（8）链路追踪 SkyWalking：无侵入 Java agent 探针，核心模型 **______ ？正确是：Trace  __**（整条链路）+ Span（单个调用段）。⭐⭐ [来源：画布 SpringCloud `核心模型：Trace（整条链路）、Span（单个调用段）`]

### 9.3 配置中心与消息组件

- [ ] （9）Nacos Config 配置中心的三层结构：**___ DataId _____**（配置集 ID）、Group 分组、Namespace 环境隔离（dev/test/prod）；配置变更靠 @RefreshScope 自动刷新。⭐⭐ [来源：画布 SpringCloud `核心概念：DataId、Group、Namespace（环境隔离：dev/test/prod）`]
  - [ ] ID + GROUP + 环境



- [ ] （10）消息组件 RocketMQ 的四个角色：**___ 促成交易的中间人或经纪人broker  _____**（消息存储与投递）、Producer 生产者、Consumer 消费者、NameServer 注册中心；三大能力是异步通信、削峰填谷、解耦，另支持事务消息。⭐⭐ [来源：画布 SpringCloud `角色：Broker、Producer、Consumer、NameServer`]


---

## 模块十 · 认证授权与安全

### 10.1 OAuth2 与 OIDC

（1）❌ OAuth2 是登录认证协议？→ ✅ 错。OAuth2 是 **__ 授权______** 协议（Authorization）：第三方应用不拿你的账号密码，就能申请访问你的资源；登录认证是 Authentication。⭐⭐⭐ [来源：画布 Oauth2 授权码模式（需纠错）`OAuth2 是授权协议，不是登录协议！`]

（2）OAuth2 四个角色：资源所有者（用户）、**______ 资源申请者客户端 __**（第三方应用）、授权服务器（认证服务）、资源服务器（业务接口）。⭐⭐⭐ [来源：画布 Oauth2 授权码模式 `角色先记 4 个`]

- [ ] （3）OAuth2 四种授权模式中最常用、最安全的是 **___ 授权码 _____** 模式——微信公众号/小程序、QQ 登录、GitHub 登录都是它。⭐⭐⭐ [来源：画布 Oauth2 授权码模式 `授权码模式（最常用）`]
  - [ ] 授权码？token吗 不是
  
  - [ ] 一句话分清：**授权码 ≠ token，授权码只是用来换 token 的一次性 “提货券”**
  
    ### 简单流程（授权码模式）
  
    1. 你跳转到第三方（微信 / GitHub）登录，登录成功后，第三方回调给应用一个 
  
       授权码 code
  
       - ✅ code：短期、一次性、不能直接用，**只能发给后端**，绝对不能暴露在前端
  
    2. 后端拿着这个 code + 自己的 client_id、client_secret，去第三方服务器交换
  
    3. 换回真正的 
  
       access_token（访问令牌）
  
       ，还有可选的 refresh_token
  
       - ✅ access_token：才是凭证，拿着它去拿用户信息、访问接口



（4）授权码模式流程：跳转授权页（appid、redirect_uri、scope、state）→ 用户同意 → 回调带回一次性 code → 后端用 appid + **___ appsecret _____** + code 去授权服务器换 access_token + openid。⭐⭐⭐ [来源：画布 Oauth2 授权码模式 `后端拿着 appid + appsecret + code 去微信服务器`]

（5）openid 是用户在该公众号下的 **__ 唯一标识 ______**，不是 token；access_token 用来访问资源。⭐⭐ [来源：画布 Oauth2 授权码模式 `openid 是微信在这个用户在这个公众号下唯一标识，不是 token`]

（6）OIDC 与 OAuth2 的区别：OIDC 基于 OAuth2 增加 **___ 身份认证 _____**，返回 id_token 证明"这个用户是谁"，适合 SSO 单点登录（约 90% 企业 SSO 用授权码模式）。⭐⭐⭐ [来源：画布 OIDC实现SSO `OIDC 基于 OAuth2，增加身份认证，返回用户身份信息（id_token）`]

### 10.2 JWT 与 Spring Security

（7）OIDC 验签：认证中心（IdP）用 **___ 私钥 _____** 对 id_token 签名，业务系统用公钥验证签名。⭐⭐ [来源：画布 OIDC实现SSO `认证中心（IdP）（持有私钥）...用公钥对签名进行验证`]

（8）JWT 的定位：负责"打包数据 + 私钥签名"的通用 **___ token _____**，令牌自带全部信息、无状态；Session 则是服务端存状态、靠 cookie 传 sessionId。⭐⭐⭐ [来源：画布 Oauth2 授权码模式 + OIDC实现SSO]

（9）为什么很多项目里看不到 Spring Security：网关统一鉴权（网关校验 token 后把用户信息放 **__ 请求头 ______** 往下透传）、自研拦截器 + JWT + Redis、第三方 IAM/SSO 平台、内网系统权限简单。⭐⭐ [来源：画布 安全框架 `把用户信息、角色、权限放到请求头往下透传`]

---

*共 199 题（201 个填空），覆盖 Spring家族 模块全部重要知识点。*
*答案见同目录 `001OBSpring家族预习填空题答案.md`。*



