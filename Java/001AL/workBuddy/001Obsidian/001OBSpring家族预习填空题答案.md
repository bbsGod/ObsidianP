# 001OB · Spring家族 模块 · 预习填空题 · 答案版

> 📂 **源资料**
> - **所在路径**：`D:\Works\Interview\004-ObsidianCanvas\ObsidianP\Java`（项目内相对路径 `Java/`）
> - **源文件**：`多线程并发.canvas`
> - **参考模块**：画布顶层分组 `Spring家族`（含其下全部子分组、文本笔记、嵌入图片）
> - **生成日期**：2026-11-20　｜　**画布快照**：基于当日画布内容；画布改动后请对照 `00-源节点覆盖台账.md` 复核

> 📌 对照 `001OBSpring家族预习填空题.md` 使用。
> 📌 答案加粗标注，每题附来源。

---

## 模块一 · IOC 容器与 Bean 生命周期

> 💬 **口述框架**：先给一句话定义（控制权交给容器）→ 说清扫描后生成 BeanDefinition 图纸、它不是对象 → 按实例化 / 属性填充 / 初始化 / 使用中 / 销毁五阶段走一遍 → 点名 refresh() 是入口、AOP 代理在初始化后生成。常追问：BeanDefinition 存什么、@PostConstruct 与 afterPropertiesSet 的顺序、为什么用反射而不是 new。

### 1.1 Spring 与 IOC/DI 核心概念

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **AOP** | 画布·Spring主体 |
| （2） | **Spring 容器（IOC 容器）** | 画布·Spring主体 |
| （3） | **依赖对象** | 画布·Spring主体 |
| （4） | **SpringData** | 画布·Spring主体 |

### 1.2 Bean 的定义与扫描

| 编号 | 答案 | 来源 |
|------|------|------|
| （5） | **XML 配置文件** | 画布·如何定义bean |
| （6） | **不修改（改不了）** | 画布·如何定义bean |
| （7） | **工厂** | 画布·如何定义bean |
| （8） | **ConfigurationClassPostProcessor** | 画布·实例化 |
| （9） | **BeanDefinition** | 画布·bean实例化之前需要扫描、优化，创建bean的后置post处理器 |
| （10） | **元信息** | 画布·bean实例化之前需要扫描、优化，创建bean的后置post处理器 |

### 1.3 Bean 的实例化（4 种方式）

| 编号 | 答案 | 来源 |
|------|------|------|
| （11） | **反射**；**null** | 画布·实例化过程 |
| （12） | **编译** | 画布·实例化过程 |
| （13） | **FactoryBean** | 画布·实例化过程 |
| （14） | **getObject()** | 画布·实例化过程 |
| （15） | **工厂（实例工厂）** | 画布·实例化过程 |
| （16） | **ImportSelector** | 画布·实例化 |
| （17） | **第三方 jar 包** | 画布·实例化 |

### 1.4 DI 三种注入方式

| 编号 | 答案 | 来源 |
|------|------|------|
| （18） | **构造器** | 画布·实例化之后的属性赋值；DI三种注入方式，字段，setter，构造器 |
| （19） | **Spring** | 画布·实例化之后的属性赋值；DI三种注入方式，字段，setter，构造器 |
| （20） | **单元测试** | 画布·Bean |
| （21） | **实例化** | 画布·实例化之后的注入 |
| （22） | **造** | 画布·实例化之后的注入 |
| （23） | **构造器** | 画布·实例化之后的属性赋值；DI三种注入方式，字段，setter，构造器 |

### 1.5 Bean 生命周期完整流程

| 编号 | 答案 | 来源 |
|------|------|------|
| （24） | **refresh()** | 画布·Bean的生命周期 |
| （25） | **finishBeanFactoryInitialization** | 画布·Bean的生命周期 |
| （26） | **属性赋值（属性填充）** | 画布·Bean |
| （27） | **@Autowired** | 画布·bean的生命周期 |
| （28） | **@PostConstruct** | 画布·bean的生命周期 |
| （29） | **DisposableBean** | 画布·bean的生命周期 |
| （30） | **@PreDestroy** | 画布·bean的生命周期 |
| （31） | **单例池（singletonObjects）** | 画布·bean的生命周期 |

### 1.6 两大后置处理器与高频坑点

| 编号 | 答案 | 来源 |
|------|------|------|
| （32） | **BeanDefinition（Bean 定义）** | 画布·生命周期高频坑点 |
| （33） | **BeanFactoryPostProcessor** | 画布·bean实例化之前需要扫描、优化，创建bean的后置post处理器 |
| （34） | **invokeBeanFactoryPostProcessors** | 画布·两个post后置处理器 |
| （35） | **Bean 定义** | 画布·生命周期高频坑点（需纠错） |
| （36） | **初始化** | 画布·生命周期高频坑点（需纠错） |
| （37） | **销毁回调** | 画布·生命周期高频坑点 |
| （38） | **postProcessAfterInitialization** | 画布·bean的生命周期 |

### 1.7 Aware 接口与手写 IOC

| 编号 | 答案 | 来源 |
|------|------|------|
| （39） | **回调** | 画布·aware接口 |
| （40） | **反射** | 画布·IOC容器类 |
| （41） | **DefaultListableBeanFactory** | 画布·Bean工厂和IOC容器 |
| （42） | **没有资源加载、事件、国际化、AOP 支持** | 画布·Bean工厂和IOC容器 |
| （43） | **懒加载** | 画布·Bean工厂和IOC容器 |

---

## 模块二 · 三级缓存与循环依赖

> 💬 **口述框架**：先讲循环依赖是什么（A 依赖 B、B 又依赖 A）→ 说清三个缓存各存什么（成品 / 半成品 / 对象工厂）→ 强调只解决单例 + setter/字段注入，构造器注入解决不了 → 点出为什么需要第三级（提前暴露 AOP 代理）。常追问：为什么不能只用两级、多例为什么不行。

### 2.1 循环依赖与三级缓存结构

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **三级缓存** | 画布·三级缓存 |
| （2） | **singletonObjects** | 画布·三级缓存 |
| （3） | **ObjectFactory** | 画布·三级缓存 |
| （4） | **DefaultSingletonBeanRegistry** | 画布·三级缓存（表述需纠错）、外部·DefaultSingletonBeanRegistry |

### 2.2 三级缓存解决流程

| 编号 | 答案 | 来源 |
|------|------|------|
| （5） | **singletonFactories（三级缓存）** | 画布·三级缓存 |
| （6） | **getEarlyBeanReference** | 画布·三级缓存 |
| （7） | **闭环** | 画布·三级缓存 |
| （8） | **不再重复创建代理** | 画布·三级缓存 |

### 2.3 为什么不能删缓存（面试深挖）

| 编号 | 答案 | 来源 |
|------|------|------|
| （9） | **延迟** | 画布·三级缓存 |
| （10） | **生成多个不同的代理实例** | 画布·三级缓存 |
| （11） | **ObjectFactory** | 画布·三级缓存、百度·百度 |

### 2.4 无法解决的情况（纠错清单）

| 编号 | 答案 | 来源 |
|------|------|------|
| （12） | **单例（singleton）** | 画布·AOP（需纠错） |
| （13） | **实例化** | 画布·三级缓存（需纠错） |
| （14） | **setter** | 画布·三级缓存 |

---

## 模块三 · AOP 面向切面编程

> 💬 **口述框架**：一句话说横切逻辑抽离（日志 / 权限 / 监控 / 事务）→ 讲运行期织入 = 动态代理（JDK 接口 / CGLIB 子类）→ 说 @Pointcut 匹配 + 代理接管调用 → 对比 AspectJ 编译期织入。常追问：和「模板 + 回调接口(lambda)」目标相同但手段不同、自调用为什么不生效。

### 3.1 AOP 概念与应用场景

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **相同代码** | 画布·aop提炼相同代码、通过动态代理实现的jdk、cglib |
| （2） | **日志记录** | 画布·aop写日志，自带的事务 |
| （3） | **方法** | 画布·aop |

### 3.2 核心概念与通知类型

| 编号 | 答案 | 来源 |
|------|------|------|
| （4） | **Advice（通知）** | 画布·aop |
| （5） | **JoinPoint（连接点）** | 画布·aop |
| （6） | **@Around** | 画布·aop |
| （7） | **不管正常返回还是抛异常** | 画布·aop |
| （8） | **ProceedingJoinPoint** | 画布·aop |
| （9） | **生成代理对象** | 画布·织入 |
| （10） | **运行时（运行期）** | 画布·bean初始化阶段的后置处理 |

### 3.3 动态代理：JDK vs CGLIB

| 编号 | 答案 | 来源 |
|------|------|------|
| （11） | **JDK** | 画布·aop提炼相同代码、通过动态代理实现的jdk、cglib |
| （12） | **Proxy** | 画布·原生的JDK、CGLib代理的写法 |
| （13） | **invoke()** | 画布·原生的JDK、CGLib代理的写法 |
| （14） | **Enhancer** | 画布·原生的JDK、CGLib代理的写法 |
| （15） | **invokeSuper** | 画布·原生的JDK、CGLib代理的写法 |
| （16） | **动态代理** | 画布·反射和增强 |
| （17） | **功能加强（增强）** | 画布·反射和增强 |

### 3.4 AOP 发生时机（纠错清单）

| 编号 | 答案 | 来源 |
|------|------|------|
| （18） | **初始化之后（后置）** | 画布·织入 |
| （19） | **调用 Bean 方法** | 画布·AOP（需纠错） |

---

## 模块四 · Spring 事务

> 💬 **口述框架**：先说 @Transactional 本质就是一个 AOP 切面 → 讲事务状态绑在 ThreadLocal 上、同线程才能传播 → 背传播行为与隔离级别 → 重点讲失效场景（同类自调用、吞异常、非 public、异常类型不匹配、跨线程）。常追问：为什么同类内部调用不回滚。

### 4.1 声明式事务实现原理

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **AOP** | 画布·aop事务 |
| （2） | **调用** | 画布·事务实现 |
| （3） | **自动提交** | 画布·事务实现 |
| （4） | **回滚事务** | 画布·事务实现 |

### 4.2 事务 ACID

| 编号 | 答案 | 来源 |
|------|------|------|
| （5） | **原子性 A（Atomicity）** | 画布·事物的特效，原子性、隔离性、持久性都是为了保证一致性 |
| （6） | **一致性 C（Consistency）** | 画布·事物的特效，原子性、隔离性、持久性都是为了保证一致性 |
| （7） | **另一个合法状态** | 画布·事物的特效 |
| （8） | **永久落盘** | 画布·事物的特效 |

### 4.3 隔离级别与并发异常

| 编号 | 答案 | 来源 |
|------|------|------|
| （9） | **不稳定** | 画布·脏读、不可重复读、幻读的本质 |
| （10） | **一致性强度** | 画布·事务的隔离级别 |
| （11） | **脏读** | 画布·事务的隔离级别 |
| （12） | **不可重复读**；**Oracle** | 画布·事务的隔离级别 |
| （13） | **InnoDB** | 画布·事务的隔离级别 |
| （14） | **性能** | 画布·事务的隔离级别 |
| （15） | **数量不同（10 条 → 11 条）** | 画布·事务的隔离级别 |
| （16） | **可重复读** | 画布·事务的隔离级别 |
| （17） | **SET SESSION** | 画布·事务的隔离级别 |
| （18） | **排他** | 画布·数据行锁 |
| （19） | **索引** | 画布·数据行锁 |

### 4.4 事务传播行为

| 编号 | 答案 | 来源 |
|------|------|------|
| （20） | **当前线程** | 画布·AOP事务 |
| （21） | **B（被调用方）** | 画布·AOP事务 |
| （22） | **加了 @Transactional** | 画布·AOP事务（需纠错） |
| （23） | **REQUIRED** | 画布·事物的两个属性：propagration、isolation |
| （24） | **REQUIRES_NEW** | 画布·AOP事务 |
| （25） | **独立** | 画布·AOP事务 |
| （26） | **不影响** | 画布·AOP事务 |
| （27） | **新连接** | 画布·AOP事务 |
| （28） | **没事务** | 画布·AOP事务 |
| （29） | **新线程** | 画布·AOP事务 |

### 4.5 事务失效清单（纠错清单）

| 编号 | 答案 | 来源 |
|------|------|------|
| （30） | **public** | 画布·事务失效原因，代理无效和异常无效 |
| （31） | **this（内部直接）** | 画布·事务失效原因，代理无效和异常无效 |
| （32） | **捕获（吞掉）** | 画布·事务失效原因，代理无效和异常无效 |
| （33） | **RuntimeException** | 画布·事务失效原因，代理无效和异常无效 |

---

## 模块五 · Bean 作用域与单例线程安全

> 💬 **口述框架**：先列 singleton / prototype / request / session / application → 强调 singleton 是容器级单例不是 JVM 单例 → 讲单例 Bean 有状态就必须 ThreadLocal 或改 prototype → 连回并发模块。常追问：单例 Bean 里放一个计数器会怎样。

### 5.1 五大作用域

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **global-session** | 画布·bean作用域@scope、百度·百度 |
| （2） | **一个（唯一）** | 画布·bean作用域@scope |
| （3） | **新实例** | 画布·bean作用域@scope |
| （4） | **HTTP 请求** | 画布·bean作用域@scope |
| （5） | **@Lookup** | 画布·bean作用域@scope |

### 5.2 Spring 单例的实现（纠错清单）

| 编号 | 答案 | 来源 |
|------|------|------|
| （6） | **容器** | 画布·spring单例模式（需纠错） |
| （7） | **存在直接返回** | 画布·spring单例模式（需纠错） |
| （8） | **循环依赖** | 画布·spring单例模式 |

### 5.3 单例 Bean 线程安全（纠错清单）

| 编号 | 答案 | 来源 |
|------|------|------|
| （9） | **线程安全** | 画布·单例下线程安全（需纠错） |
| （10） | **可变** | 画布·单例下线程安全 |
| （11） | **局部** | 画布·单例下线程安全 |
| （12） | **ThreadLocal** | 画布·单例下线程安全 |
| （13） | **@Lazy** | 画布·bean作用域@scope |

---

## 模块六 · SpringBoot 核心原理

> 💬 **口述框架**：按 starter → @EnableAutoConfiguration → ImportSelector 读 imports 清单 → @Conditional 条件注解决定生效 → 自动配置类注册 Bean 这条链讲。易错：以为每个 starter 各带一份清单（其实是共用一份）；2.7+ 文件名已从 spring.factories 换成 .imports。

### 6.1 SpringBoot 定位与理念

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **脚手架** | 画布·SpringBoot和spring/SpringMVC的区别 |
| （2） | **约定大于配置** | 画布·介绍一下springboot |
| （3） | **JAR** | 画布·SpringBoot和spring/SpringMVC的区别 |
| （4） | **版本兼容（经过测试）** | 画布·SpringBoot和spring/SpringMVC的区别 |

### 6.2 自动配置原理

| 编号 | 答案 | 来源 |
|------|------|------|
| （5） | **@Configuration** | 画布·SpringBoot的启动原理 |
| （6） | **启动类（主类）** | 画布·spring常用注解 |
| （7） | **AutoConfigurationImportSelector** | 画布·SpringBoot的启动原理 |
| （8） | **AutoConfiguration.imports** | 画布·Starter理解 |
| （9） | **spring-boot-autoconfigure** | 画布·spring-boot-autoconfigure.jar和improts（需纠错） |
| （10） | **多份 imports** | 画布·spring-boot-autoconfigure.jar和improts |
| （11） | **@ConditionalOnClass** | 画布·spring-boot-autoconfigure.jar和improts |
| （12） | **@ConditionalOnMissingBean** | 画布·SpringBoot |

### 6.3 @Import 与 @EnableXXX

| 编号 | 答案 | 来源 |
|------|------|------|
| （13） | **原生** | 画布·import注解 |
| （14） | **@Import** | 画布·import注解 |

### 6.4 Starter 原理与自定义

| 编号 | 答案 | 来源 |
|------|------|------|
| （15） | **pom 依赖组合** | 画布·Starter理解 |
| （16） | **autoconfigure** | 画布·Starter理解 |
| （17） | **tomcat** | 画布·Starter-springboot-starter-web |
| （18） | **封装** | 画布·Starter启动器流程 |
| （19） | **@ConditionalOnProperty** | 画布·Starter启动器流程 |
| （20） | **@EnableConfigurationProperties** | 画布·Starter启动器流程 |
| （21） | **matchIfMissing** | 画布·Starter启动器流程 |
| （22） | **默认提供** | 画布·Starter启动器流程 |
| （23） | **条件注解** | 画布·Starter启动器流程 |

### 6.5 启动流程与事件

| 编号 | 答案 | 来源 |
|------|------|------|
| （24） | **ApplicationContext** | 画布·SpringBoot的启动原理 |
| （25） | **ApplicationContextInitializer（初始化器）** | 画布·SpringBoot的启动原理 |
| （26） | **配置源（配置类）** | 画布·SpringBoot的启动原理 |
| （27） | **BeanPostProcessor** | 画布·SpringBoot的启动原理 |
| （28） | **ApplicationRunner** | 画布·SpringBoot的启动原理 |
| （29） | **ApplicationReadyEvent** | 画布·SpringBoot的启动原理 |
| （30） | **/actuator/health** | 画布·介绍一下springboot |

---

## 模块七 · SpringMVC 与 RESTful

> 💬 **口述框架**：按请求链路讲 DispatcherServlet → HandlerMapping → Interceptor → HandlerAdapter → Controller → ViewResolver / @ResponseBody。常追问：Filter 与 Interceptor 的区别、Controller 是不是单例、参数绑定与返回值处理怎么做。

### 7.1 核心组件与请求流程

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **DispatcherServlet（前端控制器）** | 画布·SpringMVC整体结构和RestFull风格 |
| （2） | **HandlerMapping（处理器映射器）** | 画布·SpringMVC整体结构和RestFull风格 |
| （3） | **HandlerExecutionChain（执行链）** | 画布·SpringMVC整体结构和RestFull风格 |
| （4） | **统一** | 画布·SpringMVC整体结构和RestFull风格 |
| （5） | **ModelAndView** | 画布·SpringMVC整体结构和RestFull风格 |
| （6） | **路由分发** | 画布·SpringMVC整体结构和RestFull风格 |
| （7） | **自动配置** | 画布·SpringMVC整体结构和RestFull风格 |

### 7.2 RESTful 与 JSON 序列化

| 编号 | 答案 | 来源 |
|------|------|------|
| （8） | **@ResponseBody** | 画布·SpringMVC整体结构和RestFull风格 |
| （9） | **HttpMessageConverter** | 画布·SpringMVC整体结构和RestFull风格 |
| （10） | **MappingJackson2HttpMessageConverter** | 画布·SpringMVC整体结构和RestFull风格 |
| （11） | **PUT** | 画布·SpringMVC整体结构和RestFull风格 |
| （12） | **前后端分离** | 画布·SpringMVC整体结构和RestFull风格 |

---

## 模块八 · 常用注解、设计模式与事件机制

> 💬 **口述框架**：按用途分组背常用注解 → 点出 Spring 里用到的设计模式（工厂、单例、代理、模板方法、观察者）→ 事件机制 ApplicationEvent / Listener 是观察者模式落地，默认同步执行。常追问：@Component 与 @Bean 区别、事件能不能异步、循环依赖下的代理。

### 8.1 常用注解

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **@Controller** | 画布·spring常用注解 |
| （2） | **@Value** | 画布·spring常用注解 |
| （3） | **不支持** | 画布·spring常用注解 |
| （4） | **@RequestParam** | 画布·spring常用注解 |
| （5） | **Service** | 画布·spring常用注解 |

### 8.2 设计模式

| 编号 | 答案 | 来源 |
|------|------|------|
| （6） | **BeanFactory** | 画布·spring设计模式 |
| （7） | **单例** | 画布·spring设计模式 |
| （8） | **动态** | 画布·spring设计模式 |
| （9） | **JdbcTemplate** | 画布·spring设计模式 |
| （10） | **ApplicationListener** | 画布·spring设计模式 |
| （11） | **Interceptor（拦截器）** | 画布·spring设计模式 |
| （12） | **接力赛** | 画布·spring设计模式 |

### 8.3 事件机制

| 编号 | 答案 | 来源 |
|------|------|------|
| （13） | **ApplicationEvent** | 画布·DEMO |
| （14） | **@EventListener** | 画布·DEMO |
| （15） | **同步** | 画布·spring设计模式（需纠错） |
| （16） | **ApplicationEventMulticaster** | 画布·spring设计模式 |

---

## 模块九 · SpringCloud 微服务

> 💬 **口述框架**：按微服务要解决的问题讲：注册发现、负载均衡、熔断降级、网关、配置中心、链路追踪 → 每个问题对应一个组件 → 补 CAP 取舍。画布这块内容较少，作为了解层即可，别在这里恋战。

### 9.1 微服务与核心组件

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **独立** | 画布·SpringCloud |
| （2） | **注册中心** | 画布·SpringCloud |
| （3） | **声明式** | 画布·SpringCloud |
| （4） | **服务雪崩** | 画布·SpringCloud |
| （5） | **Predicate** | 画布·SpringCloud |
| （6） | **Seata** | 画布·SpringCloud |

### 9.2 负载均衡与链路追踪

| 编号 | 答案 | 来源 |
|------|------|------|
| （7） | **LoadBalancer** | 画布·SpringCloud |
| （8） | **Trace** | 画布·SpringCloud |

### 9.3 配置中心与消息组件

| 编号 | 答案 | 来源 |
|------|------|------|
| （9） | **DataId** | 画布·SpringCloud |
| （10） | **Broker** | 画布·SpringCloud |

---

## 模块十 · 认证授权与安全

> 💬 **口述框架**：先分清认证（你是谁）与授权（你能干什么）→ 讲 Session/Cookie、JWT、OAuth2 授权码模式的四种角色与流程 → 点出 CSRF 与 XSS 的区别。常追问：token 放哪、为什么前后端分离把 token 放请求头就天然免疫 CSRF。

### 10.1 OAuth2 与 OIDC

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **授权** | 画布·Oauth2 |
| （2） | **客户端** | 画布·Oauth2 |
| （3） | **授权码** | 画布·Oauth2 |
| （4） | **appsecret** | 画布·Oauth2 |
| （5） | **唯一标识** | 画布·Oauth2 |
| （6） | **身份认证** | 画布·OIDC实现SSO |

### 10.2 JWT 与 Spring Security

| 编号 | 答案 | 来源 |
|------|------|------|
| （7） | **私钥** | 画布·OIDC实现SSO |
| （8） | **标准格式（令牌载体）** | 画布·Oauth2 |
| （9） | **请求头** | 画布·安全框架 |

---

*全部 199 题（201 个填空）答案已给出。*
*建议：先独立完成填空题，再对照检查，错题回看画布对应位置。*
