# Chemistry Learning Project

一个基于Spring Cloud的化学学习项目，用于学习和管理化学相关知识。

## 项目结构

```
chemistry-learning/
├── eureka-server/           # 服务注册与发现模块
├── api-gateway/             # API网关模块
├── chemistry-service/       # 化学数据服务模块
├── user-service/            # 用户服务模块
├── learning-progress-service/ # 学习进度服务模块
├── data-source-service/     # 数据源管理服务模块
├── harbor/                  # Harbor私有镜像仓库配置
├── Dockerfile               # 根目录Dockerfile
├── docker-compose.yml       # Docker Compose配置
├── docker-build.bat         # Docker一键打包脚本
├── build.bat                # Maven构建脚本
├── start-services.bat       # 启动脚本
├── start-services.ps1       # PowerShell启动脚本
├── stop-services.bat        # 停止脚本
├── cleanup-daily.bat        # 每天清理Docker资源脚本
└── README.md                # 项目说明
```

## 技术栈

- Java 21
- Spring Boot 2.5.4
- Spring Cloud 2020.0.3
- Spring Cloud Netflix Eureka (服务注册与发现)
- Spring Cloud Gateway (API网关)
- Spring Data JPA (数据访问)
- H2 Database (内存数据库)
- MySQL Database (关系型数据库)
- Spring Security (安全认证)
- RabbitMQ (消息队列)
- Docker & Docker Compose (容器化部署)
- Harbor (私有镜像仓库)
- Bootstrap 5 (前端框架)
- CSS3 & JavaScript (前端开发)
- HTML5 & CSS3 Animations (前端动画效果)

## 服务说明

1. **eureka-server**：服务注册与发现中心，运行在端口8761，支持优雅下线功能
2. **api-gateway**：API网关，运行在端口8080，负责路由请求和前端静态资源服务
3. **chemistry-service**：化学数据服务，运行在端口8081，提供元素等化学数据
4. **user-service**：用户服务，运行在端口8082，提供用户管理功能，集成RabbitMQ消息队列
5. **learning-progress-service**：学习进度服务，运行在端口8085，跟踪用户学习进度
6. **data-source-service**：数据源管理服务，运行在端口8086，控制数据源切换和管理
7. **rabbitmq**：消息队列服务，运行在端口5672（AMQP）、15672（管理界面）
8. **harbor**：私有镜像仓库，运行在端口8081（Web）、5000（Registry）

## 快速开始

### 1. 构建项目

#### 1.1 Maven构建

运行`build.bat`脚本构建整个项目：

```bash
./build.bat
```

#### 1.2 Docker打包

运行`docker-build.bat`脚本一键构建Docker镜像：

```bash
./docker-build.bat
```

### 2. 启动服务

#### 2.1 本地启动

运行`start-services.bat`或`start-services.ps1`脚本启动所有服务：

```bash
./start-services.bat
# 或
./start-services.ps1
```

服务将按照以下顺序启动：
1. Eureka Server
2. API Gateway
3. Chemistry Service
4. User Service
5. Learning Progress Service
6. Data Source Service

#### 2.2 Docker启动

使用Docker Compose启动所有服务：

```bash
docker-compose up -d
```

#### 2.3 Harbor启动

运行`harbor/start-harbor.bat`脚本启动Harbor私有镜像仓库：

```bash
./harbor/start-harbor.bat
```

### 3. 访问服务

#### 3.1 本地服务

- Eureka Server: http://localhost:8761
- API Gateway (前端): http://localhost:8080
- Chemistry Service: http://localhost:8081
- User Service: http://localhost:8082
- Learning Progress Service: http://localhost:8085
- Data Source Service: http://localhost:8086
- RabbitMQ管理界面: http://localhost:15672 (默认用户名: guest, 密码: guest)
- Harbor Web界面: http://localhost:8081 (Harbor)

#### 3.2 Docker服务

- Eureka Server: http://localhost:8761
- API Gateway (前端): http://localhost:8080
- Chemistry Service: http://localhost:8081
- User Service: http://localhost:8082
- Learning Progress Service: http://localhost:8085
- Data Source Service: http://localhost:8086
- RabbitMQ管理界面: http://localhost:15672 (默认用户名: guest, 密码: guest)
- Harbor Web界面: http://localhost:8081 (Harbor)

### 4. API接口

#### 化学数据服务 (chemistry-service)
- GET /elements - 获取所有元素
- GET /elements/{id} - 根据ID获取元素
- GET /elements/symbol/{symbol} - 根据符号获取元素
- GET /elements/name/{name} - 根据名称获取元素
- POST /elements - 创建新元素
- PUT /elements/{id} - 更新元素
- DELETE /elements/{id} - 删除元素

#### 用户服务 (user-service)
- GET /users - 获取所有用户
- GET /users/{id} - 根据ID获取用户
- GET /users/username/{username} - 根据用户名获取用户
- GET /users/email/{email} - 根据邮箱获取用户
- POST /users - 创建新用户
- PUT /users/{id} - 更新用户
- DELETE /users/{id} - 删除用户
- POST /send-sms-code - 发送短信验证码
- POST /send-email - 发送邮件

#### 数据源服务 (data-source-service)
- GET /api/datasource/health - 获取所有数据源的健康状态
- GET /api/datasource/current - 获取当前使用的数据源
- GET /api/datasource/status - 检查数据源服务是否可用

#### 学习进度服务 (learning-progress-service)
- GET /progress - 获取所有学习进度
- GET /progress/{id} - 根据ID获取学习进度
- GET /progress/user/{userId} - 获取用户的所有学习进度
- GET /progress/user/{userId}/topic/{topic} - 获取用户特定主题的学习进度
- GET /progress/user/{userId}/completed - 获取用户已完成的学习进度
- GET /progress/user/{userId}/incomplete - 获取用户未完成的学习进度
- POST /progress - 创建或更新学习进度
- PUT /progress/{id} - 更新学习进度
- DELETE /progress/{id} - 删除学习进度

### 5. 默认数据

#### 化学数据服务
- 氢 (H)
- 氧 (O)
- 碳 (C)
- 钠 (Na)
- 氯 (Cl)

#### 用户服务
- 管理员用户：用户名 `admin`，密码 `admin123`
- 普通用户：用户名 `user`，密码 `user123`

#### 学习进度服务
- 管理员用户：元素周期表 (100%)，化学反应 (75%)
- 普通用户：元素周期表 (50%)，化学键 (30%)

## 新功能说明

### 1. 首页导航菜单

项目首页添加了美观的化学主题导航菜单，包含以下分类：

- **元素世界**：元素周期表、金属元素、非金属元素、稀有气体
- **化学反应**：基本反应类型、氧化还原反应、酸碱反应、配位反应
- **化学分支**：有机化学、无机化学、分析化学、物理化学
- **应用化学**：环境化学、医药化学、材料化学、能源化学
- **学习资源**：各类学习资料和工具
- **登录/注册**：用户认证入口

### 2. 元素周期表模块

项目添加了完整的元素周期表模块，并进行了优化：

#### 2.1 功能特点

- **完整展示**：包含所有元素的周期表展示
- **分类颜色**：不同类型元素使用不同颜色标识
- **自然/合成元素标识**：区分自然存在和人工合成的元素
- **CSS3动画**：鼠标悬停时元素卡片炫酷放大效果
- **响应式设计**：适配不同屏幕尺寸
- **详细信息**：点击元素查看详细信息
- **化学分类**：金属、非金属、稀有气体等分类展示
- **多页面跳转**：分解为三个页面：元素发现历史、分类、详情页

#### 2.2 访问方式

- **导航菜单**：点击首页导航菜单 -> 元素世界 -> 元素周期表
- **直接访问**：http://localhost:8080/periodic-table.html

#### 2.3 技术实现

- **前端**：HTML5 + CSS3 + JavaScript
- **布局**：CSS Grid实现周期表布局
- **样式**：Bootstrap 5响应式设计
- **动画**：CSS3 Transitions和Transforms实现悬停效果
- **数据**：JavaScript动态生成元素数据

### 3. RabbitMQ消息队列集成

项目集成了RabbitMQ消息队列，用于处理异步消息：

#### 3.1 功能特点

- **异步消息处理**：支持短信验证码和邮件发送
- **队列管理**：配置了专门的短信和邮件队列
- **交换机和绑定**：使用Topic Exchange实现消息路由
- **生产者/消费者模式**：标准的消息队列设计模式

#### 3.2 访问方式

- **发送短信验证码**：`POST http://localhost:8082/send-sms-code?phone={手机号}`
- **发送邮件**：`POST http://localhost:8082/send-email`
- **RabbitMQ管理界面**：http://localhost:15672 (默认用户名: guest, 密码: guest)

### 4. 数据库配置变更

项目修改了数据库配置，支持MySQL和H2数据库的切换：

#### 4.1 功能特点

- **统一配置**：使用`spring.cloud.data`前缀统一管理JDBC连接参数
- **多数据源支持**：支持MySQL和H2数据库的切换
- **动态配置**：通过配置文件控制数据源的选择

#### 4.2 配置参数

- `spring.cloud.data.url`：数据库连接URL
- `spring.cloud.data.driver`：数据库驱动类
- `spring.cloud.data.user`：数据库用户名
- `spring.cloud.data.password`：数据库密码
- `spring.cloud.data.dialect`：数据库方言

### 5. 数据源服务

项目添加了独立的数据源管理服务：

#### 5.1 功能特点

- **集中控制**：集中管理所有服务的数据源配置
- **多数据源支持**：配置了primary、secondary和h2数据源
- **自动切换**：当MySQL不可用时，自动切换到H2数据库
- **健康检查**：定期检查数据源的健康状态
- **API接口**：提供REST API接口查询数据源状态

#### 5.2 访问方式

- **服务地址**：http://localhost:8086
- **健康状态**：http://localhost:8086/api/datasource/health
- **当前数据源**：http://localhost:8086/api/datasource/current
- **服务状态**：http://localhost:8086/api/datasource/status

### 6. Eureka优雅下线功能

项目为所有服务添加了Eureka优雅下线功能：

#### 6.1 功能特点

- **优雅下线**：服务停止时能够正常从注册中心注销
- **健康检查**：启用服务健康检查，确保注册中心能够及时了解服务状态
- **自我保护**：Eureka Server启用自我保护模式，避免网络波动时服务被误删
- **服务续约**：调整服务续约和过期时间，确保服务状态的及时性

#### 6.2 使用方法

- **手动优雅下线**：向服务发送POST请求 `http://{服务地址}:{端口}/actuator/shutdown`
- **自动优雅下线**：使用`spring-boot:run`启动服务时，按`Ctrl+C`停止服务

### 7. Harbor私有镜像仓库

项目集成了Harbor私有镜像仓库，解决Docker在国内访问慢的问题：

#### 7.1 功能特点

- **本地存储**：所有镜像存储在本地，不依赖外部网络
- **加速构建**：本地镜像仓库拉取速度快
- **安全可控**：完全控制镜像的存储和访问
- **企业级功能**：支持镜像签名、漏洞扫描等高级功能

#### 7.2 使用方法

##### 7.2.1 启动Harbor

```bash
./harbor/start-harbor.bat
```

##### 7.2.2 访问Harbor

- **Web界面**：http://localhost:8081
- **用户名**：admin
- **密码**：Harbor12345

##### 7.2.3 推送镜像

```bash
# 登录Harbor
docker login localhost:5000

# 标记镜像
docker tag api-gateway:latest localhost:5000/cmatedata/api-gateway:latest

# 推送镜像
docker push localhost:5000/cmatedata/api-gateway:latest
```

##### 7.2.4 拉取镜像

```bash
docker pull localhost:5000/cmatedata/api-gateway:latest
```

### 8. 定时任务

项目添加了Docker资源自动清理定时任务：

#### 8.1 功能特点

- **自动执行**：每20分钟自动执行一次
- **全面清理**：清理容器、镜像、卷、网络和系统垃圾
- **安全可靠**：使用`-f`参数强制执行，不会因确认而中断
- **详细日志**：提供完整的执行日志，便于排查问题

#### 8.2 实现方式

- **技术**：Spring @Scheduled注解
- **频率**：每20分钟执行一次 (cron: 0 */20 * * * *)
- **位置**：eureka-server模块中的DockerCleanupScheduler类

#### 8.3 执行内容

- 清理未使用的容器：`docker container prune -f`
- 清理未使用的镜像：`docker image prune -f`
- 清理未使用的卷：`docker volume prune -f`
- 清理未使用的网络：`docker network prune -f`
- 清理系统垃圾：`docker system prune -f`

### 9. 每天清理脚本

项目提供了`cleanup-daily.bat`脚本，用于每天清理当天产生的Docker资源：

#### 9.1 使用方法

```bash
./cleanup-daily.bat
```

#### 9.2 功能特点

- **智能识别**：自动识别当天日期，只清理当天产生的资源
- **安全清理**：只清理当天的资源，不会影响之前的工作
- **全面清理**：清理容器、镜像、卷和系统垃圾
- **易于使用**：提供清晰的操作步骤和执行结果

#### 9.3 自动执行

可将脚本添加到Windows任务计划程序中，实现每天自动执行：

1. 打开任务计划程序
2. 创建基本任务，名称设为"Docker每天清理"
3. 设置触发器为每天执行
4. 设置操作为启动`cleanup-daily.bat`脚本
5. 勾选"使用最高权限运行"

## 停止服务

### 10.1 本地服务停止

运行`stop-services.bat`脚本查看运行的服务，然后手动关闭对应的命令窗口：

```bash
./stop-services.bat
```

### 10.2 Docker服务停止

使用Docker Compose停止所有服务：

```bash
docker-compose down
```

### 10.3 Harbor停止

运行`harbor/stop-harbor.bat`脚本停止Harbor服务：

```bash
./harbor/stop-harbor.bat
```

## 注意事项

- **数据库配置**：本项目支持MySQL和H2数据库，默认使用H2内存数据库（重启服务后数据会重置），可通过`spring.cloud.data`配置项切换到MySQL
- **MySQL初始化**：项目提供了SQL初始化脚本，位于`sql/init.sql`，可用于初始化MySQL数据库
- **服务启动顺序**：必须先启动Eureka Server，再启动其他服务
- **RabbitMQ依赖**：user-service依赖RabbitMQ服务，请确保RabbitMQ已启动
- **数据源服务**：data-source-service服务未启动时，其他服务会自动使用H2数据库
- **首次启动**：服务注册可能需要一些时间，请耐心等待
- **Docker要求**：Docker启动前请确保Docker Desktop已安装并运行
- **JDK版本**：JDK版本要求：Java 21
- **Maven版本**：Maven版本要求：3.6.0+
- **Harbor服务**：Harbor服务需要Docker和Docker Compose
- **默认协议**：默认配置使用HTTP协议，生产环境建议配置HTTPS

## Docker常用命令

- **构建镜像**：`docker-compose build`
- **启动服务**：`docker-compose up -d`
- **停止服务**：`docker-compose down`
- **查看状态**：`docker-compose ps`
- **查看日志**：`docker-compose logs [服务名]`
- **查看镜像**：`docker images`
- **删除镜像**：`docker rmi [镜像ID]`
- **登录Harbor**：`docker login localhost:5000`
- **推送镜像**：`docker push localhost:5000/cmatedata/[服务名]:latest`
- **拉取镜像**：`docker pull localhost:5000/cmatedata/[服务名]:latest`
- **启动RabbitMQ**：`docker run -d --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.8-management`
- **停止RabbitMQ**：`docker stop rabbitmq && docker rm rabbitmq`
- **查看容器详情**：`docker inspect [容器ID]`
- **进入容器**：`docker exec -it [容器ID] /bin/bash`
- **清理未使用的资源**：`docker system prune -f`

## 项目目的

本项目旨在提供一个基于Spring Cloud的微服务架构示例，同时结合化学学习的实际场景，展示如何构建一个完整的学习管理系统。通过本项目，您可以学习：

- Spring Cloud微服务架构的基本组件和使用方法
- 服务注册与发现、API网关的配置和使用
- Eureka优雅下线功能的实现和配置
- 微服务之间的通信和数据管理
- 基于JPA的数据访问和多数据源管理
- RabbitMQ消息队列的集成和使用
- 数据源管理服务的设计和实现
- Spring Security的基本配置和使用
- Docker容器化部署和Docker Compose的使用
- Harbor私有镜像仓库的搭建和使用
- 前端静态资源管理和Bootstrap框架的使用
- CSS3和JavaScript的前端开发技术
- HTML5和CSS3动画效果的实现
- 微服务项目的构建和部署流程
- JDK版本升级和项目迁移
- 定时任务的配置和使用
- 化学学习相关知识的管理和展示

## 项目优势

1. **完整架构**：包含微服务架构的所有核心组件
2. **实用功能**：结合化学学习的实际应用场景
3. **易于部署**：提供多种启动方式和部署方案
4. **国内优化**：集成Harbor解决Docker访问问题
5. **自动管理**：定时任务自动清理Docker资源
6. **响应式设计**：前端适配不同设备
7. **功能丰富**：包含元素周期表等实用模块
8. **文档完善**：详细的使用说明和技术文档
9. **消息队列集成**：RabbitMQ实现异步消息处理
10. **数据源管理**：独立的数据源服务控制数据源切换
11. **优雅下线**：Eureka支持服务优雅下线
12. **元素周期表优化**：CSS3动画效果和多页面跳转
13. **多数据源支持**：MySQL和H2数据库切换
14. **前端动画**：HTML5和CSS3动画效果

## 技术创新

1. **微服务架构**：采用Spring Cloud最新技术栈
2. **容器化部署**：Docker和Docker Compose集成
3. **私有镜像仓库**：Harbor解决国内访问问题
4. **定时任务**：自动清理Docker资源
5. **响应式前端**：Bootstrap 5和CSS Grid
6. **动态周期表**：JavaScript动态生成元素数据
7. **多服务协同**：微服务之间的无缝集成
8. **一键部署**：简化部署和管理流程
9. **消息队列集成**：RabbitMQ实现异步消息处理
10. **数据源管理服务**：独立服务控制数据源切换
11. **Eureka优雅下线**：服务停止时正常注销
12. **元素周期表优化**：CSS3动画效果和多页面跳转
13. **多数据源支持**：MySQL和H2数据库自动切换
14. **前端动画效果**：HTML5和CSS3动画

## MySQL数据库初始化

项目提供了MySQL数据库初始化脚本，用于创建数据库表结构和插入默认数据：

### 1. 初始化脚本位置

- **脚本文件**：`sql/init.sql`
- **Docker配置**：`sql/docker-compose-mysql.yml`
- **启动脚本**：`sql/start-mysql.bat`
- **停止脚本**：`sql/stop-mysql.bat`

### 2. 使用方法

#### 2.1 启动MySQL并初始化数据库

1. 进入`sql`目录
2. 运行`start-mysql.bat`脚本
3. 等待MySQL容器启动并执行初始化脚本

```bash
cd sql
./start-mysql.bat
```

#### 2.2 停止MySQL服务

1. 进入`sql`目录
2. 运行`stop-mysql.bat`脚本

```bash
cd sql
./stop-mysql.bat
```

### 3. 数据库连接信息

- **主机**：localhost
- **端口**：3306
- **数据库**：chemistry_learning
- **用户名**：root
- **密码**：123456

### 4. 初始化内容

#### 4.1 表结构

- **element**：元素表，存储元素的基本信息
- **user**：用户表，存储用户信息
- **learning_progress**：学习进度表，存储用户的学习进度

#### 4.2 默认数据

- **元素数据**：前20个元素的基本信息
- **用户数据**：管理员用户（admin）和普通用户（user）
- **学习进度数据**：管理员用户和普通用户的学习进度

### 5. 注意事项

- **Docker要求**：使用前请确保Docker Desktop已安装并运行
- **端口冲突**：确保3306端口未被其他服务占用
- **初始化时间**：首次启动时，初始化脚本执行可能需要一些时间
- **数据持久化**：MySQL数据存储在Docker卷中，容器重启后数据不会丢失

## 机器人验证页面

项目提供了一个公共的机器人验证页面，用于判断用户是否是脚本机器人，可用于签到等需要防机器人的功能：

### 1. 验证页面位置

- **页面文件**：`api-gateway/src/main/resources/static/robot-verification.html`
- **CSS文件**：`api-gateway/src/main/resources/static/css/robot-verification.css`
- **JavaScript文件**：`api-gateway/src/main/resources/static/js/robot-verification.js`

### 2. 验证方式

- **计算题验证**：随机生成简单的算术题，要求用户输入答案
- **拼图验证**：随机生成数字拼图，要求用户将拼图碎片拖放到正确位置

### 3. 使用方法

#### 3.1 直接访问验证页面

```
http://localhost:8080/robot-verification.html
```

#### 3.2 带回调URL的访问

可以在URL中添加`callback`参数，验证成功后会跳转到指定的回调URL：

```
http://localhost:8080/robot-verification.html?callback=http://localhost:8080/signin-success.html
```

### 4. 集成到其他页面

可以使用以下JavaScript代码集成机器人验证功能：

```javascript
// 检查用户是否已通过验证
if (!window.isRobotVerified()) {
    // 获取验证页面URL，带回调参数
    const verificationUrl = window.getRobotVerificationUrl(window.location.href);
    // 跳转到验证页面
    window.location.href = verificationUrl;
}

// 验证成功后，会自动跳转回原页面
```

### 5. 验证状态管理

- **验证状态存储**：验证成功后，状态会存储在本地存储中，有效期为1小时
- **状态检查**：使用`window.isRobotVerified()`函数检查验证状态
- **手动清除状态**：可以通过清除本地存储中的`robotVerified`和`robotVerifiedAt`键来清除验证状态

### 6. 功能特点

- **响应式设计**：适配不同屏幕尺寸
- **多种验证方式**：支持计算题和拼图两种验证方式
- **随机生成**：每次验证都会随机生成不同的题目或拼图
- **用户友好**：界面美观，操作简单
- **防机器人**：有效防止脚本机器人自动操作
- **易于集成**：提供了简单的JavaScript API，便于集成到其他页面
