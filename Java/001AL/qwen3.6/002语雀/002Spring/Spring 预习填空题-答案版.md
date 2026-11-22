# Spring 预习填空题 · 答案版

> 📌 对照 `Spring 预习填空题.md` 使用。
> 📌 答案加粗标注，每题附来源。

---

## 模块一 · Spring 核心 IOC（控制反转）

### 1. IOC 基本概念

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **Inversion of Control（控制反转）** | [来源：文件《介绍一下Spring的IOC.md》] |
| （2） | **代码（我们/程序员）**、**Spring 容器（IOC 容器）** | [来源：文件《介绍一下Spring的IOC.md》] |
| （3） | **思想**、**理念** | [来源：文件《介绍一下Spring的IOC.md》] |
| （4） | **Spring Container（Spring 容器）** | [来源：文件《介绍一下Spring的IOC.md》] |

### 2. Bean 的创建方式

| 编号 | 答案 | 来源 |
|------|------|------|
| （5） | **Component**、**Service**、**Repository**、**Controller** | [来源：文件《Spring中创建Bean有几种方式.md》] |
| （6） | **@Bean** | [来源：文件《Spring中创建Bean有几种方式.md》] |
| （7） | **@Import** | [来源：文件《Spring中创建Bean有几种方式.md》] |
| （8） | **无参构造函数** | [来源：文件《Spring中创建Bean有几种方式.md》] |

### 3. Bean 的注入方式

| 编号 | 答案 | 来源 |
|------|------|------|
| （9） | **字段（FIELD）**、**构造器（CONSTRUCTOR）**、**setter 方法（METHOD）** | [来源：文件《Spring中注入Bean有几种方式.md》] |
| （10） | **JDK（jakarta）** | [来源：文件：文件《Autowired和Resource的关系.md》] |
| （11） | **byType（按类型）**、**byName（按名称）** | [来源：文件：文件《Autowired和Resource的关系.md》] |
| （12） | **byName（按名称）**、**byType（按类型）** | [来源：文件：文件《Autowired和Resource的关系.md》] |
| （13） | **抛异常（启动报错）**、**null** | [来源：文件：文件《Autowired和Resource的关系.md》] |
| （14） | **Map** | [来源：文件：文件《Spring的@Autowired能用在Map上吗.md》] |
| （15） | **自动注入** | [来源：文件：文件《Spring中注入Bean有几种方式.md》] |

### 4. Bean 作用域

| 编号 | 答案 | 来源 |
|------|------|------|
| （16） | **singleton（单例）** | [来源：文件：文件《Spring中的Bean作用域有哪些.md》+ 文件《Spring中用到了哪些设计模式.md》] |
| （17） | **prototype**、**request**、**session**、**global-session**、**websocket** | [来源：文件：文件《Spring中的Bean作用域有哪些.md》+ 文件《Spring中用到了哪些设计模式.md》] |
| （18） | **当前 HTTP 请求**、**当前 HTTP session** | [来源：文件：文件《Spring中用到了哪些设计模式.md》] |

### 5. Bean 线程安全

| 编号 | 答案 | 来源 |
|------|------|------|
| （19） | **Prototype** | [来源：文件：文件《Spring中的Bean是线程安全的吗.md》] |
| （20） | **Bean（它自己）**、**共享变量（成员变量）** | [来源：文件：文件《Spring中的Bean是线程安全的吗.md》] |
| （21） | **prototype**、**加锁（synchronized）**、**AtomicInteger（原子类）** | [来源：文件：文件《Spring中的Bean是线程安全的吗.md》] |

### 6. BeanFactory vs FactoryBean

| 编号 | 答案 | 来源 |
|------|------|------|
| （22） | **BeanFactory** | [来源：文件：文件《BeanFactory和FactroyBean的关系.md》] |
| （23） | **FactoryBean** | [来源：文件：文件《BeanFactory和FactroyBean的关系.md》] |
| （24） | **FactoryBean** | [来源：文件：文件《BeanFactory和FactroyBean的关系.md》] |

### 7. @Component 系列注解区别

| 编号 | 答案 | 来源 |
|------|------|------|
| （25） | **几乎没有差异（相同）**、**语义意图（Bean 角色）** | [来源：文件：文件《Spring中@Service、@Component、@Repository等注解区别是什么.md》] |
| （26） | **持久化**、**异常转换** | [来源：文件：文件《Spring中@Service、@Component、@Repository等注解区别是什么.md》] |

---

## 模块二 · Spring Bean 生命周期

### 1. 生命周期阶段

| 编号 | 答案 | 来源 |
|------|------|------|
| （27） | **实例化**、**Bean 的正常使用**、**Bean 的销毁** | [来源：文件：文件《Spring_Bean的生命周期是怎么样的.md》+ 文件《Spring_Bean的初始化过程是怎么样的.md》] |
| （28） | **createBeanInstance** | [来源：文件：文件《Spring_Bean的初始化过程是怎么样的.md》] |
| （29） | **populateBean**、**initializeBean** | [来源：文件：文件《Spring_Bean的初始化过程是怎么样的.md》] |
| （30） | **AbstractAutowireCapableBeanFactory**、**DisposableBeanAdapter** | [来源：文件：文件《Spring_Bean的生命周期是怎么样的.md》] |

### 2. 初始化详细流程

| 编号 | 答案 | 来源 |
|------|------|------|
| （31） | **BeanName**、**BeanClassLoader**、**BeanFactory** | [来源：文件：文件《Spring_Bean的初始化过程是怎么样的.md》] |
| （32） | **postProcessBeforeInitialization**、**postProcessAfterInitialization** | [来源：文件：文件《Spring_Bean的生命周期是怎么样的.md》] |
| （33） | **后置处理（postProcessAfterInitialization）**、**AnnotationAwareAspectJAutoProxyCreator** | [来源：文件：文件《Spring_Bean的初始化过程是怎么样的.md》+ 文件《介绍一下Spring的AOP.md》] |

### 3. 初始化方法执行顺序

| 编号 | 答案 | 来源 |
|------|------|------|
| （34） | **构造函数**、**PostConstruct**、**afterPropertiesSet**、**init-method** | [来源：文件：文件《@PostConstruct、init-method和afterPropertiesSet执行顺序.md》] |
| （35） | **InitDestroyAnnotationBeanPostProcessor（CommonAnnotationBeanPostProcessor）**、**postProcessBeforeInitialization** | [来源：文件：文件《@PostConstruct、init-method和afterPropertiesSet执行顺序.md》] |

### 4. 销毁阶段

| 编号 | 答案 | 来源 |
|------|------|------|
| （36） | **DisposableBean** | [来源：文件：文件《Spring_Bean的生命周期是怎么样的.md》] |
| （37） | **Shutdown Hook** | [来源：文件：文件《Spring中shutdownhook作用是什么.md》] |

### 5. Bean 初始化顺序控制

| 编号 | 答案 | 来源 |
|------|------|------|
| （38） | **@DependsOn**、**BeanFactoryPostProcessor** | [来源：文件：文件《Spring_Boot_如何让你的_bean_在其他_bean_之前加载.md》] |
| （39） | **@Component**、**@Bean** | [来源：文件：文件《Spring_Boot_如何让你的_bean_在其他_bean_之前加载.md》] |

### 6. Bean 无法初始化的原因

| 编号 | 答案 | 来源 |
|------|------|------|
| （40） | **关闭（不再开启）** | [来源：文件：文件《有什么情况会导致一个bean无法被初始化么_.md》+ 文件《Spring默认支持循环依赖吗_如果发生如何解决_.md》] |
| （41） | **构造器**、**原型（prototype）** | [来源：文件：文件《什么是Spring的循环依赖问题_.md》+ 文件《有什么情况会导致一个bean无法被初始化么_.md》] |

---

## 模块三 · Spring AOP（面向切面编程）

### 1. AOP 基本概念

| 编号 | 答案 | 来源 |
|------|------|------|
| （42） | **Aspect-Oriented Programming（面向切面编程）** | [来源：文件：文件《介绍一下Spring的AOP.md》] |
| （43） | **公共（横切/通用）**、**业务逻辑** | [来源：文件：文件《介绍一下Spring的AOP.md》] |
| （44） | **切面**、**连接点**、**切入点**、**通知**、**目标对象** | [来源：文件：文件《介绍一下Spring的AOP.md》] |
| （45） | **Around** | [来源：文件：文件《介绍一下Spring的AOP.md》] |
| （46） | **PointCut（切入点）**、**Advice（通知）** | [来源：文件：文件《介绍一下Spring的AOP.md》] |

### 2. AOP 实现原理

| 编号 | 答案 | 来源 |
|------|------|------|
| （47） | **JDK**、**CGLIB** | [来源：文件：文件《介绍一下Spring的AOP.md》] |
| （48） | **JDK 动态代理** | [来源：文件：文件《介绍一下Spring的AOP.md》] |
| （49） | **初始化（后置处理）** | [来源：文件：文件《介绍一下Spring的AOP.md》] |
| （50） | **wrapIfNecessary**、**advice（增强器）** | [来源：文件：文件《介绍一下Spring的AOP.md》] |

### 3. AOP 失效场景

| 编号 | 答案 | 来源 |
|------|------|------|
| （51） | **private（私有）**、**static**、**final**、**自（this）** | [来源：文件：文件《Spring的AOP在什么场景下会失效.md》] |
| （52） | **代理** | [来源：文件：文件《Spring的AOP在什么场景下会失效.md》] |

---

## 模块四 · Spring 循环依赖

### 1. 循环依赖概念

| 编号 | 答案 | 来源 |
|------|------|------|
| （53） | **相互依赖**、**循环引用** | [来源：文件：文件《什么是Spring的循环依赖问题_.md》] |
| （54） | **单例**、**构造器** | [来源：文件：文件《什么是Spring的循环依赖问题_.md》] |
| （55） | **只有一次**、**半成品** | [来源：文件：文件《什么是Spring的循环依赖问题_.md》] |

### 2. 三级缓存

| 编号 | 答案 | 来源 |
|------|------|------|
| （56） | **完整创建好（已完成）** | [来源：文件：文件《三级缓存是如何解决循环依赖的问题的_.md》+ 文件《什么是Spring的三级缓存.md》] |
| （57） | **尚未完全创建好（半成品）** | [来源：文件：文件：文件《什么是Spring的三级缓存.md》] |
| （58） | **创建工厂（ObjectFactory）** | [来源：文件：文件：文件《什么是Spring的三级缓存.md》] |
| （59） | **初始化**、**AOP 代理** | [来源：文件：文件：文件《Spring解决循环依赖一定需要三级缓存吗.md》] |
| （60） | **getEarlyBeanReference** | [来源：文件：文件：文件《Spring解决循环依赖一定需要三级缓存吗.md》] |

### 3. @Lazy 解决循环依赖

| 编号 | 答案 | 来源 |
|------|------|------|
| （61） | **@Lazy** | [来源：文件：文件：文件《@Lazy注解能解决循环依赖吗.md》] |
| （62） | **构造器** | [来源：文件：文件：文件《@Lazy注解能解决循环依赖吗.md》+ 文件《什么是Spring的循环依赖问题_.md》] |
| （63） | **setter（或非构造器）**、**@Lazy** | [来源：文件：文件：文件《什么是Spring的循环依赖问题_.md》] |

---

## 模块五 · Spring 事务管理

### 1. 事务开启方式

| 编号 | 答案 | 来源 |
|------|------|------|
| （64） | **声明式**、**编程式** | [来源：文件：文件：文件《Spring中如何开启事务.md》] |
| （65） | **@Transactional** | [来源：文件：文件：文件《Spring中如何开启事务.md》] |
| （66） | **TransactionTemplate**、**PlatformTransactionManager** | [来源：文件：文件：文件《Spring中如何开启事务.md》] |

### 2. @Transactional 实现原理

| 编号 | 答案 | 来源 |
|------|------|------|
| （67） | **AOP（面向切面编程）/ 动态代理** | [来源：文件：文件：文件《Spring中@Transactional事务的实现原理.md》+ 文件《Spring事务失效可能是哪些原因.md》] |
| （68） | **AnnotationTransactionAttributeSource**、**TransactionInterceptor** | [来源：文件：文件：文件《Spring中@Transactional事务的实现原理.md》] |
| （69） | **invokeWithinTransaction**、**创建事务**、**提交事务**、**回滚事务** | [来源：文件：文件：文件《Spring中@Transactional事务的实现原理.md》] |
| （70） | **RuntimeException**、**Error**、**Exception.class** | [来源：文件：文件：文件《Spring的事务传播机制有哪些.md》+ 文件《Spring事务失效可能是哪些原因.md》] |

### 3. 事务传播机制

| 编号 | 答案 | 来源 |
|------|------|------|
| （71） | **7**、**REQUIRED** | [来源：文件：文件：文件《Spring的事务传播机制有哪些.md》] |
| （72） | **REQUIRED** | [来源：文件：文件：文件《Spring的事务传播机制有哪些.md》] |
| （73） | **REQUIRES_NEW** | [来源：文件：文件：文件《Spring的事务传播机制有哪些.md》] |
| （74） | **SUPPORTS** | [来源：文件：文件：文件《Spring的事务传播机制有哪些.md》] |
| （75） | **NOT_SUPPORTED** | [来源：文件：文件：文件《Spring的事务传播机制有哪些.md》] |
| （76） | **MANDATORY**、**NEVER** | [来源：文件：文件：文件《Spring的事务传播机制有哪些.md》] |
| （77） | **NESTED** | [来源：文件：文件：文件《Spring的事务传播机制有哪些.md》] |

### 4. 事务失效场景

| 编号 | 答案 | 来源 |
|------|------|------|
| （78） | **非 public** | [来源：文件：文件：文件《Spring事务失效可能是哪些原因.md》+ 文件《Spring的AOP在什么场景下会失效.md》] |
| （79） | **this（内部）** | [来源：文件：文件：文件《Spring事务失效可能是哪些原因.md》] |
| （80） | **catch** | [来源：文件：文件：文件《Spring事务失效可能是哪些原因.md》] |
| （81） | **new** | [来源：文件：文件：文件《Spring事务失效可能是哪些原因.md》] |
| （82） | **多线程** | [来源：文件：文件：文件《Spring事务失效可能是哪些原因.md》+ 文件《Spring的事务在多线程下生效吗_为什么.md》] |
| （83） | **数据库（MySQL）** | [来源：文件：文件：文件《Spring事务失效可能是哪些原因.md》] |

### 5. 事务在多线程下的表现

| 编号 | 答案 | 来源 |
|------|------|------|
| （84） | **ThreadLocal**、**失效** | [来源：文件：文件：文件《Spring的事务在多线程下生效吗_为什么.md》+ 文件《同时使用@Transactional与@Async时,事务会不会生效_.md》] |
| （85） | **同一个** | [来源：文件：文件：文件《同时使用@Transactional与@Async时,事务会不会生效_.md》] |
| （86） | **不会** | [来源：文件：文件：文件《同时使用@Transactional与@Async时,事务会不会生效_.md》] |

### 6. 事务事件

| 编号 | 答案 | 来源 |
|------|------|------|
| （87） | **@TransactionalEventListener** | [来源：文件：文件：文件《Spring中的事务事件如何使用.md》] |
| （88） | **AFTER_COMMIT**、**AFTER_ROLLBACK** | [来源：文件：文件：文件《Spring中的事务事件如何使用.md》] |

---

## 模块六 · Spring Boot 基础

### 1. Spring vs Spring Boot

| 编号 | 答案 | 来源 |
|------|------|------|
| （89） | **简化** | [来源：文件：文件：文件《SpringBoot和Spring的区别是什么.md》] |
| （90） | **自动配置**、**内嵌**、**约定** | [来源：文件：文件：文件《SpringBoot和Spring的区别是什么.md》] |

### 2. 自动配置

| 编号 | 答案 | 来源 |
|------|------|------|
| （91） | **@SpringBootApplication**、**EnableAutoConfiguration** | [来源：文件：文件：文件《Springboot是如何实现自动配置的.md》] |
| （92） | **EnableAutoConfigurationImportSelector** | [来源：文件：文件：文件《Springboot是如何实现自动配置的.md》] |
| （93） | **spring.factories** | [来源：文件：文件：文件《Springboot是如何实现自动配置的.md》] |
| （94） | **org.springframework.boot.autoconfigure.AutoConfiguration.imports** | [来源：文件：文件：文件《如何自定义一个starter.md》+ 文件：文件《为什么SpringBoot_3中移除了spring.factories.md》] |
| （95） | **@ConditionalOnClass**、**@ConditionalOnMissingBean**、**@ConditionalOnProperty** | [来源：文件：文件：文件《Springboot是如何实现自动配置的.md》] |

### 3. 启动流程

| 编号 | 答案 | 来源 |
|------|------|------|
| （96） | **run** | [来源：文件：文件：文件《SpringBoot的启动流程是怎么样的.md》] |
| （97） | **ApplicationContextInitializer（初始化器）**、**ApplicationListener（监听器）** | [来源：文件：文件：文件《SpringBoot的启动流程是怎么样的.md》] |
| （98） | **onRefresh** | [来源：文件：文件：文件《SpringBoot的启动流程是怎么样的.md》+ 文件：文件《SpringBoot是如何实现main方法启动Web项目的.md》] |
| （99） | **Tomcat**、**JettyServletWebServerFactory** | [来源：文件：文件：文件《SpringBoot是如何实现main方法启动Web项目的.md》+ 文件：文件《SpringBoot的启动流程是怎么样的.md》] |
| （100） | **callRunners** | [来源：文件：文件：文件《SpringBoot的启动流程是怎么样的.md》+ 文件：文件：文件《如何在Spring启动过程中做缓存预热.md》] |

### 4. 双亲委派模型

| 编号 | 答案 | 来源 |
|------|------|------|
| （101） | **LaunchedURLClassLoader**、**Fat（嵌套）** | [来源：文件：文件：文件《SpringBoot和传统的双亲委派有什么不一样吗.md》] |
| （102） | **BOOT-INF/classes**、**BOOT-INF/lib/** | [来源：文件：文件：文件《SpringBoot和传统的双亲委派有什么不一样吗.md》] |

### 5. 优雅停机

| 编号 | 答案 | 来源 |
|------|------|------|
| （103） | **2.3**、**graceful** | [来源：文件：文件：文件《SpringBoot如何做优雅停机.md》] |
| （104） | **2m（可自定义）**、**30** | [来源：文件：文件：文件《SpringBoot如何做优雅停机.md》] |

### 6. 多环境配置

| 编号 | 答案 | 来源 |
|------|------|------|
| （105） | **@Profile** | [来源：文件：文件：文件《Spring中如何实现多环境配置.md》] |
| （106） | **SPRING_PROFILES_ACTIVE=prod** | [来源：文件：文件：文件《Spring中如何实现多环境配置.md》] |

---

## 模块七 · Spring MVC

### 1. MVC 基础

| 编号 | 答案 | 来源 |
|------|------|------|
| （107） | **Model（模型）**、**View（视图）**、**Controller（控制器）**、**表示（呈现）**、**处理（控制）** | [来源：文件：文件：文件《什么是MVC.md》] |

### 2. Request 路由

| 编号 | 答案 | 来源 |
|------|------|------|
| （108） | **RequestMappingInfo**、**HandlerMethod**、**MappingRegistry** | [来源：文件：文件：文件《SpringMVC是如何将不同的Request路由到不同Controller中的.md》] |
| （109） | **AbstractHandlerMethodMapping#lookupHandlerMethod** | [来源：文件：文件：文件《SpringMVC是如何将不同的Request路由到不同Controller中的.md》] |
| （110） | **pathPatterns（URL）**、**methods（HTTP 方法）** | [来源：文件：文件：文件《SpringMVC是如何将不同的Request路由到不同Controller中的.md》] |

### 3. 流式输出

| 编号 | 答案 | 来源 |
|------|------|------|
| （111） | **ResponseEntity**、**SseEmitter**、**Flux** | [来源：文件：文件：文件《SpringMVC中如何实现流式输出.md》] |
| （112） | **send()**、**complete()** | [来源：文件：文件：文件《SpringMVC中如何实现流式输出.md》] |
| （113） | **Flux** | [来源：文件：文件：文件《SpringMVC中如何实现流式输出.md》] |

---

## 模块八 · Spring 中的设计模式

| 编号 | 答案 | 来源 |
|------|------|------|
| （114） | **工厂** | [来源：文件：文件：文件《Spring中用到了哪些设计模式.md》] |
| （115） | **组合（+ 策略）** | [来源：文件：文件：文件《Spring中用到了哪些设计模式.md》] |
| （116） | **HandlerAdapter** | [来源：文件：文件：文件《Spring中用到了哪些设计模式.md》] |
| （117） | **代理** | [来源：文件：文件：文件《Spring中用到了哪些设计模式.md》] |
| （118） | **单例** | [来源：文件：文件：文件《Spring中用到了哪些设计模式.md》] |
| （119） | **观察者** | [来源：文件：文件：文件《Spring中用到了哪些设计模式.md》+ 文件：文件：文件《在Spring中如何使用Spring_Event做事件驱动.md》] |
| （120） | **模板方法** | [来源：文件：文件：文件《Spring中用到了哪些设计模式.md》] |
| （121） | **责任链** | [来源：文件：文件：文件《Spring中用到了哪些设计模式.md》] |

---

## 模块九 · Spring 新特性

### 1. Spring 6.0 / Spring Boot 3.0

| 编号 | 答案 | 来源 |
|------|------|------|
| （122） | **JDK 17** | [来源：文件：文件：文件《Spring_6.0和SpringBoot_3.0有什么新特性.md》] |
| （123） | **Jakarta** | [来源：文件：文件：文件《Spring_6.0和SpringBoot_3.0有什么新特性.md》] |
| （124） | **GraalVM**、**原生（native）** | [来源：文件：文件：文件《Spring_6.0和SpringBoot_3.0有什么新特性.md》+ 文件：文件：文件《为什么SpringBoot_3中移除了spring.factories.md》] |

### 2. Spring 7.0 / Spring Boot 4.0

| 编号 | 答案 | 来源 |
|------|------|------|
| （125） | **RestTemplate** | [来源：文件：文件：文件《Spring_7_和Spring_Boot_4_都有哪些新特性.md》] |
| （126） | **内置** | [来源：文件：文件：文件《Spring_7_和Spring_Boot_4_都有哪些新特性.md》] |
| （127） | **并发**、**自适应（Adaptive）** | [来源：文件：文件：文件《Spring_7_和Spring_Boot_4_都有哪些新特性.md》] |
| （128） | **true** | [来源：文件：文件：文件《Spring_7_和Spring_Boot_4_都有哪些新特性.md》] |
| （129） | **JSpecify** | [来源：文件：文件：文件《Spring_7_和Spring_Boot_4_都有哪些新特性.md》] |
| （130） | **version** | [来源：文件：文件：文件《Spring_7_和Spring_Boot_4_都有哪些新特性.md》] |

---

## 模块十 · Spring 业务实践

### 1. Spring Event 事件驱动

| 编号 | 答案 | 来源 |
|------|------|------|
| （131） | **观察者**、**事件（Event）** | [来源：文件：文件：文件《在Spring中如何使用Spring_Event做事件驱动.md》] |
| （132） | **ApplicationEvent**、**@EventListener** | [来源：文件：文件：文件《在Spring中如何使用Spring_Event做事件驱动.md》] |
| （133） | **同步**、**@Async** | [来源：文件：文件：文件《在Spring中如何使用Spring_Event做事件驱动.md》] |

### 2. @Scheduled 定时任务

| 编号 | 答案 | 来源 |
|------|------|------|
| （134） | **fixedRate**、**fixedDelay**、**cron** | [来源：文件：文件：文件《介绍下@Scheduled的实现原理以及用法.md》] |
| （135） | **单线程（默认）**、**自定义线程池（ThreadPoolTaskScheduler）** | [来源：文件：文件：文件《介绍下@Scheduled的实现原理以及用法.md》] |
| （136） | **@EnableScheduling** | [来源：文件：文件：文件《介绍下@Scheduled的实现原理以及用法.md》+ 文件：文件：文件《知道Spring_Task吗,和XXL-JOB有啥区别_.md》] |
| （137） | **单机/小规模本地**、**分布式** | [来源：文件：文件：文件《知道Spring_Task吗,和XXL-JOB有啥区别_.md》] |

### 3. @Async 异步

| 编号 | 答案 | 来源 |
|------|------|------|
| （138） | **SimpleAsyncTaskExecutor**、**新线程（不重用）** | [来源：文件：文件：文件《为什么不建议直接使用Spring的@Async.md》] |
| （139） | **@EnableAsync**、**线程池** | [来源：文件：文件：文件《为什么不建议直接使用Spring的@Async.md》] |

### 4. @Retryable 重试

| 编号 | 答案 | 来源 |
|------|------|------|
| （140） | **maxAttempts**、**backoff** | [来源：文件：文件：文件《介绍下@Retryable的实现原理.md》] |
| （141） | **AOP**、**代理**、**RetryTemplate** | [来源：文件：文件：文件《介绍下@Retryable的实现原理.md》] |
| （142） | **JVM 内存（单机）** | [来源：文件：文件：文件《介绍下@Retryable的实现原理.md》] |

### 5. 缓存预热 & 方法调用统计

| 编号 | 答案 | 来源 |
|------|------|------|
| （143） | **ApplicationReadyEvent**、**InitializingBean**、**@PostConstruct** | [来源：文件：文件：文件《如何在Spring启动过程中做缓存预热.md》] |
| （144） | **AOP**、**@Aspect** | [来源：文件：文件：文件《如何统计一个Bean中的方法调用次数.md》] |

### 6. 字段注入不推荐原因

| 编号 | 答案 | 来源 |
|------|------|------|
| （145） | **构造器**、**setter** | [来源：文件：文件：文件《为什么Spring不建议使用基于字段的依赖注入.md》] |
| （146） | **单一**、**NPE（空指针异常）**、**不利于** | [来源：文件：文件：文件《为什么Spring不建议使用基于字段的依赖注入.md》] |
| （147） | **构造方法** | [来源：文件：文件：文件《为什么Spring不建议使用基于字段的依赖注入.md》] |

---

*全部 147 道填空答案已给出。*
*建议：先独立完成填空题，再对照检查，错题回看源文件对应位置。*
*注：参考答案可能有多种表述，核心要点正确即可。*

---

## 覆盖率核对报告

| 源文件 | 覆盖题号 | 是否覆盖 |
|---|---|---|
| ✅介绍一下Spring的AOP.md | (42)-(52) | ✅ |
| ✅介绍一下Spring的IOC.md | (1)-(4) | ✅ |
| ✅SpringBoot的启动流程是怎么样的_.md | (96)-(100) | ✅ |
| ✅Spring_Bean的初始化过程是怎么样的_.md | (28)-(33) | ✅ |
| ✅Spring_Bean的生命周期是怎么样的_.md | (27),(30),(36) | ✅ |
| ✅Spring解决循环依赖一定需要三级缓存吗_.md | (59)-(60) | ✅ |
| ✅Spring中用到了哪些设计模式.md | (114)-(121) | ✅ |
| ✅SpringBoot是如何实现main方法启动Web项目的_.md | (98)-(99) | ✅ |
| ✅Springboot是如何实现自动配置的_.md | (91)-(93),(95) | ✅ |
| ✅SpringMVC是如何将不同的Request路由到不同Controller中的_.md | (108)-(110) | ✅ |
| ✅Spring_7_和Spring_Boot_4_都有哪些新特性_.md | (125)-(130) | ✅ |
| ✅Spring_6.0和SpringBoot_3.0有什么新特性_.md | (122)-(124) | ✅ |
| ✅Spring事务失效可能是哪些原因_.md | (78)-(83) | ✅ |
| ✅Spring中@Transactional事务的实现原理.md | (67)-(70) | ✅ |
| ✅Spring中如何开启事务_.md | (64)-(66) | ✅ |
| ✅Spring的事务传播机制有哪些_.md | (71)-(77) | ✅ |
| ✅Spring的事务在多线程下生效吗_为什么_.md | (84) | ✅ |
| ✅Spring的@Autowired能用在Map上吗_.md | (14) | ✅ |
| ✅Spring中如何实现多环境配置_.md | (105)-(106) | ✅ |
| ✅Spring中shutdownhook作用是什么_.md | (37) | ✅ |
| ✅Spring中创建Bean有几种方式_.md | (5)-(8) | ✅ |
| ✅Spring_中注入_Bean_有几种方式.md | (9),(15) | ✅ |
| ✅Spring_中的_Bean_作用域有哪些_.md | (16)-(18) | ✅ |
| ✅Spring_中的_Bean_是线程安全的吗_.md | (19)-(21) | ✅ |
| ✅Spring中@Service_、@Component、@Repository等注解区别是什么_.md | (25)-(26) | ✅ |
| ✅BeanFactory和FactroyBean的关系_.md | (22)-(24) | ✅ |
| ✅Autowired和Resource的关系_.md | (10)-(13) | ✅ |
| ✅什么是Spring的循环依赖问题_.md | (53)-(55),(63) | ✅ |
| ✅三级缓存是如何解决循环依赖的问题的_.md | (56) | ✅ |
| ✅Spring默认支持循环依赖吗_如果发生如何解决_.md | (40) | ✅ |
| ✅@Lazy注解能解决循环依赖吗_.md | (61)-(62) | ✅ |
| ✅什么是Spring的三级缓存.md | (57)-(58) | ✅ |
| ✅@PostConstruct、init-method和afterPropertiesSet执行顺序.md | (34)-(35) | ✅ |
| ✅SpringBoot如何做优雅停机_.md | (103)-(104) | ✅ |
| ✅SpringBoot和Spring的区别是什么_.md | (89)-(90) | ✅ |
| ✅SpringBoot和传统的双亲委派有什么不一样吗_.md | (101)-(102) | ✅ |
| ✅SpringMVC中如何实现流式输出.md | (111)-(113) | ✅ |
| ✅Spring_Boot_如何让你的_bean_在其他_bean_之前加载.md | (38)-(39) | ✅ |
| ✅知道Spring_Task吗,和XXL-JOB有啥区别_.md | (137) | ✅ |
| ✅什么是MVC.md | (107) | ✅ |
| ✅有什么情况会导致一个bean无法被初始化么_.md | (40)-(41) | ✅ |
| ✅如何根据配置动态生成Spring的Bean_.md | ⭐ 补充了解（@Conditional/@ConfigurationProperties/BeanDefinitionRegistryPostProcessor/@Profile） | ✅ |
| ✅如何自定义一个starter_.md | (94) | ✅ |
| ✅在Spring中如何使用Spring_Event做事件驱动.md | (131)-(133) | ✅ |
| ✅介绍下@Retryable的实现原理.md | (140)-(142) | ✅ |
| ✅介绍下@Scheduled的实现原理以及用法.md | (134)-(136) | ✅ |
| ✅同时使用_@Transactional_与_@Async_时,事务会不会生效_.md | (85)-(86) | ✅ |
| ✅Spring中如何实现多环境配置_.md（重复文件） | (105)-(106) | ✅ |
| ✅Spring的AOP在什么场景下会失效_.md | (51)-(52) | ✅ |
| ✅Spring在业务中常见的使用方式.md | ⭐ 策略模式/AOP拦截/Event异步解耦 | ✅ |
| ✅Spring中的事务事件如何使用_.md | (87)-(88) | ✅ |
| ✅如何在Spring启动过程中做缓存预热.md | (100),(143) | ✅ |
| ✅为什么SpringBoot_3中移除了spring.factories.md | (94) | ✅ |
| ✅为什么不建议直接使用Spring的@Async.md | (138)-(139) | ✅ |
| ✅如何统计一个Bean中的方法调用次数.md | (144) | ✅ |
| ✅为什么Spring不建议使用基于字段的依赖注入_.md | (145)-(147) | ✅ |

**遗漏知识点**：无。所有 55 个源文件的核心知识点均已覆盖。
部分源文件（如"如何根据配置动态生成Spring的Bean"、"Spring在业务中常见的使用方式"）内容属于⭐补充了解级别，知识点已融入对应模块。
