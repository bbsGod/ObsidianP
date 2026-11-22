# 001OB · Mybatis 模块 · 预习填空题 · 答案版

> 📂 **源资料**
> - **所在路径**：`D:\Works\Interview\004-ObsidianCanvas\ObsidianP\Java\001AL\001文本资料\ALLInOne\001Mybatis`
> - **源文件**：`面渣逆袭 MyBatis.md`（主体）+ 16 个问答 md + 34 张配图
> - 📅 生成日期：2026-11-20

> 📌 对照 `001OBMybatis预习填空题.md` 使用。答案加粗，每题附来源。

---

## 模块一 · MyBatis 基础与 ORM

> 💬 **口述框架**：先一句话定义 MyBatis（半 ORM，封装 JDBC，只关注 SQL）→ 展开 ORM 含义与半自动/全自动对比 → 讲 JDBC 四大痛点怎么被解决 → 落到 Hibernate vs MyBatis 的映射、SQL、场景三方面对比。易错点：MyBatis 是「半自动」不是「全自动」；Hibernate 是「全表映射」、MyBatis 是「对象-SQL 结果映射」。

### 1.1 MyBatis 是什么

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **半** | 资料·面渣逆袭 |
| （2） | **Object Relational Mapping** | 资料·面渣逆袭 |
| （3） | **全自动** | 资料·面渣逆袭 |
| （4） | **结果集** | 资料·面渣逆袭 |
| （5） | **XML** | 资料·面渣逆袭 |

### 1.2 Hibernate 与 MyBatis 对比

| 编号 | 答案 | 来源 |
|------|------|------|
| （6） | **SQL 语句** | 资料·面渣逆袭 |
| （7） | **数据库无关** | 资料·面渣逆袭 |
| （8） | **快速迭代** | 资料·面渣逆袭 |

### 1.3 MyBatis 的优点

| 编号 | 答案 | 来源 |
|------|------|------|
| （9） | **动态 SQL** | 资料·面渣逆袭 |

---

## 模块二 · 使用过程与生命周期

> 💬 **口述框架**：按使用五步串起来（Builder → Factory → Session → 执行 → commit/close）→ 重点讲四个组件的生命周期与作用域（Builder 方法级、Factory 应用级单例、Session 请求级非线程安全、Mapper 方法级）。易错点：SqlSession 不是线程安全、不能共享；Factory 是单例、Session 每次请求一个。

### 2.1 使用过程

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **SqlSessionFactory** | 资料·面渣逆袭 |
| （2） | **openSession()** | 资料·面渣逆袭 |
| （3） | **数据库** | 资料·面渣逆袭 |

### 2.2 生命周期

| 编号 | 答案 | 来源 |
|------|------|------|
| （4） | **方法** | 资料·面渣逆袭 |
| （5） | **应用** | 资料·面渣逆袭 |
| （6） | **不是** | 资料·面渣逆袭 |
| （7） | **方法** | 资料·面渣逆袭 |

---

## 模块三 · 传参与映射

> 💬 **口述框架**：先讲多参数四种传法（顺序/@Param/Map/Bean，推荐 @Param 和 Bean）→ 字段映射四条路（别名/ResultMap/TypeHandler/驼峰默认）→ 落到 #{} vs ${}（预编译占位 vs 字符串拼接、防注入、order by 必须用 ${}）→ 关联查询 association/collection。易错点：${} 唯一必须场景是 order by/group by/动态表名；#{} 才能防注入。

### 3.1 传递多个参数

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **@Param** | 资料·面渣逆袭 |
| （2） | **@Param** | 资料·面渣逆袭 |
| （3） | **顺序** | 资料·面渣逆袭 |

### 3.2 字段映射

| 编号 | 答案 | 来源 |
|------|------|------|
| （4） | **别名** | 资料·面渣逆袭 |
| （5） | **`<id>`** | 资料·面渣逆袭 |
| （6） | **ResultMap** | 资料·字段映射 |
| （7） | **ResultSetHandler** | 资料·字段映射 |
| （8） | **下划线** | 资料·工作原理 |

### 3.3 TypeHandler 与枚举

| 编号 | 答案 | 来源 |
|------|------|------|
| （9） | **TypeHandler** | 资料·面渣逆袭 |
| （10） | **jdbcType** | 资料·面渣逆袭 |

### 3.4 #{} 与 ${}

| 编号 | 答案 | 来源 |
|------|------|------|
| （11） | **预编译** | 资料·面渣逆袭 |
| （12） | **能** | 资料·面渣逆袭 |
| （13） | **order by** | 资料·#和$的区别 |
| （14） | **枚举** | 资料·#和$的区别 |
| （15） | **CONCAT** | 资料·面渣逆袭 |
| （16） | **`<association>`** | 资料·面渣逆袭 |

### 3.5 延迟加载与主键回填

| 编号 | 答案 | 来源 |
|------|------|------|
| （17） | **lazyLoadingEnabled** | 资料·面渣逆袭 |
| （18） | **CGLIB** | 资料·面渣逆袭 |
| （19） | **fetchType** | 资料·延迟加载 |
| （20） | **useGeneratedKeys** | 资料·面渣逆袭 |

---

## 模块四 · 动态 SQL 与批量操作

> 💬 **口述框架**：先点动态 SQL 的原理是 OGNL → 列常用标签（if/choose/where/set/trim/foreach）各自场景 → foreach 重点讲 collection 属性三种取值 → 批量操作两种方式（foreach 拼 values、BATCH 执行器）及 BATCH 拿不到自增 id 的坑。易错点：choose 对应 switch 不是 if 嵌套；foreach 的 collection 取值随参数类型变化。

### 4.1 动态 SQL 标签

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **OGNL** | 资料·面渣逆袭 |
| （2） | **trim** | 资料·面渣逆袭 |
| （3） | **switch** | 资料·面渣逆袭 |
| （4） | **动态** | 资料·面渣逆袭 |

### 4.2 foreach 与批量操作

| 编号 | 答案 | 来源 |
|------|------|------|
| （5） | **collection** | 资料·面渣逆袭 |
| （6） | **list** | 资料·面渣逆袭 |
| （7） | **BATCH** | 资料·面渣逆袭 |
| （8） | **自增** | 资料·面渣逆袭 |

---

## 模块五 · 缓存机制

> 💬 **口述框架**：一级缓存（PerpetualCache、SqlSession 级、默认开、flush/close 清空）→ 二级缓存（namespace 级、跨 Session、默认关、需 Serializable）→ 重点讲二级缓存为什么会有脏数据（namespace 隔离、多表）→ 落到实践结论：不用自带二级缓存，用 Redis/Caffeine。易错点：一二级作用域别搞反；二级缓存默认不开启。

### 5.1 一级缓存

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **PerpetualCache** | 资料·面渣逆袭 |
| （2） | **开启** | 资料·面渣逆袭 |
| （3） | **脏数据** | 资料·缓存机制 |

### 5.2 二级缓存

| 编号 | 答案 | 来源 |
|------|------|------|
| （4） | **Mapper** | 资料·面渣逆袭 |
| （5） | **不开启** | 资料·面渣逆袭 |
| （6） | **Ehcache** | 资料·面渣逆袭 |
| （7） | **不会** | 资料·缓存机制 |
| （8） | **Redis** | 资料·缓存机制 |

---

## 模块六 · 工作原理与架构

> 💬 **口述框架**：按两大步讲（构建会话工厂 → 会话运行）→ Configuration 的作用 → 四大组件各自职责（Executor 门面后真正干活的、StatementHandler 会话器、ParameterHandler 参数、ResultSetHandler 结果）→ 三层架构 → Mapper 动态代理（MapperProxyFactory→MapperProxy→MapperMethod）→ 三种 Executor。易错点：SqlSession 是门面、Executor 才干活；Mapper 无实现类靠 JDK 动态代理。

### 6.1 工作原理

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **生成会话工厂** | 资料·面渣逆袭 |
| （2） | **Configuration** | 资料·面渣逆袭 |
| （3） | **单例** | 资料·面渣逆袭 |

### 6.2 四大组件

| 编号 | 答案 | 来源 |
|------|------|------|
| （4） | **ParameterHandler** | 资料·面渣逆袭 |
| （5） | **Executor** | 资料·面渣逆袭 |
| （6） | **API 接口层** | 资料·面渣逆袭 |

### 6.3 Mapper 动态代理

| 编号 | 答案 | 来源 |
|------|------|------|
| （7） | **动态代理** | 资料·面渣逆袭 |
| （8） | **MapperProxy** | 资料·面渣逆袭 |

### 6.4 Executor 执行器

| 编号 | 答案 | 来源 |
|------|------|------|
| （9） | **SimpleExecutor** | 资料·面渣逆袭 |
| （10） | **sql** | 资料·面渣逆袭 |
| （11） | **openSession(ExecutorType)** | 资料·面渣逆袭 |

---

## 模块七 · 插件机制

> 💬 **口述框架**：插件原理 = 在四大对象（Executor/StatementHandler/ParameterHandler/ResultSetHandler）调度时插入自定义代码 → JDK 动态代理（Plugin 工具类）→ 写插件三步：实现 Interceptor + @Intercepts/@Signature 注解 + 配置文件注册 → 责任链模式。易错点：拦截的对象是「四大对象」不是任意类；PageHelper 就是基于此机制。

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **Executor** | 资料·面渣逆袭 |
| （2） | **JDK** | 资料·面渣逆袭 |
| （3） | **Interceptor** | 资料·面渣逆袭 |
| （4） | **@Intercepts** | 资料·面渣逆袭 |
| （5） | **责任链** | 资料·插件原理 |

---

## 模块八 · 分页

> 💬 **口述框架**：先区分物理分页（SQL 带 limit）与逻辑分页（全查再分页）→ 四种做法（limit/PageHelper/RowBounds/MyBatis-Plus）→ PageHelper 原理（ThreadLocal 存参数 + 拦截器改 SQL 拼 limit）→ RowBounds 是逻辑分页。易错点：RowBounds 是内存分页、大数据量不推荐；PageHelper 是物理分页、不需要手写 limit。

### 8.1 逻辑分页与物理分页

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **逻辑** | 资料·面渣逆袭 |
| （2） | **limit** | 资料·使用MyBatis如何实现分页 |
| （3） | **PageHelper** | 资料·使用MyBatis如何实现分页 |

### 8.2 PageHelper

| 编号 | 答案 | 来源 |
|------|------|------|
| （4） | **ThreadLocal** | 资料·PageHelper分页的原理 |
| （5） | **不需要** | 资料·使用MyBatis如何实现分页 |

---

## 模块九 · MyBatis-Plus

> 💬 **口述框架**：MyBatis-Plus 是增强工具 → 六项能力（通用 BaseMapper、分页插件、代码生成、Lambda 查询、SQL 注入器、性能分析）→ 分页是 PaginationInnerInterceptor 物理分页（拼 LIMIT）→ 优缺点（简化开发 vs 版本依赖/自动映射不可靠）。易错点：MP 分页是物理分页；继承 BaseMapper 即可 CRUD。

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **增强** | 资料·MyBatis-Plus |
| （2） | **BaseMapper** | 资料·MyBatis-Plus |
| （3） | **Lambda** | 资料·MyBatis-Plus |
| （4） | **PaginationInnerInterceptor** | 资料·MyBatis-Plus分页 |
| （5） | **自动映射** | 资料·MyBatis-Plus |
| （6） | **AbstractSqlInjector** | 资料·MyBatis-Plus |
| （7） | **SQL 执行效率** | 资料·MyBatis-Plus |

---

## 模块十 · 连接池与数据源

> 💬 **口述框架**：MyBatis 三种数据源（Pooled/Unpooled/JNDI）→ 工厂模式获取 → 自带连接池三缺点（空闲占用/调优难/连接泄漏）→ 实践用 Hikari（监控用 Druid）→ DataSource 概念（连接三步 + 池化）。易错点：Pooled 才带连接池；生产不推荐自带连接池。

| 编号 | 答案 | 来源 |
|------|------|------|
| （1） | **Pooled** | 资料·连接池 |
| （2） | **工厂** | 资料·连接池 |
| （3） | **连接泄漏** | 资料·连接池 |
| （4） | **Hikari** | 资料·连接池 |

---

*全部 84 题（84 个填空）答案已给出。*
*建议：先独立完成填空题，再对照检查，错题回资料库定位原文档。*