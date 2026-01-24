# Harbor私有镜像仓库

本目录包含Harbor私有镜像仓库的部署配置，用于存储和管理项目的Docker镜像。

## 快速开始

### 1. 启动Harbor

运行`start-harbor.bat`脚本启动Harbor服务：

```bash
./start-harbor.bat
```

### 2. 访问Harbor Web界面

启动后，可以通过以下地址访问Harbor Web界面：

- **Web界面**：http://localhost:8081
- **用户名**：admin
- **密码**：Harbor12345

### 3. 停止Harbor

运行`stop-harbor.bat`脚本停止Harbor服务：

```bash
./stop-harbor.bat
```

## 使用指南

### 1. 登录Harbor

```bash
docker login localhost:5000
# 用户名：admin
# 密码：Harbor12345
```

### 2. 标记镜像

```bash
# 标记本地镜像
docker tag api-gateway:latest localhost:5000/cmatedata/api-gateway:latest

# 标记其他服务镜像
docker tag chemistry-service:latest localhost:5000/cmatedata/chemistry-service:latest
docker tag user-service:latest localhost:5000/cmatedata/user-service:latest
docker tag learning-progress-service:latest localhost:5000/cmatedata/learning-progress-service:latest
docker tag eureka-server:latest localhost:5000/cmatedata/eureka-server:latest
```

### 3. 推送镜像到Harbor

```bash
# 推送镜像
docker push localhost:5000/cmatedata/api-gateway:latest
docker push localhost:5000/cmatedata/chemistry-service:latest
docker push localhost:5000/cmatedata/user-service:latest
docker push localhost:5000/cmatedata/learning-progress-service:latest
docker push localhost:5000/cmatedata/eureka-server:latest
```

### 4. 从Harbor拉取镜像

```bash
# 拉取镜像
docker pull localhost:5000/cmatedata/api-gateway:latest
```

## 配置修改

### 1. 修改Harbor配置

编辑`docker-compose.yml`文件可以修改Harbor的配置：

- **端口**：默认使用8081（Web）、4443（HTTPS）、5000（Registry）
- **密码**：默认管理员密码为Harbor12345
- **存储**：默认存储在`./data`目录

### 2. 修改项目配置

在项目根目录的`docker-compose.yml`文件中，已经将Harbor集成到了项目中：

- 所有微服务都依赖于Harbor服务
- 可以通过Harbor私有仓库拉取和推送镜像

## 优势

1. **私有存储**：所有镜像存储在本地，不依赖外部网络
2. **加速构建**：本地镜像仓库拉取速度快
3. **安全可控**：完全控制镜像的存储和访问
4. **企业级功能**：支持镜像签名、漏洞扫描等高级功能

## 注意事项

- Harbor服务需要Docker和Docker Compose
- 默认配置使用HTTP协议，生产环境建议配置HTTPS
- 首次启动时，Harbor需要初始化数据库和配置，可能需要几分钟时间
- 存储镜像会占用磁盘空间，建议定期清理无用镜像
