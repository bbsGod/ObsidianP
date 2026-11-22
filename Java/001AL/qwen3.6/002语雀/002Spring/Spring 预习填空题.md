# Spring 预习填空题

> 📌 基于 `D:\Works\Interview\004-ObsidianCanvas\ObsidianP\Java\001AL\语雀备份\个人空间\邀请协作的\Java_8_Gu_9\Spring` 下 55 个源文件及外部知识整理。
>
> 📌 每题后标注：⭐ 重要程度 + 来源。目的是让你填空 → 对答案 → 面试能讲出来。
>
> 📌 ⭐⭐⭐=高频必考，⭐⭐=重要，⭐=补充了解。
>
> 📌 使用方式：直接做填空 → 对照答案版 → 错题回源文件看原内容。

---

## 模块一 · Spring 核心 IOC（控制反转）

### 1. IOC 基本概念

（1）IOC 的全称是 **________**，意思是控制反转。⭐⭐⭐ [来源：文件《介绍一下Spring的IOC.md》]

（2）在 IOC 之前，对象的创建权在 **________** 手中；有了 IOC 之后，对象的创建权转移到了 **________** 中。⭐⭐⭐ [来源：文件《介绍一下Spring的IOC.md》]

（3）IOC 只是一种 **________** 和 **________**，可以有不同实现方式。⭐⭐ [来源：文件《介绍一下Spring的IOC.md》]

（4）Spring IOC 容器在容器启动时，会根据每个 bean 的要求，将 bean 注入到 **________** 中。⭐⭐ [来源：文件《介绍一下Spring的IOC.md》]

### 2. Bean 的创建方式

（5）Spring 中通过注解创建 Bean 的四大注解是：@**________**、@**________**、@**________**、@**________**。⭐⭐⭐ [来源：文件《Spring中创建Bean有几种方式.md》]

（6）在 @Configuration 类中使用 **________** 注解标记方法，可以定义一个 Bean。⭐⭐⭐ [来源：文件《Spring中创建Bean有几种方式.md》]

（7）Spring 创建 Bean 的第五种方式是通过 **________** 注解快速导入类，使其被 Spring IOC 容器管理。⭐⭐ [来源：文件《Spring中创建Bean有几种方式.md》]

（8）XML 方式定义 Bean 时，如果没有指定 factory-method，默认调用类的 **________** 创建 Bean。⭐⭐ [来源：文件《Spring中创建Bean有几种方式.md》]

### 3. Bean 的注入方式

（9）@Autowired 可以标注在 **________**、**________**、**________** 以及参数上。⭐⭐⭐ [来源：文件《Spring中注入Bean有几种方式.md》]

（10）@Resource 是 **________** 官方提供的注入注解（JSR-250），不属于 Spring 框架。⭐⭐⭐ [来源：文件：文件《Autowired和Resource的关系.md》]

（11）@Autowired 注入时的匹配顺序是：先 **________**，再 **________**。⭐⭐⭐ [来源：文件：文件《Autowired和Resource的关系.md》]

（12）@Resource 注入时的匹配顺序是：先 **________**，再 **________**。⭐⭐⭐ [来源：文件：文件《Autowired和Resource的关系.md》]

（13）当 @Autowired 找不到必需 Bean 时，默认会 **________**；设置 required = false 时，找不到则注入 **________**。⭐⭐ [来源：文件：文件《Autowired和Resource的关系.md》]

（14）@Autowired 可以用在 **________** 注入上，此时 key 是 bean 的名称，value 是 bean 的实例。⭐⭐ [来源：文件：文件《Spring的@Autowired能用在Map上吗.md》]

（15）Spring Bean 注入的最后一种隐式方式是：Spring 4.3 起，如果类中只有一个构造函数，即使不标 @Autowired，也能自动 **________**。⭐⭐ [来源：文件：文件《Spring中注入Bean有几种方式.md》]

### 4. Bean 作用域

（16）Spring 中默认的 Bean 作用域是 **________**。⭐⭐⭐ [来源：文件：文件《Spring中的Bean作用域有哪些.md》+ 文件《Spring中用到了哪些设计模式.md》]

（17）除了 singleton，Spring 支持的 Bean 作用域还有：**________**、**________**、**________**、**________**（仅 Web 应用）、**________**（仅 Web 应用）。⭐⭐ [来源：文件：文件《Spring中的Bean作用域有哪些.md》+ 文件《Spring中用到了哪些设计模式.md》]

（18）request 作用域的 Bean 在 **________** 内有效；session 作用域的 Bean 在 **________** 内有效。⭐⭐ [来源：文件：文件《Spring中用到了哪些设计模式.md》]

### 5. Bean 线程安全

（19）**________** 作用域的 Bean 不存在线程安全问题，因为每次获取都创建新实例。⭐⭐⭐ [来源：文件：文件《Spring中的Bean是线程安全的吗.md》]

（20）Singleton 的 Bean 是否有线程安全问题，取决于 **________** 中是否有 **________**。⭐⭐⭐ [来源：文件：文件《Spring中的Bean是线程安全的吗.md》]

（21）有状态的 Singleton Bean 解决线程安全问题的三种方式是：修改作用域为 **________**、**________**、使用并发工具类（如 **________**）。⭐⭐ [来源：文件：文件《Spring中的Bean是线程安全的吗.md》]

### 6. BeanFactory vs FactoryBean

（22）**________** 是 Spring IoC 容器的基础接口，负责管理 Bean 的创建和生命周期，提供 getBean() 方法。⭐⭐⭐ [来源：文件：文件《BeanFactory和FactroyBean的关系.md》]

（23）**________** 是一个接口，用于定义一个工厂 Bean，Spring 容器返回的是 FactoryBean#getObject() 方法所返回的对象，而不是 FactoryBean 实例本身。⭐⭐⭐ [来源：文件：文件《BeanFactory和FactroyBean的关系.md》]

（24）Dubbo 的 ReferenceBean 实现了 **________** 接口，用于创建远程服务代理对象。⭐⭐ [来源：文件：文件《BeanFactory和FactroyBean的关系.md》]

### 7. @Component 系列注解区别

（25）@Service、@Component、@Repository、@Controller 在功能上 **________**，区别仅在于 **________**。⭐⭐⭐ [来源：文件：文件《Spring中@Service、@Component、@Repository等注解区别是什么.md》]

（26）@Repository 除了将类标识为 Spring 组件外，还能让 Spring 为其提供一些 **________** 特定的功能，比如 **________**。⭐⭐ [来源：文件：文件《Spring中@Service、@Component、@Repository等注解区别是什么.md》]

---

## 模块二 · Spring Bean 生命周期

### 1. 生命周期阶段

（27）Spring Bean 生命周期大致可分为 5 个小阶段：**________**、**________**、注册 Destruction 回调、**________**、**________**。⭐⭐⭐ [来源：文件：文件《Spring_Bean的生命周期是怎么样的.md》+ 文件《Spring_Bean的初始化过程是怎么样的.md》]

（28）实例化（Instantiation）对应 doCreateBean 中的 **________** 方法。⭐⭐ [来源：文件：文件《Spring_Bean的初始化过程是怎么样的.md》]

（29）初始化（Initialization）对应 doCreateBean 中的 **________** 和 **________** 方法。⭐⭐ [来源：文件：文件《Spring_Bean的初始化过程是怎么样的.md》]

（30）整个 Bean 的创建过程依赖于 **________** 类，销毁主要依赖 **________** 类。⭐⭐⭐ [来源：文件：文件《Spring_Bean的生命周期是怎么样的.md》]

### 2. 初始化详细流程

（31）Bean 初始化时，Aware 接口包括：**________**Aware、**________**ClassLoaderAware、**________**FactoryAware。⭐⭐⭐ [来源：文件：文件《Spring_Bean的初始化过程是怎么样的.md》]

（32）BeanPostProcessor 的前置处理方法叫 **________**，后置处理方法叫 **________**。⭐⭐⭐ [来源：文件：文件《Spring_Bean的生命周期是怎么样的.md》]

（33）AOP 代理对象的创建是在 BeanPostProcessor 的 **________** 阶段完成的，具体在 **________** 类的 postProcessAfterInitialization 方法中。⭐⭐⭐ [来源：文件：文件《Spring_Bean的初始化过程是怎么样的.md》+ 文件《介绍一下Spring的AOP.md》]

### 3. 初始化方法执行顺序

（34）@PostConstruct、afterPropertiesSet、init-method 三者的执行顺序是：**________** > @**________** > **________** > **________**。⭐⭐⭐ [来源：文件：文件《@PostConstruct、init-method和afterPropertiesSet执行顺序.md》]

（35）@PostConstruct 是由 **________** 处理器（CommonAnnotationBeanPostProcessor）在 BeanPostProcessor 的 **________** 阶段调用的。⭐⭐ [来源：文件：文件《@PostConstruct、init-method和afterPropertiesSet执行顺序.md》]

### 4. 销毁阶段

（36）如果 Bean 实现了 **________** 接口或在 Bean 定义中指定了自定义的销毁方法，Spring 容器会为其注册销毁回调。⭐⭐ [来源：文件：文件《Spring_Bean的生命周期是怎么样的.md》]

（37）Spring 向 JVM 注册的 **________** 用于在应用关闭时执行 bean 的销毁和容器清理操作。⭐⭐⭐ [来源：文件：文件《Spring中shutdownhook作用是什么.md》]

### 5. Bean 初始化顺序控制

（38）让 Bean A 在 Bean B 之前初始化的三种方式是：直接依赖、使用 **________** 注解、实现 **________** 接口。⭐⭐ [来源：文件：文件《Spring_Boot_如何让你的_bean_在其他_bean_之前加载.md》]

（39）@DependsOn 可以作用在 **________** 注解上面，也可以作用在 **________** 方法上。⭐⭐ [来源：文件：文件《Spring_Boot_如何让你的_bean_在其他_bean_之前加载.md》]

### 6. Bean 无法初始化的原因

（40）SpringBoot 2.6 开始，默认 **________** 对循环依赖的支持，之前是默认支持的。⭐⭐⭐ [来源：文件：文件《有什么情况会导致一个bean无法被初始化么_.md》+ 文件《Spring默认支持循环依赖吗_如果发生如何解决_.md》]

（41）Spring 三级缓存无法解决 **________** 注入和 **________** 作用域的循环依赖。⭐⭐⭐ [来源：文件：文件《什么是Spring的循环依赖问题_.md》+ 文件《有什么情况会导致一个bean无法被初始化么_.md》]

---

## 模块三 · Spring AOP（面向切面编程）

### 1. AOP 基本概念

（42）AOP 的全称是 **________**，是 OOP 的补充。⭐⭐⭐ [来源：文件：文件《介绍一下Spring的AOP.md》]

（43）AOP 的核心思想是把 **________** 的逻辑抽出来，让开发者更专注于 **________** 开发。⭐⭐⭐ [来源：文件：文件《介绍一下Spring的AOP.md》]

（44）AOP 五大术语：Aspect（**________**）、JoinPoint（**________**）、PointCut（**________**）、Advice（**________**）、Target（**________**）。⭐⭐⭐ [来源：文件：文件《介绍一下Spring的AOP.md》]

（45）Advice 的五种类型：Before Advice、After returning advice、After throwing advice、After finally advice、**________** advice。⭐⭐ [来源：文件：文件《介绍一下Spring的AOP.md》]

（46）**________** 决定通知应该作用于哪些方法（where 角色），**________** 定义拦截后做什么（what 角色）。⭐⭐⭐ [来源：文件：文件《介绍一下Spring的AOP.md》]

### 2. AOP 实现原理

（47）如果目标对象实现了接口，Spring AOP 使用 **________** 动态代理；如果没有实现接口，使用 **________** 代理。⭐⭐⭐ [来源：文件：文件《介绍一下Spring的AOP.md》]

（48）Spring AOP 默认使用 **________** 进行 AOP 代理。⭐⭐ [来源：文件：文件《介绍一下Spring的AOP.md》]

（49）AOP 在 bean 生命周期的 **________** 阶段创建代理对象，具体在 applyBeanPostProcessorsAfterInitialization 部分。⭐⭐⭐ [来源：文件：文件《介绍一下Spring的AOP.md》]

（50）创建代理的核心方法是 **________**，它判断 bean 是否在 targetSourcedBeans 集合中、是否是基础设施类、是否存在 **________**。⭐⭐ [来源：文件：文件《介绍一下Spring的AOP.md》]

### 3. AOP 失效场景

（51）Spring AOP 在以下场景会失效：**________** 方法、**________** 方法、**________** 方法、类内部 **________** 调用。⭐⭐⭐ [来源：文件：文件《Spring的AOP在什么场景下会失效.md》]

（52）AOP 失效的根本原因是：没有调用到 **________** 对象，而是用原始对象直接调用了。⭐⭐⭐ [来源：文件：文件《Spring的AOP在什么场景下会失效.md》]

---

## 模块四 · Spring 循环依赖

### 1. 循环依赖概念

（53）循环依赖是指两个或多个 bean 之间 **________**，形成了一个 **________** 的情况。⭐⭐⭐ [来源：文件：文件《什么是Spring的循环依赖问题_.md》]

（54）Spring 解决循环依赖的前提条件：互相依赖的 Bean 必须都是 **________** 的，且依赖注入方式不能都是 **________** 注入。⭐⭐⭐ [来源：文件：文件《什么是Spring的循环依赖问题_.md》]

（55）只支持单例解决循环依赖的原因是：单例对象的创建和初始化 **________**，可以缓存并复用 **________** 对象。⭐⭐ [来源：文件：文件《什么是Spring的循环依赖问题_.md》]

### 2. 三级缓存

（56）一级缓存（singletonObjects）存储 **________** 的单例 bean 对象。⭐⭐⭐ [来源：文件：文件《三级缓存是如何解决循环依赖的问题的_.md》+ 文件《什么是Spring的三级缓存.md》]

（57）二级缓存（earlySingletonObjects）存储 **________** 的单例 bean 对象（半成品）。⭐⭐⭐ [来源：文件：文件《什么是Spring的三级缓存.md》]

（58）三级缓存（singletonFactories）存储的是单例 bean 的 **________**（ObjectFactory）。⭐⭐⭐ [来源：文件：文件《什么是Spring的三级缓存.md》]

（59）引入三级缓存的核心原因是：为了解耦 Bean 的 **________** 和 **________**，让 AOP 代理在 Bean 生命周期的最后一步完成。⭐⭐⭐ [来源：文件：文件《Spring解决循环依赖一定需要三级缓存吗.md》]

（60）三级缓存中的 ObjectFactory 是一个函数式接口：`() -> **________**(beanName, mbd, bean)`。⭐⭐⭐ [来源：文件：文件《Spring解决循环依赖一定需要三级缓存吗.md》]

### 3. @Lazy 解决循环依赖

（61）**________** 注解用于延迟一个 bean 的初始化，直到它第一次被使用。⭐⭐⭐ [来源：文件：文件《@Lazy注解能解决循环依赖吗.md》]

（62）@Lazy 可以解决 **________** 注入方式下的循环依赖问题。⭐⭐⭐ [来源：文件：文件《@Lazy注解能解决循环依赖吗.md》+ 文件《什么是Spring的循环依赖问题_.md》]

（63）解决循环依赖的其他方式：重新设计消除循环依赖、改成 **________** 注入、使用 **________** 注解。⭐⭐ [来源：文件：文件《什么是Spring的循环依赖问题_.md》]

---

## 模块五 · Spring 事务管理

### 1. 事务开启方式

（64）Spring 事务有两种实现方式：**________** 事务和 **________** 事务。⭐⭐⭐ [来源：文件：文件《Spring中如何开启事务.md》]

（65）声明式事务使用 **________** 注解即可给方法增加事务控制。⭐⭐⭐ [来源：文件：文件《Spring中如何开启事务.md》]

（66）编程式事务可以使用 **________** 或 **________** API 手动管理事务。⭐⭐ [来源：文件：文件《Spring中如何开启事务.md》]

### 2. @Transactional 实现原理

（67）@Transactional 的核心原理是通过 **________** 创建代理对象，并在方法调用前后介入事务管理逻辑。⭐⭐⭐ [来源：文件：文件《Spring中@Transactional事务的实现原理.md》+ 文件《Spring事务失效可能是哪些原因.md》]

（68）@Transactional 注解通过 **________** 类解析注解属性，并传递给 **________** 拦截器。⭐⭐ [来源：文件：文件《Spring中@Transactional事务的实现原理.md》]

（69）事务管理的核心方法是 **________**，它负责：获取事务属性 → 确定事务管理器 → **________** → 执行目标方法 → 成功则 **________** / 异常则 **________**。⭐⭐⭐ [来源：文件：文件《Spring中@Transactional事务的实现原理.md》]

（70）@Transactional 默认只有 **________** 和 **________** 会触发回滚，需要指定 `rollbackFor = **________**` 才能让所有异常都回滚。⭐⭐⭐ [来源：文件：文件《Spring的事务传播机制有哪些.md》+ 文件《Spring事务失效可能是哪些原因.md》]

### 3. 事务传播机制

（71）Spring 规定了 **________** 种事务传播级别，默认是 **________**。⭐⭐⭐ [来源：文件：文件《Spring的事务传播机制有哪些.md》]

（72）**________**：如果不存在事务则开启新事务，存在则加入当前事务（总是只有一个事务在执行）。⭐⭐⭐ [来源：文件：文件《Spring的事务传播机制有哪些.md》]

（73）**________**：每次执行新开一个事务，如果当前存在事务则把当前事务挂起。⭐⭐ [来源：文件：文件《Spring的事务传播机制有哪些.md》]

（74）**________**：有事务则加入，没有事务则普通执行。⭐⭐ [来源：文件：文件《Spring的事务传播机制有哪些.md》]

（75）**________**：有事务则暂停该事务，没有则普通执行。⭐⭐ [来源：文件：文件《Spring的事务传播机制有哪些.md》]

（76）**________**：强制有事务，没有则报异常；**________**：有事务则报异常。⭐⭐ [来源：文件：文件《Spring的事务传播机制有哪些.md》]

（77）**________**：如果之前有事务，则创建嵌套事务，嵌套事务回滚不影响父事务，反之父事务影响嵌套事务。⭐⭐ [来源：文件：文件《Spring的事务传播机制有哪些.md》]

### 4. 事务失效场景

（78）@Transactional 应用在 **________** 修饰的方法上会失效。⭐⭐⭐ [来源：文件：文件《Spring事务失效可能是哪些原因.md》+ 文件《Spring的AOP在什么场景下会失效.md》]

（79）同一个类中方法调用（**________** 调用）会导致 @Transactional 失效。⭐⭐⭐ [来源：文件：文件《Spring事务失效可能是哪些原因.md》]

（80）异常被 **________** 捕获会导致 @Transactional 失效。⭐⭐⭐ [来源：文件：文件《Spring事务失效可能是哪些原因.md》]

（81）Bean 没有被 Spring 管理（自己 **________** 了一个 Bean）会导致事务失效。⭐⭐ [来源：文件：文件《Spring事务失效可能是哪些原因.md》]

（82）事务中使用了 **________** 会导致声明式事务失效，因为 ThreadLocal 是线程隔离的。⭐⭐⭐ [来源：文件：文件《Spring事务失效可能是哪些原因.md》+ 文件《Spring的事务在多线程下生效吗_为什么.md》]

（83）**________** 引擎不支持事务（如 MyISAM）会导致事务失效。⭐⭐ [来源：文件：文件《Spring事务失效可能是哪些原因.md》]

### 5. 事务在多线程下的表现

（84）@Transactional 使用 **________** 机制来存储事务上下文，因此多线程环境下事务会 **________**。⭐⭐⭐ [来源：文件：文件《Spring的事务在多线程下生效吗_为什么.md》+ 文件《同时使用@Transactional与@Async时,事务会不会生效_.md》]

（85）如果 @Transactional 和 @Async 加在 **________** 方法上，事务会生效。⭐⭐ [来源：文件：文件《同时使用@Transactional与@Async时,事务会不会生效_.md》]

（86）@Transactional 方法 A 调用 @Async 方法 B，A 抛异常会回滚，但 B **________** 回滚。⭐⭐⭐ [来源：文件：文件《同时使用@Transactional与@Async时,事务会不会生效_.md》]

### 6. 事务事件

（87）**________** 注解用于处理事务事件，可以在事务提交前后或回滚前后触发事件监听器。⭐⭐ [来源：文件：文件《Spring中的事务事件如何使用.md》]

（88）TransactionalEventListener 的 phase 属性有四种：BEFORE_COMMIT、**________**、**________**、AFTER_COMPLETION。⭐⭐ [来源：文件：文件《Spring中的事务事件如何使用.md》]

---

## 模块六 · Spring Boot 基础

### 1. Spring vs Spring Boot

（89）Spring Boot 的主要作用是 **________** Spring 应用程序的开发和部署。⭐⭐⭐ [来源：文件：文件《SpringBoot和Spring的区别是什么.md》]

（90）Spring Boot 相比 Spring 的三个核心提升：**________**、**________** Web 服务器、**________** 大于配置。⭐⭐⭐ [来源：文件：文件《SpringBoot和Spring的区别是什么.md》]

### 2. 自动配置

（91）Spring Boot 自动配置的核心注解是 **________**，它是一个组合注解，包含了 @SpringBootConfiguration、@**________**、@ComponentScan。⭐⭐⭐ [来源：文件：文件《Springboot是如何实现自动配置的.md》]

（92）@EnableAutoConfiguration 中 @Import 了 **________** 类，它是自动配置的"始作俑者"。⭐⭐⭐ [来源：文件：文件《Springboot是如何实现自动配置的.md》]

（93）EnableAutoConfigurationImportSelector 通过读取 **________** 文件中的 key 为 `org.springframework.boot.autoconfigure.EnableAutoConfiguration` 的值来实现自动配置。⭐⭐⭐ [来源：文件：文件《Springboot是如何实现自动配置的.md》]

（94）Spring Boot 2.7+ 新的自动配置注册文件路径是：`META-INF/spring/` **________**。⭐⭐⭐ [来源：文件：文件《如何自定义一个starter.md》+ 文件《为什么SpringBoot_3中移除了spring.factories.md》]

（95）@Conditional 系列注解中，**________** 表示类存在时配置、**________** 表示 Bean 不存在时配置、**________** 表示属性满足条件时配置。⭐⭐ [来源：文件：文件《Springboot是如何实现自动配置的.md》]

### 3. 启动流程

（96）SpringBoot 启动入口是 `SpringApplication.**________**(Application.class, args)`。⭐⭐⭐ [来源：文件：文件《SpringBoot的启动流程是怎么样的.md》]

（97）SpringApplication 初始化阶段的 initialize 方法中，从 spring.factories 加载 **________** 和 **________** 两类组件。⭐⭐⭐ [来源：文件：文件《SpringBoot的启动流程是怎么样的.md》]

（98）refreshContext 中的 refresh → **________** 方法负责启动内嵌 Web 容器（Tomcat/Jetty/Undertow）。⭐⭐⭐ [来源：文件：文件《SpringBoot的启动流程是怎么样的.md》+ 文件《SpringBoot是如何实现main方法启动Web项目的.md》]

（99）SpringBoot 默认使用 **________** 作为内嵌 Web 服务器，factory 有三种实现：TomcatServletWebServerFactory、**________**、UndertowServletWebServerFactory。⭐⭐ [来源：文件：文件《SpringBoot是如何实现main方法启动Web项目的.md》+ 文件《SpringBoot的启动流程是怎么样的.md》]

（100）SpringApplication.run 中，**________** 方法用于在应用启动后执行缓存预热等初始化逻辑（如 CommandLineRunner / ApplicationRunner）。⭐⭐ [来源：文件：文件《SpringBoot的启动流程是怎么样的.md》+ 文件《如何在Spring启动过程中做缓存预热.md》]

### 4. 双亲委派模型

（101）Spring Boot 打破了传统双亲委派模型，使用 **________** 替代 AppClassLoader，以支持 **________** JAR 运行模式。⭐⭐⭐ [来源：文件：文件《SpringBoot和传统的双亲委派有什么不一样吗.md》]

（102）LaunchedURLClassLoader 的加载顺序：先加载 **________** 目录下的应用类，再加载 **________** 下的依赖 JAR，最后才交给父类加载器。⭐⭐⭐ [来源：文件：文件《SpringBoot和传统的双亲委派有什么不一样吗.md》]

### 5. 优雅停机

（103）从 Spring Boot **________** 开始，内置了优雅停机功能，配置为 `server.shutdown=**________**`。⭐⭐ [来源：文件：文件《SpringBoot如何做优雅停机.md》]

（104）优雅停机的最大等待时间配置为：`spring.lifecycle.timeout-per-shutdown-phase=**________**`，默认等待 **________** 秒。⭐⭐ [来源：文件：文件《SpringBoot如何做优雅停机.md》]

### 6. 多环境配置

（105）Spring Profile 通过 **________** 注解在不同环境中定义特定配置。⭐⭐⭐ [来源：文件：文件《Spring中如何实现多环境配置.md》]

（106）激活 Profile 的方式包括：环境变量 **________**、JVM 参数 `-Dspring.profiles.active=prod`、application.properties 中 `spring.profiles.active`。⭐⭐ [来源：文件：文件《Spring中如何实现多环境配置.md》]

---

## 模块七 · Spring MVC

### 1. MVC 基础

（107）MVC 代表 **________**、**________**、**________**，核心思想是将应用的 **________** 和 **________** 分离开。⭐⭐ [来源：文件：文件《什么是MVC.md》]

### 2. Request 路由

（108）Spring MVC 启动时，把带有 @RequestMapping 注解的方法和类封装成 **________** 和 **________**，注册到 **________** 中。⭐⭐⭐ [来源：文件：文件《SpringMVC是如何将不同的Request路由到不同Controller中的.md》]

（109）HttpServletRequest 访问时，通过 **________** 方法获取对应的 HandlerMethod。⭐⭐⭐ [来源：文件：文件《SpringMVC是如何将不同的Request路由到不同Controller中的.md》]

（110）RequestMappingInfo 聚合了 @RequestMapping 的多种匹配条件，包括：**________**、**________**、params、headers、consumes、produces 等。⭐⭐ [来源：文件：文件《SpringMVC是如何将不同的Request路由到不同Controller中的.md》]

### 3. 流式输出

（111）Spring MVC 实现流式输出的三种方式：**________** + StreamingResponseBody、**________**（Server-Sent Events）、**________**（响应式）。⭐⭐⭐ [来源：文件：文件《SpringMVC中如何实现流式输出.md》]

（112）SseEmitter 中，**________** 方法用于发送数据，**________** 用于正常结束连接。⭐⭐ [来源：文件：文件《SpringMVC中如何实现流式输出.md》]

（113）推荐使用 **________** 实现流式输出，因为它是异步非阻塞的。⭐⭐ [来源：文件：文件《SpringMVC中如何实现流式输出.md》]

---

## 模块八 · Spring 中的设计模式

（114）Spring IOC 容器是 **________** 模式的典型代表。⭐⭐⭐ [来源：文件：文件《Spring中用到了哪些设计模式.md》]

（115）SpringMVC 的参数解析模块使用了 **________** 模式（HandlerMethodArgumentResolver 接口 + 子接口聚合）。⭐⭐ [来源：文件：文件《Spring中用到了哪些设计模式.md》]

（116）SpringMVC 中的 **________** 是适配器模式的典型代表，DispatcherServlet 只调用其 handle 方法。⭐⭐⭐ [来源：文件：文件《Spring中用到了哪些设计模式.md》]

（117）Spring AOP 是 **________** 模式的典型代表。⭐⭐⭐ [来源：文件：文件《Spring中用到了哪些设计模式.md》]

（118）**________** 模式是 Spring Bean 默认单例功能的基础。⭐⭐⭐ [来源：文件：文件《Spring中用到了哪些设计模式.md》]

（119）Spring Event 是 **________** 模式的实现。⭐⭐⭐ [来源：文件：文件《Spring中用到了哪些设计模式.md》+ 文件《在Spring中如何使用Spring_Event做事件驱动.md》]

（120）TransactionTemplate 使用了 **________** 模式，固定三步：执行业务逻辑 → 异常则回滚 → 否则提交。⭐⭐ [来源：文件：文件《Spring中用到了哪些设计模式.md》]

（121）SpringMVC 的 HandlerExecutionChain 封装了 HandlerAdapter 和一系列拦截器，使用了 **________** 模式。⭐⭐ [来源：文件：文件《Spring中用到了哪些设计模式.md》]

---

## 模块九 · Spring 新特性

### 1. Spring 6.0 / Spring Boot 3.0

（122）Spring Framework 6.0 和 Spring Boot 3.0 要求的最低 JDK 版本是 **________**。⭐⭐⭐ [来源：文件：文件《Spring_6.0和SpringBoot_3.0有什么新特性.md》]

（123）Spring 6.0/Boot 3.0 底层依赖从 Java EE 迁移到了 **________** EE。⭐⭐⭐ [来源：文件：文件《Spring_6.0和SpringBoot_3.0有什么新特性.md》]

（124）Spring Boot 3.0 支持基于 **________** VM 将应用编译成 **________** 镜像（AOT 编译）。⭐⭐⭐ [来源：文件：文件《Spring_6.0和SpringBoot_3.0有什么新特性.md》+ 文件《为什么SpringBoot_3中移除了spring.factories.md》]

### 2. Spring 7.0 / Spring Boot 4.0

（125）Spring 7.0 中 **________** 正式弃用，推荐使用 RestClient 和 WebClient。⭐⭐⭐ [来源：文件：文件《Spring_7_和Spring_Boot_4_都有哪些新特性.md》]

（126）Spring 7.0 中 @Retryable 变成 **________** 的，不再需要单独依赖 spring-retry 包。⭐⭐ [来源：文件：文件《Spring_7_和Spring_Boot_4_都有哪些新特性.md》]

（127）Spring 7.0 引入了 **________** 限制注解 @ConcurrencyLimit，支持固定上限或 **________** 算法。⭐⭐ [来源：文件：文件《Spring_7_和Spring_Boot_4_都有哪些新特性.md》]

（128）Spring Boot 4.0 开启虚拟线程的配置：`spring.threads.virtual.enabled: **________**`。⭐⭐⭐ [来源：文件：文件《Spring_7_和Spring_Boot_4_都有哪些新特性.md》]

（129）Spring 7 框架代码全面采用 **________** 的 @Nullable/@NonNull 注解实现空安全。⭐⭐ [来源：文件：文件《Spring_7_和Spring_Boot_4_都有哪些新特性.md》]

（130）Spring Boot 4.0 中 @RequestMapping 引入了 **________** 属性进行 API 版本控制。⭐⭐ [来源：文件：文件《Spring_7_和Spring_Boot_4_都有哪些新特性.md》]

---

## 模块十 · Spring 业务实践

### 1. Spring Event 事件驱动

（131）Spring Event 基于 **________** 模式实现，需要定义三个内容：**________**、事件发布者、事件监听器。⭐⭐⭐ [来源：文件：文件《在Spring中如何使用Spring_Event做事件驱动.md》]

（132）事件类需要继承 **________** 类；监听器使用 **________** 注解标识。⭐⭐⭐ [来源：文件：文件《在Spring中如何使用Spring_Event做事件驱动.md》]

（133）默认情况下 Spring Event 是 **________** 调用的，加 **________** 注解可实现异步。⭐⭐ [来源：文件：文件《在Spring中如何使用Spring_Event做事件驱动.md》]

### 2. @Scheduled 定时任务

（134）@Scheduled 的三种调度方式：**________**（固定间隔）、**________**（固定延迟）、**________** 表达式。⭐⭐⭐ [来源：文件：文件《介绍下@Scheduled的实现原理以及用法.md》]

（135）@Scheduled 默认使用 **________** 线程池（单线程），Spring 6.1 后需手动指定 **________**。⭐⭐ [来源：文件：文件《介绍下@Scheduled的实现原理以及用法.md》]

（136）启用定时任务需要加 **________** 注解。⭐⭐ [来源：文件：文件《介绍下@Scheduled的实现原理以及用法.md》+ 文件《知道Spring_Task吗,和XXL-JOB有啥区别_.md》]

（137）Spring Task 适合 **________** 场景，XXL-JOB 适合 **________** 调度场景。⭐⭐ [来源：文件：文件《知道Spring_Task吗,和XXL-JOB有啥区别_.md》]

### 3. @Async 异步

（138）@Async 默认使用 **________** 线程池，它不是真正的线程池，每次调用都会创建 **________**。⭐⭐⭐ [来源：文件：文件《为什么不建议直接使用Spring的@Async.md》]

（139）使用 @Async 前必须配置 **________** 注解，并建议自定义 **________** 配合使用。⭐⭐⭐ [来源：文件：文件《为什么不建议直接使用Spring的@Async.md》]

### 4. @Retryable 重试

（140）@Retryable 的核心参数：value（异常类型）、**________**（最大重试次数）、**________**（退避策略）。⭐⭐⭐ [来源：文件：文件《介绍下@Retryable的实现原理.md》]

（141）@Retryable 实现原理：基于 **________**，扫描 @Retryable 注解创建 **________**，内部使用 **________** 执行重试逻辑。⭐⭐⭐ [来源：文件：文件《介绍下@Retryable的实现原理.md》]

（142）@Retryable 的重试是 **________** 级别的，JVM 挂了重试任务会丢失。⭐⭐ [来源：文件：文件《介绍下@Retryable的实现原理.md》]

### 5. 缓存预热 & 方法调用统计

（143）Spring Boot 启动后做缓存预热的四种方式：监听 **________** 事件、实现 CommandLineRunner/ApplicationRunner、实现 **________** 接口、使用 **________** 注解。⭐⭐ [来源：文件：文件《如何在Spring启动过程中做缓存预热.md》]

（144）统计 Bean 方法调用次数可以通过 **________** 实现：自定义注解 + **________** 切面 + ConcurrentHashMap 计数。⭐⭐ [来源：文件：文件《如何统计一个Bean中的方法调用次数.md》]

### 6. 字段注入不推荐原因

（145）Spring 官方建议：强制依赖使用 **________** 注入，可选依赖使用 **________** 注入。⭐⭐⭐ [来源：文件：文件《为什么Spring不建议使用基于字段的依赖注入.md》]

（146）字段注入的四大问题：违反 **________** 职责原则、可能产生 **________**、隐藏依赖、**________** 测试。⭐⭐⭐ [来源：文件：文件《为什么Spring不建议使用基于字段的依赖注入.md》]

（147）在构造方法中使用 @Autowired 标注的字段会引起 NPE，因为字段注入发生在 **________** 之后。⭐⭐ [来源：文件：文件《为什么Spring不建议使用基于字段的依赖注入.md》]

---

*共 147 道填空，覆盖 Spring 核心 IOC、AOP、循环依赖、事务、Spring Boot、Spring MVC、设计模式、新特性、业务实践 10 个模块全部重要知识点。*
*答案见同目录 `Spring 预习填空题-答案版.md`。*
