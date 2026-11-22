# 011OB · SpringCloud 模块 · 预习填空题

> 📂 **源资料**
> - **所在路径**：`D:\Works\Interview\004-ObsidianCanvas\ObsidianP\Java\001AL\001文本资料\ALLInOne\011SpringCloud`
> - **源文件**：27 个问答 md（Eureka、Feign、Hystrix、Ribbon/LoadBalancer、Gateway 等组件细节）+ 配图
> - **参考模块**：SpringCloud（概述与通信、Eureka 注册中心、Feign 与 OpenFeign、Hystrix 与 Sentinel、负载均衡与网关）
> - 📅 生成日期：2026-11-20

> 📌 来源为 md 文本资料库。每题来源标注 `[来源：资料 主题]`，对应具体问答 md。
> 📌 每题后标注 ⭐ 重要程度 + 来源。填空 → 对答案 → 面试能讲出来。

---

## 模块一 · SpringCloud 概述与通信

（1）SpringCloud 是一套**微服务**解决方案，核心组件：注册中心（Eureka/Nacos）、**________**（配置中心）、网关（Gateway）、负载均衡（LoadBalancer）、熔断（Sentinel）。⭐⭐ [来源：资料 SpringCloud `配置中心`]

（2）SpringCloud 与 Dubbo 区别：SpringCloud 是**________**（完整微服务生态，HTTP/REST）；Dubbo 是高性能 RPC 框架，聚焦服务调用。⭐⭐ [来源：资料 SpringCloud和Dubbo `完整生态`]

（3）服务间通信方式：**________**（REST，Feign/RestTemplate）、RPC（Dubbo/gRPC）、消息队列（异步）。⭐⭐ [来源：资料 服务间通信 `REST`]

（4）application.yml 和 bootstrap.yml 区别：bootstrap.yml **________**（先加载，优先级更高），用于配置中心地址等引导配置；application.yml 后加载。⭐⭐ [来源：资料 bootstrap `先加载`]

（5）SpringCloud 在 Spring Boot 3.x 的变化：**________**（Netflix 组件如 Eureka/Hystrix/Ribbon 移除），改用 Nacos/Sentinel/LoadBalancer。⭐⭐ [来源：资料 Spring6.0 `Netflix`]

（6）Eureka 在 Boot 3.x 被移除后的替代：**________**（Nacos）做注册中心。⭐⭐ [来源：资料 Eureka移除 `Nacos`]

---

## 模块二 · Eureka 注册中心

（1）Eureka 与 Zookeeper 区别：Eureka 遵循 **________**（AP，可用性优先）；ZK 遵循 CP（强一致）。⭐⭐ [来源：资料 Eureka和Zookeeper `AP`]

（2）Eureka 自我保护模式：短时间内大量实例**________**（心跳丢失）时，不立即剔除实例，防止误删。⭐⭐ [来源：资料 Eureka自我保护 `心跳丢失`]

（3）Eureka 的缓存机制：**________**（多级缓存，ReadOnly 缓存 + ReadWrite 缓存），注册信息有短暂延迟。⭐⭐ [来源：资料 Eureka缓存 `多级缓存`]

（4）Eureka 高可用：**________**（集群部署，互相注册）。⭐⭐ [来源：资料 Eureka `集群`]

---

## 模块三 · Feign 与 OpenFeign

（1）Feign 与 RestTemplate 区别：Feign 是**声明式**（接口 + 注解，简洁）；RestTemplate 需手动**________**（拼 URL）。⭐⭐ [来源：资料 Feign和RestTemplate `拼 URL`]

（2）Feign 与 OpenFeign：Feign 是**________**（早期组件）；OpenFeign 是 SpringCloud 集成版（支持 SpringMVC 注解）。⭐⭐ [来源：资料 Feign和OpenFeign `早期`]

（3）OpenFeign 与 Dubbo 区别：OpenFeign 基于 **________**（HTTP）；Dubbo 基于自定义 RPC 协议（更快）。⭐⭐ [来源：资料 Dubbo和Feign `HTTP`]

（4）Feign 第一次调用慢的原因：**________**（懒加载，首次才创建代理、初始化连接池、JIT 编译）。⭐⭐ [来源：资料 Feign第一次调用 `懒加载`]

（5）Feign 调用超时配置：设置 **________**（连接超时 connectTimeout 和读取超时 readTimeout）。⭐⭐ [来源：资料 Feign超时 `超时时间`]

（6）Feign 默认**________**（不自动重试），需配置 Retryer 或结合 Ribbon 重试。⭐⭐ [来源：资料 Feign超时 `不自动重试`]

（7）OpenFeign 实现负载均衡：集成 **________**（LoadBalancer/Ribbon），通过服务名调用时自动负载均衡。⭐⭐ [来源：资料 OpenFeign负载均衡 `LoadBalancer`]

（8）OpenFeign 处理异常：**________**（ErrorDecoder）自定义异常解码；记录日志用 Logger（需开启 FULL 级别）。⭐⭐ [来源：资料 OpenFeign异常 `ErrorDecoder`]

---

## 模块四 · Hystrix 与 Sentinel

（1）Hystrix 熔断器原理：失败率达到阈值 → 打开熔断 → **________**（快速失败）→ 半开试探 → 恢复。⭐⭐ [来源：资料 Hystrix熔断器 `快速失败`]

（2）Hystrix 隔离策略：**________**（线程池隔离）和信号量隔离，常用线程池隔离。⭐⭐ [来源：资料 Hystrix隔离 `线程池`]

（3）Hystrix 与 Sentinel 区别：Sentinel 支持**________**（更丰富的规则：限流/熔断/降级/热点/系统规则）、实时监控更好。⭐⭐ [来源：资料 Hystrix和Sentinel `更丰富`]

（4）Hystrix 已**________**（停止维护，进入维护模式），新项目推荐 Sentinel。⭐⭐ [来源：资料 Hystrix和Sentinel `停止维护`]

---

## 模块五 · 负载均衡与网关

（1）Ribbon 与 Nginx 区别：Ribbon 是**________**（客户端）负载均衡；Nginx 是服务端。⭐⭐ [来源：资料 Ribbon和Nginx `客户端`]

（2）Ribbon 负载均衡原理：从注册中心拉取**________**，本地按算法（轮询/随机）选择。⭐⭐ [来源：资料 Ribbon `服务列表`]

（3）LoadBalancer 替代 Ribbon：Ribbon **________**（停止维护）；LoadBalancer 是官方组件，支持轮询/随机。⭐⭐ [来源：资料 LoadBalancer和Ribbon `停止维护`]

（4）LoadBalancer 修改策略：配置 **________**（自定义 IRule/ReactiveLoadBalancer Bean）。⭐⭐ [来源：资料 LoadBalancer策略 `Bean`]

（5）Zuul、Gateway、Nginx 区别：Nginx 是**________**（独立网关/反向代理）；Zuul 是阻塞式（Servlet）；Gateway 是响应式（WebFlux）。⭐⭐ [来源：资料 ZuulGatewayNginx `独立`]

（6）为什么需要 Gateway：统一**________**（入口）、路由、鉴权、限流、灰度。⭐⭐ [来源：资料 Gateway `入口`]

（7）Gateway 与 Zuul 区别：Gateway 基于 **________**（WebFlux 响应式），性能优于阻塞式的 Zuul。⭐⭐ [来源：资料 Zuul `WebFlux`]

---

*共 29 题（29 个填空），覆盖 SpringCloud 模块全部重要知识点。*
*答案见同目录 `011OBSpringCloud预习填空题答案.md`。*