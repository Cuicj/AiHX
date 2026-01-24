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
├── harbor/                  # Harbor私有镜像仓库配置
├── Dockerfile               # 根目录Dockerfile
├── docker-compose.yml       # Docker Compose配置
├── docker-build.bat         # Docker一键打包脚本
├── build.bat                # Maven构建脚本
├── start-services.bat       # 启动脚本
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
- Spring Security (安全认证)
- Docker & Docker Compose (容器化部署)
- Harbor (私有镜像仓库)
- Bootstrap 5 (前端框架)
- CSS3 & JavaScript (前端开发)

## 服务说明

1. **eureka-server**：服务注册与发现中心，运行在端口8761
2. **api-gateway**：API网关，运行在端口8080，负责路由请求和前端静态资源服务
3. **chemistry-service**：化学数据服务，运行在端口8081，提供元素等化学数据
4. **user-service**：用户服务，运行在端口8082，提供用户管理功能
5. **learning-progress-service**：学习进度服务，运行在端口8085，跟踪用户学习进度
6. **harbor**：私有镜像仓库，运行在端口8081（Web）、5000（Registry）

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
- Harbor Web界面: http://localhost:8081 (Harbor)

#### 3.2 Docker服务

- Eureka Server: http://localhost:8761
- API Gateway (前端): http://localhost:8080
- Chemistry Service: http://localhost:8081
- User Service: http://localhost:8082
- Learning Progress Service: http://localhost:8085
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

项目添加了完整的元素周期表模块：

#### 2.1 功能特点

- **完整展示**：包含所有元素的周期表展示
- **分类颜色**：不同类型元素使用不同颜色标识
- **响应式设计**：适配不同屏幕尺寸
- **详细信息**：点击元素查看详细信息
- **化学分类**：金属、非金属、稀有气体等分类展示

#### 2.2 访问方式

- **导航菜单**：点击首页导航菜单 -> 元素世界 -> 元素周期表
- **直接访问**：http://localhost:8080/periodic-table.html

#### 2.3 技术实现

- **前端**：HTML5 + CSS3 + JavaScript
- **布局**：CSS Grid实现周期表布局
- **样式**：Bootstrap 5响应式设计
- **数据**：JavaScript动态生成元素数据

### 3. Harbor私有镜像仓库

项目集成了Harbor私有镜像仓库，解决Docker在国内访问慢的问题：

#### 3.1 功能特点

- **本地存储**：所有镜像存储在本地，不依赖外部网络
- **加速构建**：本地镜像仓库拉取速度快
- **安全可控**：完全控制镜像的存储和访问
- **企业级功能**：支持镜像签名、漏洞扫描等高级功能

#### 3.2 使用方法

##### 3.2.1 启动Harbor

```bash
./harbor/start-harbor.bat
```

##### 3.2.2 访问Harbor

- **Web界面**：http://localhost:8081
- **用户名**：admin
- **密码**：Harbor12345

##### 3.2.3 推送镜像

```bash
# 登录Harbor
docker login localhost:5000

# 标记镜像
docker tag api-gateway:latest localhost:5000/cmatedata/api-gateway:latest

# 推送镜像
docker push localhost:5000/cmatedata/api-gateway:latest
```

##### 3.2.4 拉取镜像

```bash
docker pull localhost:5000/cmatedata/api-gateway:latest
```

### 4. 定时任务

项目添加了Docker资源自动清理定时任务：

#### 4.1 功能特点

- **自动执行**：每20分钟自动执行一次
- **全面清理**：清理容器、镜像、卷、网络和系统垃圾
- **安全可靠**：使用`-f`参数强制执行，不会因确认而中断
- **详细日志**：提供完整的执行日志，便于排查问题

#### 4.2 实现方式

- **技术**：Spring @Scheduled注解
- **频率**：每20分钟执行一次 (cron: 0 */20 * * * *)
- **位置**：eureka-server模块中的DockerCleanupScheduler类

#### 4.3 执行内容

- 清理未使用的容器：`docker container prune -f`
- 清理未使用的镜像：`docker image prune -f`
- 清理未使用的卷：`docker volume prune -f`
- 清理未使用的网络：`docker network prune -f`
- 清理系统垃圾：`docker system prune -f`

### 5. 每天清理脚本

项目提供了`cleanup-daily.bat`脚本，用于每天清理当天产生的Docker资源：

#### 5.1 使用方法

```bash
./cleanup-daily.bat
```

#### 5.2 功能特点

- **智能识别**：自动识别当天日期，只清理当天产生的资源
- **安全清理**：只清理当天的资源，不会影响之前的工作
- **全面清理**：清理容器、镜像、卷和系统垃圾
- **易于使用**：提供清晰的操作步骤和执行结果

#### 5.3 自动执行

可将脚本添加到Windows任务计划程序中，实现每天自动执行：

1. 打开任务计划程序
2. 创建基本任务，名称设为"Docker每天清理"
3. 设置触发器为每天执行
4. 设置操作为启动`cleanup-daily.bat`脚本
5. 勾选"使用最高权限运行"

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

### 4.3 Harbor停止

运行`harbor/stop-harbor.bat`脚本停止Harbor服务：

```bash
./harbor/stop-harbor.bat
```

## 注意事项

- 本项目使用H2内存数据库，重启服务后数据会重置
- 服务启动顺序很重要，必须先启动Eureka Server，再启动其他服务
- 首次启动时，服务注册可能需要一些时间，请耐心等待
- Docker启动前请确保Docker Desktop已安装并运行
- JDK版本要求：Java 21
- Maven版本要求：3.6.0+
- Harbor服务需要Docker和Docker Compose
- 默认配置使用HTTP协议，生产环境建议配置HTTPS

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

## 项目目的

本项目旨在提供一个基于Spring Cloud的微服务架构示例，同时结合化学学习的实际场景，展示如何构建一个完整的学习管理系统。通过本项目，您可以学习：

- Spring Cloud微服务架构的基本组件和使用方法
- 服务注册与发现、API网关的配置和使用
- 微服务之间的通信和数据管理
- 基于JPA的数据访问和内存数据库的使用
- Spring Security的基本配置和使用
- Docker容器化部署和Docker Compose的使用
- Harbor私有镜像仓库的搭建和使用
- 前端静态资源管理和Bootstrap框架的使用
- CSS3和JavaScript的前端开发技术
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

## 技术创新

1. **微服务架构**：采用Spring Cloud最新技术栈
2. **容器化部署**：Docker和Docker Compose集成
3. **私有镜像仓库**：Harbor解决国内访问问题
4. **定时任务**：自动清理Docker资源
5. **响应式前端**：Bootstrap 5和CSS Grid
6. **动态周期表**：JavaScript动态生成元素数据
7. **多服务协同**：微服务之间的无缝集成
8. **一键部署**：简化部署和管理流程
