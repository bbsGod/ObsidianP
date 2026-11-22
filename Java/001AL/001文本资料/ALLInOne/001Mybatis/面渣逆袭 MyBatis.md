图⽂详解 20 道MyBatis⾯试⾼频题，这次吊打⾯试官，我觉得稳了（⼿动 dog）。整理：沉默王二，戳转载链接，作者：三分恶，戳原文链接。

⼤家好，我是⼆哥呀，⾯渣逆袭系列继续，这节我们的主⾓是MyBatis，作为当前国内最流⾏的ORM 框架，是我们这些 c r u d 选手最趁手的工具，赶紧来看看面试都会问哪些问题吧。

# 基础

## 1. 说说什么是 MyBatis?

![](<面渣逆袭 MyBatis_assets/p001_13.png>)

先吹一下：

- Mybatis 是⼀个半 ORM（对象关系映射）框架，它内部封装了 JDBC，开发时只需要关注 SQL
  语句本⾝，不需要花费精⼒去处理加载驱动、创建连接、创建statement 等繁杂的过程。程序员直
  接编写原⽣态 sql，可以严格控制 sql 执⾏性能，灵活度⾼。

- MyBatis 可以使⽤XML 或注解来配置和映射原⽣信息，将 POJO 映射成数据库中的记录，避免
  了几乎所有的 J D B C 代码和手动设置参数以及获取结果集。

再说一下缺点

- SQL语句的编写⼯作量较⼤，尤其当字段多、关联表多时，对开发⼈员编写SQL语句的功底有⼀
  定要求

- S Q L 语句依赖于数据库，导致数据库移植性差，不能随意更换数据库

### O R M 是什么?

![](<面渣逆袭 MyBatis_assets/p002_22.png>)

- ORM（Object Relational Mapping），对象关系映射，是⼀种为了解决关系型数据库数据与简
  单Java对象（POJO）的映射关系的技术。简单来说，ORM是通过使⽤描述对象和数据库之间映
  射的元数据，将程序中的对象自动持久化到关系型数据库中。

### 为什么说Mybatis是半⾃动ORM映射⼯具？它与全⾃动的区别在哪⾥？

- Hibernate属于全⾃动ORM映射⼯具，使⽤Hibernate查询关联对象或者关联集合对象时，可以根
  据对象关系模型直接获取，所以它是全自动的。

- ⽽Mybatis在查询关联对象或关联集合对象时，需要⼿动编写SQL来完成，所以，被称之为半⾃动
  O R M 映射工具。

### JDBC编程有哪些不⾜之处，MyBatis是如何解决的？

![](<面渣逆袭 MyBatis_assets/p003_28.png>)

- 1、数据连接创建、释放频繁造成系统资源浪费从⽽影响系统性能，在mybatis-config.xml中配置
  数据链接池，使用连接池统一管理数据库连接。

- 2、sql语句写在代码中造成代码不易维护，将sql语句配置在XXXXmapper.xml⽂件中与java代码
  分离。

- 3、向sql语句传参数⿇烦，因为sql语句的where条件不⼀定，可能多也可能少，占位符需要和参
  数⼀⼀对应。Mybatis⾃动将java对象映射⾄sql语句。

- 4、对结果集解析麻烦， s q l 变化导致解析代码变化，且解析前需要遍历，如果能将数据库记录封装
  成pojo对象解析⽐较⽅便。Mybatis⾃动将sql执⾏结果映射⾄java对象。

## 2. Hibernate 和 MyBatis 有什么区别？

相同点

- 都是对 j d b c 的封装，都是应用于持久层的框架。

![](<面渣逆袭 MyBatis_assets/p004_32.png>)

不同点

1）映射关系

- MyBatis 是⼀个半⾃动映射的框架，配置Java对象与sql语句执⾏结果的对应关系，多表关联关系
  配置简单

- Hibernate 是⼀个全表映射的框架，配置Java对象与数据库表的对应关系，多表关联关系配置复
  杂

2） S Q L 优化和移植性

- Hibernate 对SQL语句封装，提供了⽇志、缓存、级联（级联⽐MyBatis 强⼤）等特性，此外还
  提供 HQL（Hibernate Query Language）操作数据库，数据库⽆关性⽀持好，但会多消耗性
  能。如果项目需要支持多种数据库，代码开发量少，但 S Q L 语句优化困难。

- MyBatis 需要⼿动编写 SQL，⽀持动态 SQL、处理列表、动态⽣成表名、⽀持存储过程。开发
  ⼯作量相对⼤些。直接使⽤SQL语句操作数据库，不⽀持数据库⽆关性，但sql语句优化容易。

3）MyBatis和Hibernate的适⽤场景不同

![](<面渣逆袭 MyBatis_assets/p005_36.png>)

- Hibernate 是标准的ORM框架，SQL编写量较少，但不够灵活，适合于需求相对稳定，中⼩型的
  软件项目，比如：办公自动化系统

- MyBatis 是半ORM框架，需要编写较多SQL，但是⽐较灵活，适合于需求变化频繁，快速迭代的
  项目，比如：电商网站

## 3. MyBatis 使用过程？生命周期？

MyBatis基本使⽤的过程⼤概可以分为这么⼏步：

![](<面渣逆袭 MyBatis_assets/p006_40.png>)

- 1）创建SqlSessionFactory

可以从配置或者直接编码来创建SqlSessionFactory

String resource="org/mybatis/example/mybatis-config.xml";InputStream inputStream=Resources.getResourceAsStream(resource);SqlSessionFactory sqlSessionFactory=new SqlSessionFactoryBuilder().build(inputStream);

- 2）通过SqlSessionFactory创建SqlSession

SqlSession（会话）可以理解为程序和数据库之间的桥梁

SqlSession session=sqlSessionFactory.openSession();

- 3）通过sqlsession执⾏数据库操作

可以通过 SqlSession 实例来直接执⾏已映射的 SQL 语句：

Blog blog=(Blog)session.selectOne("org.mybatis.example.BlogMapper.selectBlog",101);

更常⽤的⽅式是先获取Mapper(映射)，然后再执⾏SQL语句：

BlogMapper mapper=session.getMapper(BlogMapper.class);Blog blog=mapper.selectBlog(101);

- 4）调⽤session.commit()提交事务

如果是更新、删除语句，我们还需要提交一下事务。

- 5）调⽤session.close()关闭会话

最后一定要记得关闭会话。

### MyBatis⽣命周期？

上⾯提到了⼏个MyBatis的组件，⼀般说的MyBatis⽣命周期就是这些组件的⽣命周期。

- SqlSessionFactoryBuilder

⼀旦创建了 SqlSessionFactory，就不再需要它了。因此 SqlSessionFactoryBuilder 实例的⽣命周期只存在于方法的内部。

- SqlSessionFactory

SqlSessionFactory 是⽤来创建SqlSession的，相当于⼀个数据库连接池，每次创建 SqlSessionFactory都会使⽤数据库资源，多次创建和销毁是对资源的浪费。所以SqlSessionFactory 是应用级的生命周期，而且应该是单例的。

- SqlSession

SqlSession相当于JDBC中的Connection，SqlSession 的实例不是线程安全的，因此是不能被共享的，所以它的最佳的生命周期是一次请求或一个方法。

- Mapper

映射器是⼀些绑定映射语句的接⼜。映射器接⼜的实例是从 SqlSession 中获得的，它的⽣命周期在 sqlsession事务⽅法之内，⼀般会控制在⽅法级。

![](<面渣逆袭 MyBatis_assets/p008_48.png>)

当然，万物皆可集成Spring，MyBatis通常也是和Spring集成使⽤，Spring可以帮助我们创建线程安全的、基于事务的 SqlSession 和映射器，并将它们直接注⼊到我们的 bean 中，我们不需要关⼼它们的创建过程和生命周期，那就是另外的故事了。

![](<面渣逆袭 MyBatis_assets/p009_53.jpeg>)

## 4. 在 mapper 中如何传递多个参数？

![](<面渣逆袭 MyBatis_assets/p009_54.png>)

方法 1：顺序传参法

```sql
public User selectUser(String name,int deptId);
<select id="selectUser"resultMap="UserResultMap">
    select*from user
    where user_name=#{0}and dept_id=#{1}
</select>
```

- \#{} 里面的数字代表传入参数的顺序。

- 这种方法不建议使用， s q l 层表达不直观，且一旦顺序调整容易出错。

方法 2：@P a r a m 注解传参法

```sql
public User selectUser(@Param("userName")String name,int@Param("deptId")deptId);
<select id="selectUser"resultMap="UserResultMap">
    select*from user
    where user_name=#{userName}and dept_id=#{deptId}
</select>
```

- \#{} 里面的名称对应的是注解@P a r a m 括号里面修饰的名称。

- 这种方法在参数不多的情况还是比较直观的，（推荐使用）。

方法 3： M a p 传参法

```sql
public User selectUser(Map<String,Object>params);
<select id="selectUser"parameterType="java.util.Map"resultMap="UserResultMap">
    select*from user
    where user_name=#{userName}and dept_id=#{deptId}
</select>
```

- \#{}⾥⾯的名称对应的是Map⾥⾯的key名称。

- 这种方法适合传递多个参数，且参数易变能灵活传递的情况。

⽅法4：Java Bean传参法

```sql
public User selectUser(User user);
<select id="selectUser"parameterType="com.jourwon.pojo.User"
resultMap="UserResultMap">
    select*from user
    where user_name=#{userName}and dept_id=#{deptId}
</select>
```

- \#{} 里面的名称对应的是 U s e r 类里面的成员属性。

- 这种方法直观，需要建一个实体类，扩展不容易，需要加属性，但代码可读性强，业务逻辑处理方
  便，推荐使用。（推荐使用）。

## 5. 实体类属性名和表中字段名不一样，怎么办?

- 第 1 种： 通过在查询的 S Q L 语句中定义字段名的别名，让字段名的别名和实体类的属性名一致。

```sql
<select id="getOrder"parameterType="int"resultType="com.jourwon.pojo.Order">
       select order_id id,order_no orderno,order_price price form orders where order_id=#
{i d};
</select>
```

- 第2种：通过resultMap 中的<result>来映射字段名和实体类属性名的⼀⼀对应的关系。

```xml
<select id="getOrder"parameterType="int"resultMap="orderResultMap">
  select*from orders where order_id=#{id}
</select>
<resultMap type="com.jourwon.pojo.Order"id="orderResultMap">
    <!–用i d 属性来映射主键字段–>
    <id property="id"column="order_id">
    <!–⽤result属性来映射⾮主键字段，property为实体类属性名，column为数据库表中的属性–>
  <result property="orderno"column="order_no"/>
  <result property="price"column="order_price"/>
</reslutMap>
```

## 6. Mybatis 是否可以映射 Enum 枚举类？

- Mybatis当然可以映射枚举类，不单可以映射枚举类，Mybatis可以映射任何对象到表的⼀列上。
  映射⽅式为⾃定义⼀个TypeHandler，实现TypeHandler的setParameter()和getResult()接⼜⽅
  法。

- TypeHandler有两个作⽤，⼀是完成从javaType⾄jdbcType的转换，⼆是完成jdbcType⾄
  javaType的转换，体现为setParameter()和getResult()两个⽅法，分别代表设置sql问号占位符参

数和获取列查询结果。

## 7. #{}和${}的区别 ?

![](<面渣逆袭 MyBatis_assets/p012_64.png>)

- #{} 是占位符，预编译处理； ${} 是拼接符，字符串替换，没有预编译处理。

- Mybatis在处理#{} 时，#{} 传⼊参数是以字符串传⼊，会将SQL中的#{} 替换为?号，调⽤
  PreparedStatement的set⽅法来赋值。

- #{} 可以有效的防⽌SQL注⼊，提⾼系统安全性；${} 不能防⽌SQL 注⼊

- #{} 的变量替换是在DBMS 中；${} 的变量替换是在 DBMS 外

## 8. 模糊查询 like 语句该怎么写?

![](<面渣逆袭 MyBatis_assets/p012_65.png>)

- 1’%${question}%’ 可能引起SQL注⼊，不推荐

- 2"%"#{question}"%" 注意：因为#{…} 解析成sql语句时候，会在变量外侧⾃动加单引号’'，
  所以这里 % 需要使用双引号" "，不能使用单引号 ’ '，不然会查不到任何结果。

- 3 CONCAT(’%’,#{question},’%’) 使⽤CONCAT()函数，（推荐）

- 4 使用b i n d 标签（不推荐）

```sql
<select id="listUserLikeUsername"resultType="com.jourwon.pojo.User">
&emsp;&emsp;<bind name="pattern"value="'%'+username+'%'"/>
&emsp;&emsp;select id,sex,age,username,password from person where username LIKE#
{pattern}
</select>
```

## 9. Mybatis 能执行一对一、一对多的关联查询吗？

当然可以，不止支持一对一、一对多的关联查询，还支持多对多、多对一的关联查询。

![](<面渣逆袭 MyBatis_assets/p013_75.png>)

⼀对⼀<association>

比如订单和支付是一对一的关系，这种关联的实现：

实体类:

```java
public class Order{
    private Integer orderId;
    private String orderDesc;
    /**
     * 支付对象
     */
    private Pay pay;
    //……
}
```

结果映射

```xml
<!-- 订单resultMap-->
<resultMap id="peopleResultMap"type="cn.fighter3.entity.Order">
    <id property="orderId"column="order_id"/>
    <result property="orderDesc"column="order_desc"/>
    <!--一对一结果映射-->
    <association property="pay"javaType="cn.fighter3.entity.Pay">
        <id column="payId"property="pay_id"/>
        <result column="account"property="account"/>
    </association>
</resultMap>
```

查询就是普通的关联查

```xml
<select id="getTeacher"resultMap="getTeacherMap"parameterType="int">
    select*from order o
     left join pay p on o.order_id=p.order_id
    where o.order_id=#{orderId}
</select>
```

- ⼀对多<collection>

比如商品分类和商品，是一对多的关系。

- 实体类

```java
public class Category{
    private int categoryId;
    private String categoryName;
    /**
    * 商品列表
    **/
    List<Product>products;
    //……
}
```

- 结果映射

```xml
<resultMap type="Category"id="categoryBean">
    <id column="categoryId"property="category_id"/>
    <result column="categoryName"property="category_name"/>
    <!-- 一对多的关系 -->
    <!--property: 指的是集合属性的值,ofType：指的是集合中元素的类型 -->
    <collection property="products"ofType="Product">
        <id column="product_id"property="productId"/>
        <result column="productName"property="productName"/>
        <result column="price"property="price"/>
    </collection>
</resultMap>
```

- 查询

查询就是一个普通的关联查询

```xml
<!-- 关联查询分类和产品表 -->
<select id="listCategory"resultMap="categoryBean">
    select c.*,p.*from category_c left join product_p on c.id=p.cid
</select>
```

那么多对⼀、多对多怎么实现呢？还是利⽤\<association>和\<collection>，篇幅所限，这⾥就不展开了。

## 10. Mybatis 是否支持延迟加载？原理？

- Mybatis⽀持association关联对象和collection关联集合对象的延迟加载，association指的就是
  ⼀对⼀，collection指的就是⼀对多查询。在Mybatis配置⽂件中，可以配置是否启⽤延迟加载
  lazyLoadingEnabled=true|false。

- 它的原理是，使用C G L I B 创建目标对象的代理对象，当调用目标方法时，进入拦截器方法，比如
  调⽤a.getB().getName()，拦截器invoke()⽅法发现a.getB()是null值，那么就会单独发送事先保
  存好的查询关联B对象的sql，把B查询上来，然后调⽤a.setB(b)，于是a的对象b属性就有值了，
  接着完成a.getB().getName()⽅法的调⽤。这就是延迟加载的基本原理。

- 当然了，不光是Mybatis，⼏乎所有的包括Hibernate，⽀持延迟加载的原理都是⼀样的。

## 11. 如何获取生成的主键?

- 新增标签中添加：keyProperty="ID" 即可

```xml
<insert id="insert"useGeneratedKeys="true"keyProperty="userId">
    insert into user(
    user_name,user_password,create_time)
    values(#{userName},#{userPassword},#{createTime,jdbcType=TIMESTAMP})
</insert>
```

- 这时候就可以完成回填主键

mapper.insert(user);user.getId;

## 12. MyBatis支持动态 SQL 吗？

MyBatis中有⼀些⽀持动态SQL的标签，它们的原理是使⽤OGNL从SQL参数对象中计算表达式的值，根据表达式的值动态拼接SQL，以此来完成动态SQL的功能。

![](<面渣逆袭 MyBatis_assets/p016_87.png>)

- i f

根据条件来组成 w h e r e子句

```xml
<select id="findActiveBlogWithTitleLike"
   resultType="Blog">
SELECT*FROM BLOG
WHERE state=‘ACTIVE’
<if test="title!=null">
  AND title like#{title}
</i f>
</select>
```

- choose(when,otherwise)

这个和Java 中的 switch 语句有点像

```xml
<select id="findActiveBlogLike"
   resultType="Blog">
SELECT*FROM BLOG WHERE state=‘ACTIVE’
<choose>
  <when test="title!=null">
    AND title like#{title}
  </w h e n>
  <when test="author!=null and author.name!=null">
    AND author_name like#{author.name}
  </w h e n>
  <otherwise>
    AND featured=1
  </otherwise>
</choose>
</select>
```

- trim(where,set)

- <w h e r e>可以用在所有的查询条件都是动态的情况

```xml
<select id="findActiveBlogLike"
   resultType="Blog">
SELECT*FROM BLOG
<w h e r e>
  <if test="state!=null">
       state=#{state}
  </i f>
  <if test="title!=null">
      AND title like#{title}
  </i f>
  <if test="author!=null and author.name!=null">
      AND author_name like#{author.name}
  </i f>
</w h e r e>
</select>
```

- <s e t> 可以用在动态更新的时候

```xml
<update id="updateAuthorIfNecessary">
  update Author
    <s e t>
      <if test="username!=null">username=#{username},</if>
      <if test="password!=null">password=#{password},</if>
      <if test="email!=null">email=#{email},</if>
      <if test="bio!=null">bio=#{bio}</if>
    </s e t>
  where id=#{id}
</update>
```

- foreach
  看到名字就知道了，这个是用来循环的，可以对集合进行遍历

```xml
<select id="selectPostIn"resultType="domain.blog.Post">
SELECT*
FROM POST P
<w h e r e>
  <foreach item="item"index="index"collection="list"
      open="ID in("separator=","close=")"nullable="true">
        #{i t e m}
  </foreach>
</w h e r e>
</select>
```

## 13. MyBatis 如何执行批量操作？

![](<面渣逆袭 MyBatis_assets/p019_98.png>)

第一种方法：使用f o re a c h 标签

foreach的主要⽤在构建in条件中，它可以在SQL语句中进⾏迭代⼀个集合。foreach标签的属性主要有item，index，collection，open，separator，close。

- i t e m      表示集合中每一个元素进行迭代时的别名，随便起的变量名；

- i n d e x    指定一个名字，用于表示在迭代过程中，每次迭代到的位置，不常用；

- o p e n    表示该语句以什么开始，常用“(”；

- separator 表⽰在每次进⾏迭代之间以什么符号作为分隔符，常⽤“,”；

- c l o s e    表示以什么结束，常用“)”。

在使⽤foreach的时候最关键的也是最容易出错的就是collection属性，该属性是必须指定的，但是在不同情况下，该属性的值是不一样的，主要有以下 3 种情况：

```
1. 如果传⼊的是单参数且参数类型是⼀个List的时候，collection属性值为list
2. 如果传⼊的是单参数且参数类型是⼀个array数组的时候，collection的属性值为array
3. 如果传入的参数是多个的时候，我们就需要把它们封装成一个 M a p 了，当然单参数也可以封装成
   map，实际上如果你在传⼊参数的时候，在MyBatis⾥⾯也是会把它封装成⼀个Map的，map的
   key就是参数名，所以这个时候collection属性值就是传⼊的List或array对象在⾃⼰封装的map
   里面的 k e y
```

看看批量保存的两种用法：

```xml
<!--MySQL下批量保存，可以foreach遍历 mysql⽀持values(),(),()语法 -->//推荐使⽤
<insert id="addEmpsBatch">
    INSERT INTO emp(ename,gender,email,did)
    VA L U E S
    <foreach collection="emps"item="emp"separator=",">
        (#{emp.eName},#{emp.gender},#{emp.email},#{emp.dept.id})
    </foreach>
</insert>
<!-- 这种⽅式需要数据库连接属性allowMutiQueries=true的⽀持
 如jdbc.url=jdbc:mysql://localhost:3306/mybatis?allowMultiQueries=true-->
<insert id="addEmpsBatch">
    <foreach collection="emps"item="emp"separator=";">
        INSERT INTO emp(ename,gender,email,did)
        VALUES(#{emp.eName},#{emp.gender},#{emp.email},#{emp.dept.id})
    </foreach>
</insert>
```

第⼆种⽅法：使⽤ExecutorType.BATCH

Mybatis内置的ExecutorType有3种，默认为simple，该模式下它为每个语句的执⾏创建⼀个新的预处理语句，单条提交sql；⽽batch模式重复使⽤已经预处理的语句，并且批量执⾏所有更新语句，显然batch性能将更优；但batch模式也有⾃⼰的问题，⽐如在Insert操作时，在事务没有提交之前，是没有办法获取到自增的 i d，在某些情况下不符合业务的需求。

具体用法如下：

```java
// 批量保存方法测试
@Te s t
public void testBatch()throws IOException{
    SqlSessionFactory sqlSessionFactory=getSqlSessionFactory();
    //可以执⾏批量操作的sqlSession
    SqlSession openSession=sqlSessionFactory.openSession(ExecutorType.BATCH);
    // 批量保存执行前时间
    long start=System.currentTimeMillis();
    t r y {
        EmployeeMapper mapper=openSession.getMapper(EmployeeMapper.class);
        for(int i=0;i<1000;i++){
            mapper.addEmp(new Employee(UUID.randomUUID().toString().substring(0,5),"b",
"1"));
        }
        openSession.commit();
        long end=System.currentTimeMillis();
        // 批量保存执行后的时间
        System.out.println("执⾏时长"+(end-start));
        // 批量 预编译s q l 一次== 》设置参数== 》1 0 0 0 0 次== 》执行1 次   6 7 7
        // 非批量  （预编译= 设置参数= 执行 ）== 》1 0 0 0 0 次   11 2 1
    }finally{
        openSession.close();
    }
}
```

mapper和mapper.xml如下

```java
public interface EmployeeMapper{
    // 批量保存员工
    Long addEmp(Employee employee);
}
<mapper namespace="com.jourwon.mapper.EmployeeMapper"
     <!--批量保存员工 -->
    <insert id="addEmp">
        insert into employee(lastName,email,gender)
        values(#{lastName},#{email},#{gender})
    </insert>
</mapper>
```

## 14. 说说 Mybatis 的一级、二级缓存？

```
1.⼀级缓存: 基于 PerpetualCache 的 HashMap 本地缓存，其存储作⽤域为SqlSession，各个
   SqlSession之间的缓存相互隔离，当 Session flush 或 close 之后，该 SqlSession 中的所有
   Cache 就将清空，MyBatis默认打开⼀级缓存。
```

![](<面渣逆袭 MyBatis_assets/p022_110.png>)

```
2.⼆级缓存与⼀级缓存其机制相同，默认也是采⽤PerpetualCache，HashMap 存储，不同之处在
   于其存储作⽤域为 Mapper(Namespace)，可以在多个SqlSession之间共享，并且可⾃定义存储
   源，如 Ehcache。默认不打开⼆级缓存，要开启⼆级缓存，使⽤⼆级缓存属性类需要实现
   Serializable序列化接⼜(可⽤来保存对象的状态),可在它的映射⽂件中配置。
```

![](<面渣逆袭 MyBatis_assets/p022_111.png>)

![](<面渣逆袭 MyBatis_assets/p023_115.png>)

# 原理

## 15. 能说说 MyBatis 的工作原理吗？

我们已经⼤概知道了MyBatis的⼯作流程，按⼯作原理，可以分为两⼤步：⽣成会话⼯⼚、会话运行。

![](<面渣逆袭 MyBatis_assets/p023_116.png>)

MyBatis是⼀个成熟的框架，篇幅限制，这⾥抓⼤放⼩，来看看它的主要⼯作流程。

### 构建会话工厂

构造会话工厂也可以分为两步：

![](<面渣逆袭 MyBatis_assets/p024_120.png>)

- 获取配置

获取配置这⼀步经过了⼏步转化，最终由⽣成了⼀个配置类Configuration实例，这个配置类实例⾮常重要，主要作用包括：

- 读取配置文件，包括基础配置文件和映射文件

- 初始化基础配置，⽐如MyBatis的别名，还有其它的⼀些重要的类对象，像插件、映射器、
  ObjectFactory等等

- 提供一个单例，作为会话工厂构建的重要参数

- 它的构建过程也会初始化一些环境变量，比如数据源

```
public SqlSessionFactory build(Reader reader,String environment,Properties properties){
      SqlSessionFactory var5;
      // 省略异常处理
          //x m l 配置构建器
          XMLConfigBuilder parser=new XMLConfigBuilder(reader,environment,properties);
          //通过转化的Configuration构建SqlSessionFactory
          var5=this.build(parser.parse());
}
```

构建SqlSessionFactory

SqlSessionFactory只是⼀个接⼜，构建出来的实际上是它的实现类的实例，⼀般我们⽤的都是它的实现类DefaultSqlSessionFactory，

public SqlSessionFactory build(Configuration config){return new DefaultSqlSessionFactory(config);}

### 会话运行

会话运⾏是MyBatis最复杂的部分，它的运⾏离不开四⼤组件的配合：

![](<面渣逆袭 MyBatis_assets/p025_125.png>)

- Executor（执⾏器）

Executor起到了⾄关重要的作⽤，SqlSession只是⼀个门⾯，相当于客服，真正⼲活的是是 Executor，就像是默默⽆闻的⼯程师。它提供了相应的查询和更新⽅法，以及事务⽅法。

```
Environment environment=this.configuration.getEnvironment();
TransactionFactory transactionFactory=
this.getTransactionFactoryFromEnvironment(environment);
tx=transactionFactory.newTransaction(environment.getDataSource(),level,autoCommit);
//通过Configuration创建executor
Executor executor=this.configuration.newExecutor(tx,execType);
var8=new DefaultSqlSession(this.configuration,executor,autoCommit);
```

- StatementHandler（数据库会话器）

StatementHandler，顾名思义，处理数据库会话的。我们以SimpleExecutor为例，看⼀下它的查询⽅法，先⽣成了⼀个StatementHandler实例，再拿这个handler去执⾏query。

```
 public<E>List<E>doQuery(MappedStatement ms,Object parameter,RowBounds
rowBounds,ResultHandler resultHandler,BoundSql boundSql)throws SQLException{
    Statement stmt=null;
    List var9;
    t r y {
        Configuration configuration=ms.getConfiguration();
        StatementHandler handler=configuration.newStatementHandler(this.wrapper,ms,
parameter,rowBounds,resultHandler,boundSql);
        stmt=this.prepareStatement(handler,ms.getStatementLog());
        var9=handler.query(stmt,resultHandler);
    }finally{
        this.closeStatement(stmt);
    }
    return var9;
}
```

再以最常⽤的PreparedStatementHandler看⼀下它的query⽅法，其实在上⾯的prepareStatement 已经对参数进⾏了预编译处理，到了这⾥，就直接执⾏sql，使⽤ResultHandler处理返回结果。

```
public<E>List<E>query(Statement statement,ResultHandler resultHandler)throws
SQLException{
    PreparedStatement ps=(PreparedStatement)statement;
    ps.execute();
    return this.resultSetHandler.handleResultSets(ps);
}
```

- ParameterHandler （参数处理器）

PreparedStatementHandler⾥对sql进⾏了预编译处理

public void parameterize(Statement statement)throws SQLException{this.parameterHandler.setParameters((PreparedStatement)statement);}

这⾥⽤的就是ParameterHandler，setParameters的作⽤就是设置预编译SQL语句的参数。

⾥⾯还会⽤到typeHandler类型处理器，对类型进⾏处理。

```java
public interface ParameterHandler{
    Object getParameterObject();
    void setParameters(PreparedStatement var1)throws SQLException;
}
```

- ResultSetHandler（结果处理器）

我们前⾯也看到了，最后的结果要通过ResultSetHandler来进⾏处理，handleResultSets这个⽅法就是⽤来包装结果集的。Mybatis为我们提供了⼀个DefaultResultSetHandler，通常都是⽤这个实现类去进行结果的处理的。

```java
public interface ResultSetHandler{
  <E>List<E>handleResultSets(Statement var1)throws SQLException;
  <E>Cursor<E>handleCursorResultSets(Statement var1)throws SQLException;
  void handleOutputParameters(CallableStatement var1)throws SQLException;
}
```

它会使⽤typeHandle处理类型，然后⽤ObjectFactory提供的规则组装对象，返回给调⽤者。

整体上总结一下会话运行：

![](<面渣逆袭 MyBatis_assets/p028_135.png>)

我们最后把整个的工作流程串联起来，简单总结一下：

![](<面渣逆袭 MyBatis_assets/p029_139.png>)

```
1. 读取 MyBatis 配置⽂件——mybatis-config.xml 、加载映射⽂件——映射⽂件即 SQL 映射⽂
   件，文件中配置了操作数据库的 S Q L 语句。最后生成一个配置对象。
2. 构造会话⼯⼚：通过 MyBatis 的环境等配置信息构建会话⼯⼚SqlSessionFactory。
3. 创建会话对象：由会话⼯⼚创建 SqlSession 对象，该对象中包含了执⾏SQL 语句的所有⽅法。
4.Executor 执⾏器：MyBatis 底层定义了⼀个 Executor 接⼜来操作数据库，它将根据
   SqlSession 传递的参数动态地⽣成需要执⾏的 SQL 语句，同时负责查询缓存的维护。
5.StatementHandler：数据库会话器，串联起参数映射的处理和运⾏结果映射的处理。
6. 参数处理：对输入参数的类型进行处理，并预编译。
7. 结果处理：对返回结果的类型进行处理，根据对象映射规则，返回相应的对象。
```

## 16. MyBatis 的功能架构是什么样的？

![](<面渣逆袭 MyBatis_assets/p030_143.png>)

我们⼀般把Mybatis的功能架构分为三层：

- API接⼜层：提供给外部使⽤的接⼜API，开发⼈员通过这些本地API来操纵数据库。接⼜层⼀接
  收到调用请求就会调用数据处理层来完成具体的数据处理。

- 数据处理层：负责具体的SQL查找、SQL解析、SQL执⾏和执⾏结果映射处理等。它主要的⽬的
  是根据调用的请求完成一次数据库操作。

- 基础支撑层：负责最基础的功能支撑，包括连接管理、事务管理、配置加载和缓存处理，这些都是
  共用的东西，将他们抽取出来作为最基础的组件。为上层的数据处理层提供最基础的支撑。

## 17. 为什么 Mapper 接又不需要实现类？

四个字回答：动态代理，我们来看⼀下获取Mapper的过程：

![](<面渣逆袭 MyBatis_assets/p031_147.png>)

获取Mapper

我们都知道定义的Mapper接⼜是没有实现类的，Mapper映射其实是通过动态代理实现的。

BlogMapper mapper=session.getMapper(BlogMapper.class);

七拐⼋绕地进去看⼀下，发现获取Mapper的过程，需要先获取MapperProxyFactory——Mapper代理工厂。

```
public<T>T getMapper(Class<T>type,SqlSession sqlSession){
    MapperProxyFactory<T>mapperProxyFactory=
(MapperProxyFactory)this.knownMappers.get(type);
    if(mapperProxyFactory==null){
        throw new BindingException("Type"+type+"is not known to the MapperRegistry.");
    } e l s e {
        t r y {
            return mapperProxyFactory.newInstance(sqlSession);
        }catch(Exception var5){
            throw new BindingException("Error getting mapper instance.Cause:"+var5,
v a r 5);
        }
    }
}
```

- MapperProxyFactory

MapperProxyFactory的作⽤是⽣成MapperProxy（Mapper代理对象）。

```java
public class MapperProxyFactory<T>{
  private final Class<T>mapperInterface;
  ……
  protected T newInstance(MapperProxy<T>mapperProxy){
      return Proxy.newProxyInstance(this.mapperInterface.getClassLoader(),new Class[]
{this.mapperInterface},mapperProxy);
  }
  public T newInstance(SqlSession sqlSession){
      MapperProxy<T>mapperProxy=new MapperProxy(sqlSession,this.mapperInterface,
this.methodCache);
      return this.newInstance(mapperProxy);
  }
}
```

这里可以看到动态代理对接又的绑定，它的作用就是生成动态代理对象（占位），而代理的方法被放到了MapperProxy中。

- MapperProxy

MapperProxy⾥，通常会⽣成⼀个MapperMethod对象，它是通过cachedMapperMethod⽅法对其进⾏初始化的，然后执⾏excute⽅法。

```
public Object invoke(Object proxy,Method method,Object[]args)throws Throwable{
    t r y {
        return Object.class.equals(method.getDeclaringClass())?method.invoke(this,args):
this.cachedInvoker(method).invoke(proxy,method,args,this.sqlSession);
    }catch(Throwable var5){
        throw ExceptionUtil.unwrapThrowable(var5);
    }
}
```

MapperMethod

MapperMethod⾥的excute⽅法，会真正去执⾏sql。这⾥⽤到了命令模式，其实绕⼀圈，最终它还是通过SqlSession的实例去运⾏对象的sql。

```sql
public Object execute(SqlSession sqlSession,Object[]args){
      Object result;
      Object param;
      ……
      case SELECT:
          if(this.method.returnsVoid()&&this.method.hasResultHandler()){
              this.executeWithResultHandler(sqlSession,args);
              result=null;
          }else if(this.method.returnsMany()){
              result=this.executeForMany(sqlSession,args);
          }else if(this.method.returnsMap()){
              result=this.executeForMap(sqlSession,args);
          }else if(this.method.returnsCursor()){
              result=this.executeForCursor(sqlSession,args);
          } e l s e {
              param=this.method.convertArgsToSqlCommandParam(args);
              result=sqlSession.selectOne(this.command.getName(),param);
              if(this.method.returnsOptional()&&(result==null||
!this.method.getReturnType().equals(result.getClass()))){
                  result=Optional.ofNullable(result);
              }
          }
          b r e a k;
         ……
  }
```

## 18.Mybatis 都有哪些 Executor 执行器？

![](<面渣逆袭 MyBatis_assets/p034_158.png>)

Mybatis有三种基本的Executor执⾏器，SimpleExecutor、ReuseExecutor、BatchExecutor。

- SimpleExecutor：每执⾏⼀次update或select，就开启⼀个Statement对象，⽤完⽴刻关闭
  Statement对象。

- ReuseExecutor：执⾏update或select，以sql作为key查找Statement对象，存在就使⽤，不存在
  就创建，⽤完后，不关闭Statement对象，⽽是放置于Map<String,Statement>内，供下⼀次使
  ⽤。简⾔之，就是重复使⽤Statement对象。

- BatchExecutor：执⾏update（没有select，JDBC批处理不⽀持select），将所有sql都添加到批
  处理中（addBatch()），等待统⼀执⾏（executeBatch()），它缓存了多个Statement对象，每个
  Statement对象都是addBatch()完毕后，等待逐⼀执⾏executeBatch()批处理。与JDBC批处理相
  同。

作⽤范围：Executor的这些特点，都严格限制在SqlSession⽣命周期范围内。

### Mybatis中如何指定使⽤哪⼀种Executor执⾏器？

- 在Mybatis配置⽂件中，在设置（settings）可以指定默认的ExecutorType执⾏器类型，也可以⼿
  动给DefaultSqlSessionFactory的创建SqlSession的⽅法传递ExecutorType类型参数，如
  SqlSession openSession(ExecutorType execType)。

- 配置默认的执⾏器。SIMPLE 就是普通的执⾏器；REUSE 执⾏器会重⽤预处理语句（prepared
  statements）； BATCH 执⾏器将重⽤语句并执⾏批量更新。

# 插件

## 19. 说说 Mybatis 的插件运行原理，如何编写一个插件？

### 插件的运行原理？

Mybatis会话的运⾏需要ParameterHandler、ResultSetHandler、StatementHandler、Executor这四大对象的配合，插件的原理就是在这四大对象调度的时候，插入一些我我们自己的代码。

![](<面渣逆袭 MyBatis_assets/p036_165.png>)

Mybatis使⽤JDK的动态代理，为⽬标对象⽣成代理对象。它提供了⼀个⼯具类Plugin，实现了 InvocationHandler 接⼜。

![](<面渣逆袭 MyBatis_assets/p036_166.png>)

使⽤Plugin⽣成代理对象，代理对象在调⽤⽅法的时候，就会进⼊invoke⽅法，在invoke⽅法中，如果存在签名的拦截⽅法，插件的intercept⽅法就会在这⾥被我们调⽤，然后就返回结果。如果不存在签名方法，那么将直接反射调用我们要执行的方法。

### 如何编写一个插件？

我们⾃⼰编写MyBatis 插件，只需要实现拦截器接⼜Interceptor(org.apache.ibatis.plugin Interceptor），在实现类中对拦截对象和⽅法进⾏处理。

- 实现Mybatis的Interceptor接⼜并重写intercept()⽅法

这里我们只是在目标对象执行目标方法的前后进行了打印；

```java
public class MyInterceptor implements Interceptor{
    Properties props=null;
    @Override
    public Object intercept(Invocation invocation)throws Throwable{
        System.out.println("before……");
        // 如果当前代理的是一个非代理对象，那么就会调用真实拦截对象的方法
        // 如果不是它就会调⽤下个插件代理对象的invoke⽅法
        Object obj=invocation.proceed();
        System.out.println("after……");
        return obj;
    }
}
```

- 然后再给插件编写注解，确定要拦截的对象，要拦截的方法

```java
@Intercepts({@Signature(
        type=Executor.class,//确定要拦截的对象
        method="update",//确定要拦截的⽅法
        args={MappedStatement.class,Object.class}//拦截⽅法的参数
)})
public class MyInterceptor implements Interceptor{
    Properties props=null;
    @Override
    public Object intercept(Invocation invocation)throws Throwable{
        System.out.println("before……");
        // 如果当前代理的是一个非代理对象，那么就会调用真实拦截对象的方法
        // 如果不是它就会调⽤下个插件代理对象的invoke⽅法
        Object obj=invocation.proceed();
        System.out.println("after……");
        return obj;
    }
}
```

- 最后，再MyBatis配置⽂件⾥⾯配置插件

```xml
<plugins>
    <plugin interceptor="xxx.MyPlugin">
       <property name="dbType",value="mysql"/>
    </plugin>
</plugins>
```

## 20. MyBatis 是如何进行分页的？分页插件的原理是什么？

### MyBatis是如何分页的？

MyBatis使⽤RowBounds对象进⾏分页，它是针对ResultSet结果集执⾏的内存分页，⽽⾮物理分页。可以在 s q l 内直接书写带有物理分页的参数来完成物理分页功能，也可以使用分页插件来完成物理分页。

### 分页插件的原理是什么？

- 分页插件的基本原理是使⽤Mybatis提供的插件接⼜，实现⾃定义插件，拦截Executor的query⽅
  法

- 在执⾏查询的时候，拦截待执⾏的sql，然后重写sql，根据dialect⽅⾔，添加对应的物理分页语
  句和物理分页参数。

- 举例：select*from student，拦截sql后重写为：select t.*from(select*from student)t

l i m i t 0, 1 0

可以看⼀下⼀个⼤概的MyBatis通⽤分页拦截器：

![](<面渣逆袭 MyBatis_assets/p038_173.png>)

没有什么使我停留—— 除了目的，纵然岸旁有玫瑰、有绿荫、有宁静的港湾，我是不系之舟。

系列内容：

- ⾯渣逆袭 Java SE 篇"
  "

- 面渣逆袭 J a v a 集合框架篇
  "

- 面渣逆袭 J a v a 并发编程篇
  "

- 面渣逆袭 J V M 篇
  "

- ⾯渣逆袭 Spring 篇"
  "

- 面渣逆袭 R e d i s 篇
  "

- ⾯渣逆袭 MyBatis 篇"
  "

- 面渣逆袭 M y S Q L 篇
  "

- 面渣逆袭操作系统篇
  "

- 面渣逆袭计算机网络篇
  "

图⽂详解 20 道MyBatis⾯试⾼频题，这次吊打⾯试官，我觉得稳了（⼿动 dog）。整理：沉默王二，戳转载链接，作者：三分恶，戳原文链接。
