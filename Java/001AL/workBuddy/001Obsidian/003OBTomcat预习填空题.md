# 003OB · Tomcat 模块 · 预习填空题

> 📂 **源资料**
> - **所在路径**：`D:\Works\Interview\004-ObsidianCanvas\ObsidianP\Java`（项目内相对路径 `Java/`）
> - **源文件**：`多线程并发.canvas`
> - **参考模块**：画布顶层分组 `Tomcat`（含其下全部子分组、文本笔记、嵌入图片）
> - **生成日期**：2026-11-20　｜　**画布快照**：基于当日画布内容；画布改动后请对照 `00-源节点覆盖台账.md` 复核

> 📌 基于 `多线程并发.canvas` 画布 Tomcat 模块（含 12 条文本笔记、135 张嵌入图片）及外部知识整理。
>
> 📌 每题后标注：⭐ 重要程度 + 来源。目的是让你填空 → 对答案 → 面试能讲出来。
>
> 📌 使用方式：直接做填空 → 对照答案版 → 错题回画布看原笔记。

---

## 模块一 · Web 容器与 Tomcat 架构

### 1.1 Web 容器 vs Spring 容器

（1）Spring 容器是一个 IOC 容器，主要负责管理 Java 对象的 **________** 和依赖关系。⭐⭐⭐ [来源：画布 web服务器 `Spring 容器是一个 IOC 容器，主要负责管理 Java 对象的生命周期和依赖关系`]

（2）Web 容器（如 Tomcat、Jetty）是用来运行 Web 应用的容器，负责处理 **________**、管理 Servlet 的生命周期。⭐⭐⭐ [来源：画布 web服务器 `负责处理 HTTP 请求和响应，管理 Servlet 的生命周期`]

（3）实际项目中请求先到 Tomcat，Tomcat 把请求交给 **________**，后者再去 Spring 容器中查找对应的 Controller。⭐⭐⭐ [来源：画布 web服务器 `Tomcat 会负责接收 HTTP 请求，然后把请求交给 DispatcherServlet 处理，而 DispatcherServlet 又会去 Spring 容器中查找对应的 Controller`]

（4）Spring Boot 内置了 Tomcat，把 Web 容器和 Spring 容器整合在一起，因此只需运行一个 **________** 包即可。⭐⭐ [来源：画布 web服务器 `只需要运行一个 jar 包就可以了`]

### 1.2 Tomcat 的两大核心组件

（5）Tomcat 由两大核心组件构成：**________**（蓝色块，负责 HTTP）和 **________**（绿色块，负责 Servlet）。⭐⭐⭐ [来源：画布 web服务器 `Tomcat = HTTP服务器 + Servlet容器` + Tomcat 内部结构图]

（6）HTTP 服务器的职责：监听端口（默认 **________**）、接收浏览器发来的 TCP/HTTP 报文、解析 HTTP 请求、组装 HTTP 响应。⭐⭐⭐ [来源：画布 web服务器 `监听端口（8080），接收浏览器发过来的 TCP 的 HTTP 协议报文`]

（7）HTTP 服务器只处理 HTTP 协议，本身**不**处理 Java 业务代码，不知道什么是 Controller；这部分职责由 **________** 承担。⭐⭐⭐ [来源：画布 web服务器 `它只看传输 HTTP 协议，本身不会处理 Java 业务代码，不知道什么是 Controller`]

（8）Servlet 容器的职责：管理 Servlet 的 **________**（init、service、destroy）；HTTP 服务器解析完请求后交给它去找对应 Servlet 执行。⭐⭐⭐ [来源：画布 web服务器 `管理 Servlet 的生命周期（init、service、destroy）`]

（9）Servlet 是 JavaEE 的接口规范 `javax.servlet.Servlet`；SpringMVC 的 DispatcherServlet 本质是一个 Servlet，它继承了 **________**。⭐⭐⭐ [来源：画布 web服务器 `它继承了 HttpServlet`]

（10）Nginx、Apache 是纯 **________**（不含 Servlet 容器）；而 Tomcat 自带 HTTP 服务器模块。⭐⭐ [来源：画布 web服务器 `Nginx、Apache 就是纯 HTTP 服务器；而 Tomcat 自带了 HTTP 服务器模块`]

（11）Tomcat 负责底层 TCP 连接、监听端口，读懂浏览器发来的 HTTP 报文并包装成 HTTP 报文返回——这是 Tomcat 的 **________**（Connector，连接器）职责。⭐⭐ [来源：画布 Tomcat `负责底层 TCP 连接、监听端口，读懂浏览器发来的 HTTP 报文`]

（12）Tomcat 内部结构：网络端点与协议处理器之上，通过 **CoyoteAdapter** 把请求交给 Container 容器链（Engine → Host → Context → **________**）。⭐⭐ [来源：画布 散图 Tomcat 内部结构图 `CoyoteAdapter / Engine / Host / Context / Wrapper`]

（13）Spring Boot 修改内嵌 Tomcat 端口：application.yml 写 `server.port: 8081`，或 application.properties 写 **________**。⭐⭐ [来源：画布 Tomcat `或者 application.properties server.port=8081`]

（14）内嵌 Tomcat 配置了 `server.port=8081` 后就不再默认监听 8080，改为监听 **________** 端口。⭐⭐ [来源：画布 Tomcat `内嵌 Tomcat 就不再默认监听 8080，改为监听 8081 端口`]

### 1.3 Servlet 与请求处理链路

（15）早年 Java Web 要自己写 Servlet 类，重写 **________** / **________** 方法处理请求。⭐⭐ [来源：画布 Tomcat `自己写 Servlet 类，重写 doGet/doPost 处理请求`]

（16）现在 SpringBoot 的 @RestController 底层最终会被包装成 **________**，交给 Tomcat 的 Servlet 容器运行。⭐⭐ [来源：画布 Tomcat `最终会被包装成 Servlet 交给 Tomcat 的 Servlet 容器运行`]

（17）Tomcat 的 HTTP 服务器接收并解析报文后交给内部 **________**，后者再找到 DispatcherServlet。⭐⭐⭐ [来源：画布 web服务器 `交给内部 Servlet 容器` + `Servlet 容器找到 DispatcherServlet`]

（18）Tomcat 监听端口、解析 HTTP、分配工作线程后，调用 DispatcherServlet 的 **________** 方法。⭐⭐⭐ [来源：画布 DispatcherServlet `调用 DispatcherServlet 的 service 方法`]

（19）请求处理完成，DispatcherServlet 把结果写入 response 交还 Tomcat，Tomcat 工作线程归还 **________**。⭐⭐ [来源：画布 DispatcherServlet `Tomcat 工作线程归还 Tomcat 线程池`]

（20）完整链路：浏览器 HTTP 请求 → Tomcat（HTTP 服务器解析报文）→ Tomcat Servlet 容器 → **________** → 分发到 Controller 方法。⭐⭐⭐ [来源：画布 Tomcat `浏览器 HTTP 请求 → Tomcat → Tomcat Servlet 容器 → DispatcherServlet → Controller 方法`]

（21）Tomcat 默认采用 **________** 模式处理网络连接（Http11NioProtocol / NioEndpoint），用少量线程即可支撑大量连接，取代了早期一连接一线程的 BIO 阻塞模式。⭐⭐ [来源：画布 散图 Tomcat 内部结构图 `Http11NioProtocol / NioEndpoint`] [来源：外部 Tomcat BIO/NIO 连接模式]

（22）Tomcat 的 **________** 机制：启动时提前把连接建立好，之后一次 HTTP 请求不再产生新的网络报文，从而降低首次请求的延迟。⭐ [来源：画布 散图 `预热：Tomcat 提前把连接建立好（一次 HTTP 请求，不会产生新的网络报文）`]

---

## 模块二 · HTTP 协议基础

### 2.1 无状态与报文结构

（1）HTTP 协议是 **________** 的，服务端不会保存客户端的任何信息。⭐⭐⭐ [来源：画布 散图 `HTTP 协议中服务端不会保存客户端的任何信息`]

（2）HTTP 报文由四部分组成：请求行、**________**、空行、请求体。⭐⭐ [来源：画布 散图 请求报文结构图]

（3）请求行包含：请求方法、请求 URL、**________**。⭐⭐ [来源：画布 散图 请求报文结构图 `请求行`]

（4）HTTP/1.1 的长连接由请求头 `Connection: **________**` 支持。⭐⭐⭐ [来源：画布 散图 `由 HTTP/1.1 Connection: keep-alive 支持`]

### 2.2 GET 与 POST

（5）GET 参数拼接在 **________** 后面；POST 参数可以放在 URL，也可以放在请求体 body。⭐⭐⭐ [来源：画布 散图 `GET 参数拼接在 URL 后面，弊端不建议使用 body`]

（6）GET 受浏览器/服务器 URL 长度限制，不适合大量数据；POST 放在 body，支持大量数据，适合 **________**。⭐⭐ [来源：画布 散图 `POST 放在 body，支持大量数据，适合上传`]

（7）GET 是 **________** 的，一般用于查询；POST 非幂等，一般用于新增资源，多次提交会产生多条数据。⭐⭐⭐ [来源：画布 散图 `GET 幂等，用于查询`]

（8）GET 默认支持浏览器缓存；POST 默认 **________**。⭐⭐ [来源：画布 散图 `GET 默认支持浏览器缓存；POST 默认不缓存`]

（9）❌ GET 比 POST 更安全，POST 会加密？→ ✅ 错。GET、POST 本身都**不加密**，只有 **________** 下两者才都加密；GET 参数会留在 URL/日志/浏览历史中更易泄漏。⭐⭐⭐ [来源：画布 散图（需纠错）`GET、POST 本身都不加密；HTTPS 下两者都加密`]

### 2.3 HTTP 版本演进

（10）HTTP/1.0 默认 **________** 连接，连接无法复用，可能发生阻塞。⭐⭐ [来源：画布 散图 `1.0 短链接，连接无法复用，可能发生阻塞`]

（11）HTTP/1.1 默认开启 **________**，多个 HTTP 请求可以复用同一个 TCP 连接；但并发请求仍需开多个连接，开销大。⭐⭐⭐ [来源：画布 散图 `1.1 默认开启长连接；多个 http 请求可以复用同一个 tcp 连接`]

（12）HTTP/2.0 的核心是 **________**：一个连接可以并发处理多个请求，并配合头部压缩、二进制分帧。⭐⭐⭐ [来源：画布 散图 `2.0 多路复用 一个连接可以并发处理多个请求`]

（13）HTTP/3.0 基于 QUIC 传输，其底层传输协议是 **________** 而非 TCP，减少了握手延迟。⭐ [来源：外部 HTTP/3 QUIC] [来源：画布 散图 `3.0 ... 二进制分帧`]

### 2.4 状态码

（14）状态码五大类：1XX 信息性、2XX **________**、3XX 重定向、4XX 客户端错误、5XX **________**。⭐⭐⭐ [来源：画布 散图 状态码分类 `2XX 成功状态码；5XX 服务端错误状态码`]

（15）**301** 是 **________** 重定向，浏览器会缓存跳转规则，适合域名永久迁移。⭐⭐ [来源：画布 散图 `301 是永久重定向，浏览器会缓存跳转规则`]

（16）302 是临时重定向，浏览器不缓存，Java `sendRedirect` 默认返回 **________**，适合登录跳转等临时场景。⭐⭐⭐ [来源：画布 散图 `java sendRedirect 默认返回 302`]

### 2.5 转发与重定向

（17）转发是 **Tomcat 应用层内部**的跳转，只发生 **________** 次 HTTP 请求，不产生新的网络报文。⭐⭐⭐ [来源：画布 散图 `转发 Tomcat 应用层内部的跳转，只一次 HTTP 请求`]

（18）重定向是服务端返回 3XX（如 302）状态码、浏览器收到后**再发起全新请求**的过程，因此会产生 **________** 次独立的网络请求。⭐⭐⭐ [来源：画布 散图 `会产生两次独立的网络请求`]

### 2.6 请求体读取与 request 获取

（19）Servlet 原生请求体是一次性 IO 流，默认只能读一次；用 **________** 包装后可以多次读取。⭐⭐ [来源：画布 散图 `用 HttpServletRequestWrapper 包装后存，支持多次读取`]

（20）获取 HttpServletRequest 最简单的方式：在 Controller 方法参数上直接声明 **________**，Spring 会自动注入。⭐⭐ [来源：画布 散图 `直接在 Controller 方法参数上注入 HttpServletRequest`]

（21）在非 Controller 方法中，可通过 **________** 获取 RequestAttributes，再取出 request/response。⭐⭐ [来源：画布 散图 `通过 RequestContextHolder 实现`]

### 2.7 HTTP 客户端与连接池

（22）JDK 原生 **________** 性能差、连接池功能弱、连接回收慢。⭐⭐ [来源：画布 散图 `JDK 原生自带，性能差，连接池功能弱，连接回收慢`]

（23）Apache **________** 自带连接池，默认开启 keep-alive，自动管理 TCP 连接复用，API 简洁。⭐⭐ [来源：画布 散图 `自动有优选连接池，默认开启 keep-alive`]

（24）连接池复用 TCP 连接的价值在于减少 **________** 和四次挥手带来的开销，提升吞吐。⭐⭐ [来源：外部 连接池复用收益]

（25）除了 Controller 参数注入和 RequestContextHolder，在 **________**（过滤器）中也可以注入 HttpServletRequest，Spring 会把当前请求绑定到当前线程。⭐⭐ [来源：画布 散图 `在过滤器 Filter 中，可以注入 HttpServletRequest`]

（26）SpringBoot 获取 HttpServletRequest 的三种方式：Controller 方法参数注入、RequestContextHolder，以及在单例 Bean 中不能直接注入时改用 **________** 注入当前请求对应的变量。⭐⭐ [来源：画布 散图 `SpringBoot 获取 HttpServletRequest 请求的三种方式` + `如果单例中不能直接用，可以用 @Autowired 注入 HTTP 请求对应的变量`]

（27）**________** 状态码表示资源未变更（协商缓存命中），浏览器直接使用本地缓存以节省带宽，但它每次仍会向服务器发起请求做校验。⭐⭐⭐ [来源：画布 散图 `304 缓存相关：资源未变更，节省带宽，每次请求都回服务器`]

---

## 模块三 · HTTPS 与 Web 安全

### 3.1 HTTPS 与 TLS

（1）HTTP + **________** = HTTPS。⭐⭐⭐ [来源：画布 散图 `HTTP + TLS = HTTPS`]

（2）TLS 负责三件事：**________**、验证身份、防篡改。⭐⭐⭐ [来源：画布 散图 `TLS 负责加密、验身份、防篡改`]

（3）TLS 不是 HTTP，而是位于 TCP 之上、**________** 之下的安全协议。⭐⭐ [来源：画布 散图 `TLS 不是 HTTP，是在 TCP 之上、HTTP 之下的安全协议`]

（4）TLS 握手发生在 TCP 三次握手 **________**，握手完成后才会发出 HTTP 请求。⭐⭐⭐ [来源：画布 散图 `TCP 连接之上后，再协商加密通道，握手完成之后，HTTP 请求才会发出去`]

### 3.2 CSRF 跨站请求伪造

（5）CSRF 全称 **________**（跨站请求伪造），是一种挟持用户在已登录 Web 应用中执行非本意操作的攻击方法。⭐⭐⭐ [来源：画布 散图 `CSRF：跨站请求伪造（Cross-site request forgery）`]

（6）CSRF 能生效的根本原因：浏览器会自动携带目标站点的 **________**。⭐⭐⭐ [来源：画布 散图 `因为 CSRF 的原理是自动带上浏览器 Cookie`]

（7）前后端分离把 token 放在请求头 **________**、不使用 Cookie，就天然免疫 CSRF。⭐⭐⭐ [来源：画布 散图 `token 放在 Header（Authorization）不使用 Cookie 就安全，天然免疫 CSRF`]

（8）❌ 加上 CORS 就能防住 CSRF？→ ✅ 错。CORS 只是浏览器限制 JS **________**，服务端请求照常执行，因此 CORS 不能防 CSRF。⭐⭐⭐ [来源：画布 散图（需纠错）`CORS 不能防 CSRF`]

（9）防御 CSRF 的补充手段：给 Cookie 加上 **________** 属性（Lax/Strict），跨站请求不携带该 Cookie。⭐⭐ [来源：外部 SameSite Cookie]

### 3.3 XSS 跨站脚本

（10）XSS 攻击是攻击者在 Web 页面里插入 **________**，用户浏览时被浏览器执行。⭐⭐⭐ [来源：画布 散图 `在 Web 页面里插入恶意 html 代码`]

（11）XSS 的高发场景是 **________**、论坛等用户输入回显的地方。⭐⭐ [来源：画布 散图 `留言、论坛`]

（12）XSS 防御：对输入进行过滤、HTML **________**、校验跳转链接禁止 `javascript:` 开头、限制输入长度。⭐⭐⭐ [来源：画布 散图 `HTML 转义 ... 限制输入长度`]

### 3.4 其他攻击面

（13）DDoS 全称 **________**（Distributed Denial of Service），用大量分布式请求压垮服务。⭐⭐ [来源：画布 散图 `DDoS: (Distributed Denial of Service)`]

（14）`sendRedirect(request.getParameter("target"))` 未校验 target，会造成 **________** 漏洞，被跳转到恶意站点。⭐⭐⭐ [来源：画布 散图 校验代码截图 `未做任何校验`]

（15）开放重定向的修复方式：校验 target 必须属于 http/https 的 **________**。⭐⭐ [来源：画布 散图 `校验：判断 target 是否为 http/https 开头`]

### 3.5 会话保持 Cookie / Session / Remember-Token

（16）HTTP 无状态，靠 **Cookie** + **________** 保持登录态。⭐⭐ [来源：画布 散图 `Session 和 Cookie`]

（17）Session 默认 **________** 分钟无操作超时。⭐⭐ [来源：画布 散图 `简单 Session 还没超时失效（30 分钟无操作超时）`]

（18）Remember-Token 免登录：数据库单独存 remember_token → userId 的映射，Cookie 里存的是 **________** 而不是 SessionID。⭐⭐ [来源：画布 散图 `Cookie 里 token=remember_token 不是 SessionID`]

（19）remember_token 校验通过后，服务端会临时新建一个 **________** 放用户信息，再下发新标识。⭐⭐ [来源：画布 散图 `临时创建一个新的 Session，把用户信息放进 Session`]

（20）这样设计的意义：Session 可以设得很短，只要 remember_token 有效就能自动 **________**。⭐⭐ [来源：画布 散图 `只要 remember_token 有效，就能自动重建会话`]

（21）CSRF 的另外两种防御手段：服务端校验请求头 **________** 是否为本站地址；或采用「双重提交 Cookie」——让 JS 读取 Cookie 后放进请求头，API 只认请求头而不认 Cookie。⭐⭐ [来源：画布 散图 `服务端校验 Referer；让 JS 读取 Cookie，但 API 只认 header（双重提交 Cookie）`]

（22）集群环境下 Session 共享的常见做法是 **________**（把会话广播到其他节点）或持久化到 Redis，避免请求落到另一台机器时登录态丢失。⭐⭐ [来源：画布 散图 `集群方案：Session 复制或持久化`]

（23）JWT 与 Session 的核心差异：JWT 是**无状态**的——**________**，令牌自带用户、过期时间等信息，服务端验签即可；Session 则要在服务端存状态、靠 Cookie 传 SessionID。⭐⭐ [来源：画布 散图 `JWT 是无状态的 -服务端不存`]

---

## 模块四 · TCP 三次握手与四次挥手

### 4.1 TCP 基础

（1）TCP 是面向连接的、可靠的、基于 **________** 的传输层协议。⭐⭐⭐ [来源：画布 散图 `面向字节流的连接的可靠传输协议`]

（2）TCP 是 **________** 的，两个方向的通信可以同时进行，也可以各自独立关闭。⭐⭐⭐ [来源：画布 TCP `TCP 是全双工`]

（3）TCP 的三次握手与四次挥手由 **________** 完成，Tomcat 只等待内核通知"有新连接到来"。⭐⭐⭐ [来源：画布 TCP `三次握手是操作系统内核代码完成，不是 Tomcat 代码手动写`]

### 4.2 三次握手

（4）第一次握手：客户端发送 **________**，携带初始序列号 seq=x。⭐⭐⭐ [来源：画布 TCP `第一次握手（客户端→服务器）：SYN，seq=x`]

（5）第二次握手：服务端回复 **________**，既回 ack=x+1，也带上自己的 seq=y。⭐⭐⭐ [来源：画布 TCP `第二次握手（服务器→客户端）：SYN+ACK`]

（6）第三次握手：客户端回复 **________**（ack=y+1），TCP 连接正式建立。⭐⭐⭐ [来源：画布 TCP `第三次握手（客户端→服务器）：ACK，ack=y+1`]

（7）只有完成第三次握手，服务端才确认客户端 **________**，才真正建立连接。⭐⭐⭐ [来源：画布 散图 `只有 A 发了 ACK，B 才确认 A 正在线，才真正打开连接`]

### 4.3 为什么三次而不是两次

（8）❌ 两次握手就足够建立可靠连接？→ ✅ 错。两次握手只能确认 A→B 通道，无法确认 **________** 通道；TCP 是全双工，两条通道都要确认。⭐⭐⭐ [来源：画布 散图（需纠错）`两次握手只能保证 A 发给 B 普通正常，无法保证 B 发给 A`]

（9）若只有两次握手，客户端超时重发 SYN 后，最早那个**迟到的旧 SYN** 抵达时，服务端会立刻新建一条无用连接，**________**。⭐⭐⭐ [来源：画布 TCP `服务器白白创建了一条完全没用的连接`]

### 4.4 四次挥手

（10）第一次挥手：主动关闭方（如浏览器）发送 **________**，表示自己不再发数据。⭐⭐⭐ [来源：画布 TCP `第一次挥手（主动关闭方…）FIN`]

（11）第二次挥手：服务端回复 ACK，此时进入 **________** 状态——客户端不再发，但服务端还能继续把剩余数据发完。⭐⭐⭐ [来源：画布 TCP `此时半关闭状态`]

（12）第三次挥手：服务端把剩余数据发完后发送 **________**。⭐⭐ [来源：画布 TCP `第三次挥手（服务器 FIN）`]

（13）第四次挥手：客户端回复 ACK，并等待 **________** 后才关闭。⭐⭐⭐ [来源：画布 TCP `第四次挥手（客户端 ACK）...等待 2MSL`]

（14）❌ 四次挥手可以合并成三次？→ ✅ 错。TCP 全双工，两个方向独立关闭；B 可能还有数据要发，ACK 与 FIN **________**，标准就是四次。⭐⭐⭐ [来源：画布 TCP（需纠错）`ACK 和 FIN 分开发，要挥手 4 次`]

### 4.5 TIME_WAIT 与 2MSL

（15）MSL 全称 **________**，指报文在网络中存活的最长时间。⭐⭐ [来源：画布 TCP `MSL：Maximum Segment Lifetime`]

（16）等待 2MSL 的作用一：确保最后一个 **________** 能送达；若丢失，对方重发 FIN 时还能再接一次。⭐⭐⭐ [来源：画布 TCP `确保对方收到最后的 ACK`]

（17）等待 2MSL 的作用二：让旧连接的 **________** 在网络中自然消失，避免污染同 IP + 端口的新连接。⭐⭐⭐ [来源：画布 TCP `避免旧连接的延迟报文污染新连接`]

（18）客户端四次挥手状态流转：ESTABLISHED → FIN_WAIT_1 → **________** → TIME_WAIT → CLOSED。⭐⭐ [来源：画布 TCP 状态机图]

（19）服务端四次挥手状态流转：ESTABLISHED → **________** → LAST_ACK → CLOSED。⭐⭐ [来源：画布 TCP 状态机图]

（20）若服务端出现大量 CLOSE_WAIT 堆积，通常是因为应用 **________**，属代码层面的问题。⭐ [来源：外部 CLOSE_WAIT 排查]

### 4.6 keep-alive 长连接

（21）HTTP/1.1 开启 keep-alive 后，一次三次握手建立的长连接可连续承载多次 HTTP 请求响应，**不立刻**发起四次挥手，等超时再断开，从而减少 **________** 开销。⭐⭐⭐ [来源：画布 TCP `减少频繁握手开销`]

（22）TCP 连接在内核中用 **________**（Transmission Control Block，传输控制块）维护，记录本端/对端序列号、确认号、窗口大小与连接状态等信息。⭐⭐ [来源：画布 散图 TCB 结构图 `TCB 三个参数：序列号、确认号、ACK、SYN、连接状态`]

（23）三次握手的状态流转：客户端 CLOSED → SYN_SENT → ESTABLISHED；服务端 CLOSED → LISTEN → **________** → ESTABLISHED。⭐ [来源：画布 散图 三次握手状态机图]

---

## 模块五 · TCP/IP 分层与网络封装

### 5.1 四层模型

（1）TCP/IP 四层：应用层、**________**、网络层、网络接口层。⭐⭐⭐ [来源：画布 散图 `TCP/IP 四层模型`]

（2）应用层协议举例：HTTP/HTTPS、FTP、DNS、**________**。⭐⭐ [来源：画布 散图 `HTTP/HTTPS、FTP、DNS、SMTP/POP3`]

（3）传输层两大协议：TCP（可靠、有连接）与 **________**（不可靠、无连接）。⭐⭐⭐ [来源：画布 散图 `UDP：不可靠，无连接`]

（4）网络层的核心是 **________** 地址，负责寻址和路由。⭐⭐⭐ [来源：画布 散图 `网络层 IP：... 根据城市地址（IP）规划跨城市运输路线`]

（5）网络接口层（以太网协议）负责把 IP 包封装成**帧**，用 **________** 地址在同一局域网内传输，并处理 0/1 比特流。⭐⭐ [来源：画布 散图 `使用 MAC 地址在同一个局域网内传输数据`]

（6）**ARP** 协议根据 IP 地址查找 **________**（物理地址）；ICMP 用于传递网络差错/控制消息（如 ping）。⭐⭐ [来源：画布 散图 `ARP：根据 IP 地址找 MAC 物理地址`]

### 5.2 TCP vs UDP

（7）TCP 特点：可靠、有连接、确认重传、流控、不会丢数据；典型场景是网页访问、**________**。⭐⭐⭐ [来源：画布 散图 `网页、文件下载用 TCP`]

（8）UDP 特点：不可靠、无连接、开销小、速度快；典型场景是视频、直播、**________**。⭐⭐⭐ [来源：画布 散图 `视频、直播、视频通话、DNS 查询都用 UDP`]

### 5.3 封装与解封装

（9）数据自上而下封装顺序：应用数据 → 加 TCP 头（源/目标端口、**________**）→ TCP 段 → 加 IP 头 → IP 包 → 加 MAC 头 → 数据帧 → 比特流。⭐⭐⭐ [来源：画布 散图 `加 TCP 头部（里面有源端口、目标 8080 端口、序列号）`]

（10）端口号的作用是区分主机上不同的**应用程序**，这属于 **________** 层的职责。⭐⭐⭐ [来源：画布 散图 `端口（传输层）找到电脑上对应的软件`]

（11）❌ "区分应用程序（靠端口号）是应用层的职责"？→ ✅ 错。靠端口号区分应用是 **________** 层的职责；应用层负责具体应用协议（HTTP、DNS）。⭐⭐⭐ [来源：画布 散图（需纠错）`应用层：负责数据…区分主机上不同的应用程序（靠端口号）`]

（12）下层协议不解析上层报文内容：TCP 只识别 **________**，不看 HTTP 请求内容。⭐⭐⭐ [来源：画布 散图 `TCP（传输层）只识别端口，不会看 HTTP 请求内容`]

### 5.4 快递类比

（13）用快递类比四层：MAC = **门牌号**（同小区内送货）、IP = 城市地址（跨城路由）、端口 = **________**（找到具体收件人/应用）、应用层 = 包裹里装的东西。⭐⭐ [来源：画布 散图 快递类比图 `小区里房间号（端口），找到房子里具体收快递的人`]

---

## 模块六 · 一次 HTTP 请求的完整链路

### 6.1 浏览器输入 URL 到页面显示

（1）第一步：用 **________** 把域名（如 www.baidu.com）解析成对应的 IP。⭐⭐⭐ [来源：画布 散图 `将 www.baidu.com 解析成对应的 IP`]

（2）第二步：TCP **________** 建立连接。⭐⭐⭐ [来源：画布 散图 `TCP 三次握手建立连接`]

（3）第三、四步：浏览器发送 HTTP 请求，服务端返回 **________**。⭐⭐ [来源：画布 散图 `3.HTTP请求 4.HTTP响应`]

（4）第五步：浏览器解析 HTML/CSS/JS 并 **________** 页面。⭐⭐ [来源：画布 散图 `浏览器解析 HTTP、渲染页面`]

（5）第六步：TCP **________** 断开连接。⭐⭐⭐ [来源：画布 散图 `TCP 四次挥手，断开连接`]

（6）域名解析使用 **DNS** 协议，其默认端口是 **________**。⭐⭐ [来源：外部 DNS 53 端口] [来源：画布 散图 `DNS 查询请求`]

### 6.2 服务端全链路

（7）典型 Spring 项目链路：DNS → **________**（反向代理/负载均衡）→ Tomcat → DispatcherServlet → Controller → Service → **MyBatis** → MySQL。⭐⭐ [来源：画布 流程 `NGINX / MYSQL / mybatis / controller`]

（8）Tomcat 负责解析 HTTP 报文并分配工作线程，**________** 负责把请求分发到 Controller——两者分工明确。⭐⭐⭐ [来源：画布 流程 + DispatcherServlet `DispatcherServlet 去 Spring 容器找对应的 Controller 执行业务`]

### 6.3 SpringMVC 处理流程（五大组件）

（9）SpringMVC 的前端控制器是 **________**，负责请求分发、Controller 处理与视图渲染。⭐⭐⭐ [来源：画布 DispatcherServlet `中央处理器 DispatcherServlet`]

（10）**HandlerMapping**（处理器映射器）根据 URL 查找 Handler，并返回 **________** 执行链。⭐⭐⭐ [来源：画布 散图 `根据请求 url 查找 handler，拿到 HandlerExecutionChain 执行链`]

（11）**________**（处理器适配器）负责真正调用 Controller 方法。⭐⭐⭐ [来源：画布 散图 `HandlerAdapter 才负责支撑 Controller 方法`]

（12）Controller 执行后返回 **________**（模型与视图）。⭐⭐ [来源：画布 DispatcherServlet `返回 ModelAndView`]

（13）**________** 把逻辑视图名解析成具体 View，由 View 负责渲染 HTML。⭐⭐ [来源：画布 DispatcherServlet `ViewResolver 解析...View 渲染`]

（14）SpringMVC 主流程：DispatcherServlet → HandlerMapping → HandlerAdapter → Controller → ModelAndView → **________** → View 渲染 HTML。⭐⭐⭐ [来源：画布 DispatcherServlet `DispatcherServlet → HandlerMapping → HandlerAdapter → Controller 返回 ModelAndView → ViewResolver → View 渲染 HTML`]

（15）DispatcherServlet 本质是一个 Servlet（继承 HttpServlet），运行在 **________** 里。⭐⭐⭐ [来源：画布 DispatcherServlet `跑在 Tomcat 里面，是一个 Servlet`]

（16）@RestController 返回 JSON 时不走 ViewResolver，而由 **________**（如 MappingJackson2HttpMessageConverter）序列化输出。⭐ [来源：外部 SpringMVC JSON 序列化]

（17）SpringMVC 流程图中 Controller 之前的 **________**（HandlerInterceptor）用于登录校验、日志、权限等横切逻辑，在 HandlerAdapter 调用 Controller 前后执行。⭐⭐ [来源：画布 DispatcherServlet 流程图 `Interceptor`] [来源：外部 HandlerInterceptor]

---

*共 125 题（128 个填空），覆盖 Tomcat 模块全部重要知识点。*
*答案见同目录 `003OBTomcat预习填空题答案.md`。*
