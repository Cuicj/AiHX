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
├── Dockerfile               # 根目录Dockerfile
├── docker-compose.yml       # Docker Compose配置
├── docker-build.bat         # Docker一键打包脚本
├── build.bat                # Maven构建脚本
├── start-services.bat       # 启动脚本
├── stop-services.bat        # 停止脚本
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
- Spring Security (安全认证)
- Docker & Docker Compose (容器化部署)
- Bootstrap 5 (前端框架)
- CSS3 & JavaScript (前端开发)

## 服务说明

1. **eureka-server**：服务注册与发现中心，运行在端口8761
2. **api-gateway**：API网关，运行在端口8080，负责路由请求和前端静态资源服务
3. **chemistry-service**：化学数据服务，运行在端口8081，提供元素等化学数据
4. **user-service**：用户服务，运行在端口8082，提供用户管理功能
5. **learning-progress-service**：学习进度服务，运行在端口8085，跟踪用户学习进度

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

运行`start-services.bat`脚本启动所有服务：

```bash
./start-services.bat
```

服务将按照以下顺序启动：
1. Eureka Server
2. API Gateway
3. Chemistry Service
4. User Service
5. Learning Progress Service

#### 2.2 Docker启动

使用Docker Compose启动所有服务：

```bash
docker-compose up -d
```

### 3. 访问服务

#### 3.1 本地服务

- Eureka Server: http://localhost:8761
- API Gateway (前端): http://localhost:8080
- Chemistry Service: http://localhost:8081
- User Service: http://localhost:8082
- Learning Progress Service: http://localhost:8085

#### 3.2 Docker服务

- Eureka Server: http://localhost:8761
- API Gateway (前端): http://localhost:8080
- Chemistry Service: http://localhost:8081
- User Service: http://localhost:8082
- Learning Progress Service: http://localhost:8085

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

## 停止服务

### 4.1 本地服务停止

运行`stop-services.bat`脚本查看运行的服务，然后手动关闭对应的命令窗口：

```bash
./stop-services.bat
```

### 4.2 Docker服务停止

使用Docker Compose停止所有服务：

```bash
docker-compose down
```

## 新功能说明

### 1. 首页导航菜单

项目首页添加了美观的化学主题导航菜单，包含以下分类：

- **元素世界**：元素周期表、金属元素、非金属元素、稀有气体
- **化学反应**：基本反应类型、氧化还原反应、酸碱反应、配位反应
- **化学分支**：有机化学、无机化学、分析化学、物理化学
- **应用化学**：环境化学、医药化学、材料化学、能源化学
- **学习资源**：各类学习资料和工具
- **登录/注册**：用户认证入口

### 2. Docker一键打包

项目添加了完整的Docker容器化支持：

- 为每个服务模块创建了Dockerfile
- 提供了`docker-build.bat`一键打包脚本
- 使用Docker Compose管理多个容器
- 支持环境变量配置

## 注意事项

- 本项目使用H2内存数据库，重启服务后数据会重置
- 服务启动顺序很重要，必须先启动Eureka Server，再启动其他服务
- 首次启动时，服务注册可能需要一些时间，请耐心等待
- Docker启动前请确保Docker Desktop已安装并运行
- JDK版本要求：Java 21
- Maven版本要求：3.6.0+

## Docker常用命令

- **构建镜像**：`docker-compose build`
- **启动服务**：`docker-compose up -d`
- **停止服务**：`docker-compose down`
- **查看状态**：`docker-compose ps`
- **查看日志**：`docker-compose logs [服务名]`
- **查看镜像**：`docker images`
- **删除镜像**：`docker rmi [镜像ID]`

## 项目目的

本项目旨在提供一个基于Spring Cloud的微服务架构示例，同时结合化学学习的实际场景，展示如何构建一个完整的学习管理系统。通过本项目，您可以学习：

- Spring Cloud微服务架构的基本组件和使用方法
- 服务注册与发现、API网关的配置和使用
- 微服务之间的通信和数据管理
- 基于JPA的数据访问和内存数据库的使用
- Spring Security的基本配置和使用
- Docker容器化部署和Docker Compose的使用
- 前端静态资源管理和Bootstrap框架的使用
- CSS3和JavaScript的前端开发技术
- 微服务项目的构建和部署流程
- JDK版本升级和项目迁移