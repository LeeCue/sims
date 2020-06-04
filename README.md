## 前言
&emsp;&emsp;学生信息管理系统（后端部分），采用前后端分离式开发，采用现阶段流行技术实现。

- - -

## 技术选型

&emsp;&emsp;后端部分：

- SpringBoot，作为整个管理容器
- SpringSecurity，认证和授权框架
- MyBatis，ORM框架
- PageHelper，分页插件
- Hibernate-Validator，验证框架
- ActiveMQ，消息队列
- Redis，分布式缓存
- Druid，数据库连接池
- FastJson，json序列化方式
- easyexcel，操作excel
- Lombok，简化pojo对象
- OSS，对象云存储，采用腾讯云对象存储

---

## 项目结构

```
├─main
│  ├─java
│  │  └─com
│  │      └─xust
│  │          └─sims
│  │              ├─dao -- 数据访问层
│  │              ├─dto -- 数据转换对象，一般为不能和数据库表直接建立联系的对象
│  │              ├─entity -- 实体对象，一般为能直接和数据库表建立联系的对象
│  │              ├─exceldatalistener -- 处理excel表相关的实体类
│  │              ├─receiver -- 中间件相关的配置和服务
│  │              ├─serialize -- 序列化方式
│  │              ├─service -- 业务逻辑层
│  │              ├─utils -- 工具类
│  │              └─web -- 与web相关
│  │                  ├─aspect -- 切面配置
│  │                  ├─config -- 配置类
│  │                  ├─controller -- 控制层
│  │                  └─exception -- 自定义异常
│  └─resources
│      ├─mapper -- MyBatis对应的xml文件，要和一个接口共同组成一个映射器
│      ├─static -- 静态资源
│      └─templates -- 模板
└─test -- 测试对应的实体类
    └─java
        └─com
            └─xust
                └─sims
                    ├─dao
                    └─service
```

