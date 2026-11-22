# 001OB · Mybatis 模块 · 预习填空题

> 📂 **源资料**
> - **所在路径**：`D:\Works\Interview\004-ObsidianCanvas\ObsidianP\Java\001AL\001文本资料\ALLInOne\001Mybatis`
> - **源文件**：`面渣逆袭 MyBatis.md`（主体，20 道高频题）+ 16 个问答 md（`#和$的区别`、`MyBatis-Plus`、`分页原理`、`缓存机制`、`工作原理`、`连接池`、`字段映射`、`插件原理` 等）
> - **参考模块**：Mybatis（基础与 ORM、使用过程与生命周期、传参与映射、动态 SQL 与批量、缓存、工作原理与架构、插件机制、分页、MyBatis-Plus、连接池与数据源）
> - 📅 生成日期：2026-11-20

> 📌 本预习单来源为 **md 文本资料库**（非画布）。每题来源标注为 `[来源：资料 文件名/主题]`，其中「面渣逆袭」指 `面渣逆袭 MyBatis.md`，其余为对应问答 md。
> 📌 每题后标注：⭐ 重要程度 + 来源。目的：填空 → 对答案 → 面试能讲出来。
> 📌 使用方式：直接做填空 → 对照答案版 → 错题回资料库定位原文档。

---

## 模块一 · MyBatis 基础与 ORM

### 1.1 MyBatis 是什么

（1）MyBatis 是一个 **________** ORM（对象关系映射）框架，内部封装了 JDBC，开发时只需要关注 SQL 语句本身，不需要处理加载驱动、创建连接、创建 Statement 等过程。⭐⭐⭐ [来源：资料 面渣逆袭 `半 ORM 框架，内部封装了 JDBC`]

（2）ORM 的英文全称是 **________**（对象关系映射），用于解决关系型数据库数据与简单 Java 对象（POJO）之间的映射问题。⭐⭐⭐ [来源：资料 面渣逆袭 + 什么是ORM]

（3）MyBatis 是半自动 ORM，Hibernate 是 **________** ORM：MyBatis 查询关联对象需手动写 SQL，而 Hibernate 可根据对象关系模型直接获取关联对象。⭐⭐⭐ [来源：资料 面渣逆袭 `Hibernate 属于全自动 ORM 映射工具`]

（4）JDBC 编程的四大不足是：连接创建释放频繁造成资源浪费、SQL 写在代码里不易维护、向 SQL 传参数麻烦、以及 **________** 解析麻烦；MyBatis 分别用连接池、XML 分离、自动映射、自动结果映射来对应解决。⭐⭐ [来源：资料 面渣逆袭 `对结果集解析麻烦`]

（5）MyBatis 使用 **________** 或注解来配置和映射原生信息，将 POJO 映射成数据库记录，避免了几乎所有的 JDBC 代码和手动设置参数。⭐⭐ [来源：资料 面渣逆袭 `使用 XML 或注解`]

### 1.2 Hibernate 与 MyBatis 对比

（6）映射关系上：MyBatis 是半自动映射，配置的是 Java 对象与 **________** 执行结果的对应关系；Hibernate 是全表映射，配置的是 Java 对象与数据库表的对应关系。⭐⭐ [来源：资料 面渣逆袭 `配置 Java 对象与 sql 语句执行结果的对应关系`]

（7）SQL 与移植性上：Hibernate 提供 HQL、数据库无关性好但 SQL 优化困难；MyBatis 手动写 SQL、**________** 性差，但 SQL 优化容易。⭐⭐ [来源：资料 面渣逆袭 `不支持数据库无关性`]

（8）适用场景上：Hibernate 适合需求相对稳定、中小型项目（如办公自动化）；MyBatis 适合需求变化频繁、**________** 的项目（如电商网站）。⭐⭐ [来源：资料 面渣逆袭 `快速迭代`]

### 1.3 MyBatis 的优点

（9）MyBatis 的优点：数据库操作逻辑与业务解耦、只需写 SQL 不用关心连接等操作、字段可直接映射到 DO、支持多种数据源、支持 **________**（如 if/foreach）、支持一二级缓存。⭐⭐ [来源：资料 面渣逆袭 + Mybatis的优点]

---

## 模块二 · 使用过程与生命周期

### 2.1 使用过程

（1）MyBatis 使用过程的正确顺序：创建 SqlSessionFactoryBuilder → 创建 **________** → 创建 SqlSession → 通过 SqlSession 执行数据库操作 → commit 提交 → close 关闭。⭐⭐⭐ [来源：资料 面渣逆袭 `通过 SqlSessionFactory 创建 SqlSession`]

（2）创建 SqlSessionFactory 的代码是：`new SqlSessionFactoryBuilder().build(inputStream)`；创建 SqlSession 用工厂的 **________** 方法。⭐⭐ [来源：资料 面渣逆袭 `openSession()`]

（3）SqlSession（会话）可以理解为程序和 **________** 之间的桥梁。⭐⭐ [来源：资料 面渣逆袭 `程序和数据库之间的桥梁`]

### 2.2 生命周期

（4）SqlSessionFactoryBuilder 实例的生命周期只存在于 **________** 内部（一旦创建了 SqlSessionFactory 就不再需要它）。⭐⭐ [来源：资料 面渣逆袭 `方法的内部`]

（5）SqlSessionFactory 相当于一个数据库连接池，它的生命周期是 **________** 级，而且应该是单例的。⭐⭐⭐ [来源：资料 面渣逆袭 `应用级`]

（6）SqlSession 相当于 JDBC 中的 Connection，它的实例 **________** 线程安全的，最佳生命周期是一次请求或一个方法。⭐⭐⭐ [来源：资料 面渣逆袭 `不是线程安全的`]

（7）Mapper（映射器）是从 SqlSession 中获得的，它的生命周期一般控制在 **________** 级。⭐⭐ [来源：资料 面渣逆袭 `方法级`]

---

## 模块三 · 传参与映射

### 3.1 传递多个参数

（1）mapper 中传递多个参数的四种方式：顺序传参法（#{} 里用数字）、**________** 注解传参法、Map 传参法、Java Bean 传参法。⭐⭐⭐ [来源：资料 面渣逆袭 `@Param 注解传参法`]

（2）使用 @Param("userName") 后，#{} 里的名称对应的是 **________** 括号里修饰的名称。⭐⭐ [来源：资料 面渣逆袭 `@Param 括号里面修饰的名称`]

（3）顺序传参法（#{} 里写 0、1）不建议使用，原因是 SQL 层表达不直观，且 **________** 调整时容易出错。⭐⭐ [来源：资料 面渣逆袭 `顺序调整容易出错`]

### 3.2 字段映射

（4）实体类属性名和表中字段名不一致时，有两种解决方式：在 SQL 里给字段起 **________**，或使用 resultMap 映射。⭐⭐⭐ [来源：资料 面渣逆袭 `定义字段名的别名`]

（5）resultMap 中，用 **________** 属性映射主键字段，用 `<result>` 属性映射非主键字段。⭐⭐ [来源：资料 面渣逆袭 `用 id 属性来映射主键字段`]

（6）MyBatis 字段映射的四种方式：列名映射、别名映射、**________** 映射、自定义 TypeHandler 映射。⭐⭐ [来源：资料 字段映射 `ResultMap 映射`]

（7）字段映射的核心代码在 **________** 类中，它负责把 JDBC 的 ResultSet 转换成 Java 对象。⭐⭐ [来源：资料 字段映射 `ResultSetHandler`]

（8）默认映射规则：如果没有配置映射关系，MyBatis 会把数据库字段的 **________** 转为驼峰式命名来映射 Java 属性。⭐⭐ [来源：资料 工作原理 `下划线转为驼峰`]

### 3.3 TypeHandler 与枚举

（9）MyBatis 可以映射枚举类，方式是自定义一个 **________**，实现它的 setParameter() 和 getResult() 接口方法。⭐⭐ [来源：资料 面渣逆袭 `TypeHandler`]

（10）TypeHandler 的两个作用：完成 javaType→jdbcType 的转换（体现为 setParameter()），以及完成 **________**→javaType 的转换（体现为 getResult()）。⭐⭐ [来源：资料 面渣逆袭 `jdbcType 至 javaType`]

### 3.4 #{} 与 ${}

（11）#{} 和 ${} 的核心区别：#{} 是占位符，走 **________** 处理（替换为 ? 再用 set 赋值）；${} 是字符串替换，直接拼接。⭐⭐⭐ [来源：资料 面渣逆袭 + #和$的区别 `#{} 预编译处理`]

（12）能否防止 SQL 注入：#{} **________** 防止 SQL 注入；${} 不能防止。⭐⭐⭐ [来源：资料 面渣逆袭 `#{} 可以有效防止 SQL 注入`]

（13）必须用 ${} 的场景：动态选择 **________**、group by 等后面的字段（这些位置不能用占位符）。⭐⭐⭐ [来源：资料 #和$的区别 `order by、group by`]

（14）如果必须用 ${}，避免 SQL 注入的方式有：参数验证、使用 **________** 或固定列表限制输入（如 SortOrder 枚举）。⭐⭐ [来源：资料 #和$的区别 `枚举或预定义列表`]

（15）模糊查询 like 的推荐写法是：`like **________**(’%’, #{question}, ’%’)`。⭐⭐ [来源：资料 面渣逆袭 `CONCAT()`]

（16）关联查询：一对一用 **________** 标签，一对多用 `<collection>` 标签。⭐⭐⭐ [来源：资料 面渣逆袭 `association`]

### 3.5 延迟加载与主键回填

（17）MyBatis 支持延迟加载，配置文件中用 **________**=true 全局启用（lazyLoadingEnabled，让关联对象按需加载）。⭐⭐⭐ [来源：资料 面渣逆袭 `lazyLoadingEnabled=true|false`]

（18）延迟加载的原理：使用 **________** 创建目标对象的代理对象，调用方法时进入拦截器，发现关联对象（如 a.getB()）为 null 时才单独发送查询 SQL 加载。⭐⭐⭐ [来源：资料 面渣逆袭 `CGLIB 创建目标对象的代理对象`]

（19）延迟加载的局部配置：在 `<association>` 或 `<collection>` 中指定 **________**="lazy"，让某个关联按需加载（覆盖全局设置）。⭐⭐ [来源：资料 延迟加载 `fetchType="lazy"`]

（20）获取生成的主键：在 insert 标签中添加 **________**="true" keyProperty="userId"，即可把数据库自增主键回填到对象。⭐⭐⭐ [来源：资料 面渣逆袭 `useGeneratedKeys="true" keyProperty="userId"`]

---

## 模块四 · 动态 SQL 与批量操作

### 4.1 动态 SQL 标签

（1）MyBatis 动态 SQL 的原理是使用 **________**（对象图导航语言）从 SQL 参数对象中计算表达式的值，根据值动态拼接 SQL。⭐⭐ [来源：资料 面渣逆袭 `OGNL`]

（2）动态 SQL 常用标签：if、choose/when/otherwise、where、set、**________**、foreach。⭐⭐⭐ [来源：资料 面渣逆袭 `trim`]

（3）choose/when/otherwise 标签的作用类似 Java 中的 **________** 语句。⭐⭐ [来源：资料 面渣逆袭 `switch`]

（4）`<where>` 标签可以用在所有查询条件都是 **________** 的情况（自动去掉多余的 AND/OR）。⭐⭐ [来源：资料 面渣逆袭 `动态`]

### 4.2 foreach 与批量操作

（5）foreach 标签的主要属性：item、index、open、separator、close、以及必须指定的 **________**（集合属性）。⭐⭐⭐ [来源：资料 面渣逆袭 `collection`]

（6）foreach 的 collection 属性取值：单参数 List 时为 **________**、单参数 array 数组时为 array、多参数封装 Map 时取 Map 里的 key。⭐⭐ [来源：资料 面渣逆袭 `list`]

（7）批量插入的第一种方式是用 foreach 遍历拼接 `values(),(),()`（MySQL 支持）；第二种方式是使用 ExecutorType.**________** 模式（重复使用预处理语句批量执行）。⭐⭐⭐ [来源：资料 面渣逆袭 `BATCH`]

（8）BATCH 批量模式的一个问题：Insert 操作在事务未提交之前，无法获取 **________** id，某些场景不符合业务需求。⭐⭐ [来源：资料 面渣逆袭 `自增`]

---

## 模块五 · 缓存机制

### 5.1 一级缓存

（1）MyBatis 一级缓存基于 **________** 的 HashMap 本地缓存，存储作用域为 SqlSession，各 SqlSession 之间缓存相互隔离。⭐⭐⭐ [来源：资料 面渣逆袭 `PerpetualCache`]

（2）一级缓存默认 **________**；当 Session flush 或 close 之后，该 SqlSession 中的缓存会被清空。⭐⭐⭐ [来源：资料 面渣逆袭 `默认打开`]

（3）一级缓存的局限：只是没有容量限定的 HashMap，且最大范围是 SqlSession 内部，多 SqlSession 或分布式环境下会有 **________** 问题，建议缓存级别设为 Statement。⭐⭐ [来源：资料 缓存机制 `脏数据`]

### 5.2 二级缓存

（4）二级缓存与一级缓存机制相同（默认 PerpetualCache、HashMap），但存储作用域是 **________**（Namespace），可在多个 SqlSession 之间共享。⭐⭐⭐ [来源：资料 面渣逆袭 `Mapper(Namespace)`]

（5）二级缓存默认 **________**（不开启），要开启需在映射文件中配置，且实体类要实现 Serializable 序列化接口。⭐⭐⭐ [来源：资料 面渣逆袭 `默认不打开`]

（6）二级缓存可自定义存储源，例如 **________**。⭐⭐ [来源：资料 面渣逆袭 `Ehcache`]

（7）二级缓存容易出现脏数据的原因：它基于 namespace 隔离，多表关联查询时，一个 namespace 更新了表，另一个 namespace 里的缓存 **________** 更新，导致脏读。⭐⭐ [来源：资料 缓存机制 `不会更新`]

（8）实际工作中不建议直接用 MyBatis 二级缓存，原因是数据一致性问题，推荐用 **________**、Memcached、Guava、Caffeine 等第三方缓存。⭐⭐ [来源：资料 缓存机制 `Redis`]

---

## 模块六 · 工作原理与架构

### 6.1 工作原理

（1）MyBatis 的工作原理可分为两大步：**________** 和会话运行。⭐⭐ [来源：资料 面渣逆袭 `生成会话工厂`]

（2）构建会话工厂分两步：先获取配置（生成 **________** 配置类实例），再构建 SqlSessionFactory（实际是 DefaultSqlSessionFactory）。⭐⭐⭐ [来源：资料 面渣逆袭 `Configuration`]

（3）Configuration 配置类的作用：读取配置/映射文件、初始化基础配置（别名、插件、映射器、ObjectFactory）、提供 **________** 作为会话工厂构建的重要参数。⭐⭐ [来源：资料 面渣逆袭 `单例`]

### 6.2 四大组件

（4）会话运行离不开四大组件：Executor（执行器）、StatementHandler（数据库会话器）、**________**（参数处理器）、ResultSetHandler（结果处理器）。⭐⭐⭐ [来源：资料 面渣逆袭 `ParameterHandler`]

（5）SqlSession 只是一个门面（相当于客服），真正干活的是 **________**（执行器），它提供查询、更新和事务方法。⭐⭐⭐ [来源：资料 面渣逆袭 `Executor`]

（6）MyBatis 的功能架构分为三层：**________**（供外部调用的本地 API）、数据处理层（SQL 查找/解析/执行/结果映射）、基础支撑层（连接/事务/配置/缓存）。⭐⭐ [来源：资料 面渣逆袭 `API 接口层`]

### 6.3 Mapper 动态代理

（7）Mapper 接口不需要实现类，原因是 **________**：MyBatis 通过 MapperProxyFactory 生成 MapperProxy 代理对象。⭐⭐⭐ [来源：资料 面渣逆袭 `动态代理`]

（8）获取 Mapper 的过程：getMapper → MapperProxyFactory（生成 **________** 代理对象）→ MapperMethod（execute 真正执行 SQL）。⭐⭐ [来源：资料 面渣逆袭 `MapperProxy`]

### 6.4 Executor 执行器

（9）MyBatis 三种 Executor：**________**（每次执行都新建 Statement）、ReuseExecutor（复用 Statement）、BatchExecutor（批量）。⭐⭐⭐ [来源：资料 面渣逆袭 `SimpleExecutor`]

（10）ReuseExecutor 的特点：以 **________** 作为 key 查找 Statement，存在就复用，不存在才创建，用完不关闭放入 Map。⭐⭐ [来源：资料 面渣逆袭 `sql`]

（11）指定使用哪种 Executor 的方式：在 settings 中配置默认的 ExecutorType，或手动调用 **________** 方法传 ExecutorType 参数。⭐⭐ [来源：资料 面渣逆袭 `openSession(ExecutorType)`]

---

## 模块七 · 插件机制

（1）MyBatis 插件的原理：在 ParameterHandler、ResultSetHandler、StatementHandler、**________** 这四大对象调度时，插入我们自己的代码。⭐⭐⭐ [来源：资料 面渣逆袭 `Executor`]

（2）插件机制使用 **________** 动态代理为目标对象生成代理对象，工具类 Plugin 实现了 InvocationHandler 接口。⭐⭐ [来源：资料 面渣逆袭 `JDK`]

（3）编写插件需要实现 **________** 接口（org.apache.ibatis.plugin.Interceptor），重写 intercept() 方法。⭐⭐⭐ [来源：资料 面渣逆袭 `Interceptor`]

（4）给插件编写注解 **________**（如 @Intercepts/@Signature），确定要拦截的对象、方法及参数类型。⭐⭐ [来源：资料 面渣逆袭 `@Intercepts`]

（5）插件运行流程使用 **________** 模式：所有插件封装成 InvocationChain，执行 SQL 时依次调用各插件的 intercept 方法。⭐⭐ [来源：资料 插件原理 `责任链`]

---

## 模块八 · 分页

### 8.1 逻辑分页与物理分页

（1）MyBatis 的 RowBounds 对象实现的是 **________** 分页（针对 ResultSet 结果集做内存分页，而非物理分页）。⭐⭐⭐ [来源：资料 面渣逆袭 `内存分页`]

（2）物理分页是指最终 SQL 中带 **________**，返回的就是分页后结果；逻辑分页是 SQL 照常全查，再在结果集里分页。⭐⭐⭐ [来源：资料 使用MyBatis如何实现分页 `limit`]

（3）MyBatis 实现分页的四种做法：SQL 加 limit、**________** 分页插件、RowBounds、MyBatis-Plus 分页插件。⭐⭐ [来源：资料 使用MyBatis如何实现分页 `PageHelper`]

### 8.2 PageHelper

（4）PageHelper 分页的原理：startPage() 把分页参数存到 **________**，执行器的 query 前取出参数计算起始位置，通过改写 SQL 拼接 limit 实现物理分页，查询后再清除。⭐⭐⭐ [来源：资料 PageHelper分页的原理 `ThreadLocal`]

（5）使用 PageHelper 时，**________** 在 mapper.xml 里写 limit 语句。⭐⭐ [来源：资料 使用MyBatis如何实现分页 `不需要`]

---

## 模块九 · MyBatis-Plus

（1）MyBatis-Plus 是一个 **________** MyBatis 的框架（增强工具），提供通用 Mapper、分页插件、代码生成器等实用功能。⭐⭐ [来源：资料 MyBatis-Plus `增强`]

（2）MyBatis-Plus 的通用 Mapper：继承 **________**<T> 接口即可获得增删改查能力，无需手写 SQL。⭐⭐ [来源：资料 MyBatis-Plus `BaseMapper`]

（3）MyBatis-Plus 支持 **________** 表达式构造查询条件（LambdaQueryWrapper/LambdaUpdateWrapper），代码更简洁。⭐⭐ [来源：资料 MyBatis-Plus `Lambda`]

（4）MyBatis-Plus 分页插件是 **________**（PaginationInnerInterceptor），采用物理分页，拦截 SQL 后拼接 LIMIT。⭐⭐ [来源：资料 MyBatis-Plus分页 `PaginationInnerInterceptor`]

（5）MyBatis-Plus 的缺点：依赖 MyBatis 版本（版本兼容）、**________** 不可靠、代码生成器产物可能需要手动调整。⭐⭐ [来源：资料 MyBatis-Plus `自动映射`]

（6）MyBatis-Plus 的 SQL 注入器：继承 **________**（AbstractSqlInjector）可自定义 SQL 方法（如 customInsert），扩展 MyBatis 的 SQL 操作。⭐⭐ [来源：资料 MyBatis-Plus `SQL注入器`]

（7）MyBatis-Plus 的性能分析插件：用于分析 **________**（SQL 执行效率），帮助优化数据库操作。⭐⭐ [来源：资料 MyBatis-Plus `性能分析插件`]

---

## 模块十 · 连接池与数据源

（1）MyBatis 内置的三种数据源：**________**、Unpooled、JNDI，其中 Pooled 数据源具有连接池。⭐⭐⭐ [来源：资料 连接池 `Pooled`]

（2）MyBatis 通过 **________** 模式来获得对应的数据源（DataSourceFactory 及其实例）。⭐⭐ [来源：资料 连接池 `工厂`]

（3）MyBatis 自带连接池的三个缺点：空闲连接占用资源、连接池大小调优困难、**________**（应用未正确关闭连接导致连接数不断增加）。⭐⭐ [来源：资料 连接池 `连接泄漏`]

（4）实际生产一般不用 MyBatis 自带的 PooledDataSource，而用 **________**（想要 SQL 监控可用 Druid）。⭐⭐ [来源：资料 连接池 `Hikari`]

---

*共 84 题（84 个填空），覆盖 Mybatis 模块全部重要知识点。*
*答案见同目录 `001OBMybatis预习填空题答案.md`。*