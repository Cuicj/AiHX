# 化学学习平台 - 积分兑换与区块链系统

## 项目简介

本项目是一个基于微服务架构的化学学习平台，包含积分兑换、库存管理和区块链交互功能。系统采用Spring Boot和Spring Cloud技术栈，实现了分布式事务管理、消息队列削峰功能和多区块链网络交互。

## 架构设计

### 微服务架构

```
┌─────────────────────┐
│     API Gateway     │
└─────────┬───────────┘
          │
┌─────────▼───────────┐
│   Eureka Server     │
└─────────┬───────────┘
          │
┌─────────┼───────────┐
│         │           │
▼         ▼           ▼
┌─────────────────────────────────────────────────────────────┐
│ ┌────────────┐  ┌────────────┐  ┌───────────────┐  ┌─────────┐ │
│ │user-service│  │exchange-  │  │inventory-     │  │blockchain│ │
│ │用户服务    │  │service    │  │service        │  │-service │ │
│ │- 用户管理  │  │- 积分兑换  │  │- 库存管理     │  │- 区块链  │ │
│ │- 积分管理  │  │- 事务协调  │  │- 库存同步     │  │- 交易管理│ │
│ └────────────┘  └────────────┘  └───────────────┘  └─────────┘ │
└─────────────────────────────────────────────────────────────┘
                            │
                    ┌───────▼───────┐
                    │   RabbitMQ    │
                    │   消息队列    │
                    └───────────────┘
```

### 核心组件

1. **Eureka Server**: 服务注册与发现中心
2. **User Service**: 用户管理和积分管理服务
3. **Exchange Service**: 积分兑换服务，处理积分兑换逻辑
4. **Inventory Service**: 库存管理服务，处理库存更新和检查
5. **Blockchain Service**: 区块链服务，处理区块链交互和交易
6. **API Gateway**: API网关，统一管理服务路由
7. **RabbitMQ**: 消息队列，用于削峰和异步通信
8. **Seata**: 分布式事务管理，确保跨服务事务一致性

## 技术栈

- **Spring Boot 2.5.4**: 服务基础框架
- **Spring Cloud Netflix Eureka**: 服务注册与发现
- **Spring Cloud Gateway**: API网关
- **Seata 1.4.2**: 分布式事务管理
- **RabbitMQ**: 消息队列，用于削峰
- **Web3j**: 以太坊客户端，用于区块链交互
- **OkHttp3**: HTTP客户端，用于OKX API交互
- **H2 Database**: 嵌入式数据库，用于开发测试
- **Spring Data JPA**: 数据访问层

## 功能模块

### 1. 积分兑换模块

- **兑换处理**: 处理用户积分兑换请求，协调用户服务和库存服务
- **异步兑换**: 通过消息队列异步处理兑换请求，实现削峰
- **兑换记录**: 记录用户的积分兑换历史

### 2. 库存管理模块

- **库存检查**: 检查物品库存状态
- **库存更新**: 更新物品库存数量
- **库存同步**: 同步库存数据，确保数据一致性
- **批量更新**: 批量处理库存更新请求

### 3. 区块链交互模块

- **网络管理**: 支持以太坊、BSC、Polygon、OKC等多个区块链网络
- **Gas费用优化**: 实时获取各网络Gas费用，选择最优网络
- **交易管理**: 发送交易，查询交易状态
- **代币操作**: 部署代币合约，铸造代币
- **NFT功能**: NFT兑换，NFT铸造和管理
- **OKX API集成**: 与OKX API交互，支持OKX Chain操作

### 4. 分布式事务管理

- **全局事务**: 使用Seata实现跨服务的分布式事务
- **事务协调**: 确保积分扣除和库存更新的原子性
- **事务回滚**: 在发生错误时自动回滚事务

### 5. 消息队列削峰

- **异步处理**: 将库存更新和区块链交易请求放入消息队列，异步处理
- **死信队列**: 处理失败的消息，确保消息可靠性
- **消息重试**: 自动重试失败的消息处理

## 接口说明

### Exchange Service

| 接口 | 方法 | 描述 |
|------|------|------|
| `/exchange/process` | POST | 处理积分兑换 |
| `/exchange/async-process` | POST | 异步处理积分兑换（削峰） |
| `/exchange/records` | GET | 获取兑换记录 |
| `/exchange/records/user/{userId}` | GET | 获取用户的兑换记录 |

### Inventory Service

| 接口 | 方法 | 描述 |
|------|------|------|
| `/inventory/check/{itemId}` | GET | 检查库存 |
| `/inventory/update` | POST | 更新库存 |
| `/inventory/async-update` | POST | 异步更新库存（削峰） |
| `/inventory/sync` | POST | 同步库存 |
| `/inventory/batch-update` | POST | 批量更新库存 |

### Blockchain Service

| 接口 | 方法 | 描述 |
|------|------|------|
| `/blockchain/best-network` | GET | 获取最佳网络 |
| `/blockchain/gas-price/{network}/{chainType}` | GET | 获取Gas费用 |
| `/blockchain/transaction/send` | POST | 发送交易 |
| `/blockchain/token/deploy` | POST | 部署代币 |
| `/blockchain/token/mint` | POST | 铸造代币 |
| `/blockchain/nft/exchange` | POST | 兑换NFT |
| `/blockchain/transaction/status/{txHash}/{network}` | GET | 检查交易状态 |
| `/blockchain/network/status/{network}/{chainType}` | GET | 获取网络状态 |
| `/blockchain/okx/api` | POST | 与OKX API交互 |
| `/blockchain/networks` | GET | 获取所有支持的网络 |

### User Service

| 接口 | 方法 | 描述 |
|------|------|------|
| `/users` | GET | 获取用户列表 |
| `/users/{id}` | GET | 获取用户详情 |
| `/users` | POST | 创建用户 |
| `/users/{id}` | PUT | 更新用户信息 |
| `/users/{id}/points` | GET | 获取用户积分 |
| `/users/checkin` | POST | 用户签到（需要userId和deviceId） |
| `/users/checkin/status` | POST | 签到状态查询（需要userId和deviceId） |
| `/users/{id}/checkin-records` | GET | 获取用户签到记录 |
| `/users/{id}/checkin-stats` | GET | 获取用户签到统计（需要month和year） |

### API Gateway

| 路径 | 服务 | 描述 |
|------|------|------|
| `/api/user/**` | user-service | 用户服务接口 |
| `/api/exchange/**` | exchange-service | 兑换服务接口 |
| `/api/inventory/**` | inventory-service | 库存服务接口 |
| `/api/blockchain/**` | blockchain-service | 区块链服务接口 |
| `/api/resources/**` | user-service | 资源管理接口 |

## 部署说明

### 环境要求

- JDK 1.8+
- Maven 3.6+
- RabbitMQ 3.8+
- Seata 1.4.2+ (可选，用于分布式事务)
- 区块链节点连接（可选，用于区块链交互）

### 服务启动顺序

1. **启动 Eureka Server**
   ```bash
   cd eureka-server
   mvn spring-boot:run
   ```

2. **启动 User Service**
   ```bash
   cd user-service
   mvn spring-boot:run
   ```

3. **启动 Inventory Service**
   ```bash
   cd inventory-service
   mvn spring-boot:run
   ```

4. **启动 Exchange Service**
   ```bash
   cd exchange-service
   mvn spring-boot:run
   ```

5. **启动 Blockchain Service**
   ```bash
   cd blockchain-service
   mvn spring-boot:run
   ```

6. **启动 API Gateway**
   ```bash
   cd api-gateway
   mvn spring-boot:run
   ```

### 服务地址

- Eureka Server: http://localhost:8761
- User Service: http://localhost:8082
- Inventory Service: http://localhost:8084
- Exchange Service: http://localhost:8083
- Blockchain Service: http://localhost:8085
- API Gateway: http://localhost:8080

## 测试说明

### 积分兑换测试

1. **检查用户积分**
   ```bash
   curl http://localhost:8080/api/user/users/1
   ```

2. **检查物品库存**
   ```bash
   curl http://localhost:8080/api/inventory/check/1
   ```

3. **处理积分兑换**
   ```bash
   curl -X POST http://localhost:8080/api/exchange/process \
     -H "Content-Type: application/json" \
     -d '{"userId": 1, "itemId": 1}'
   ```

4. **异步处理积分兑换（削峰）**
   ```bash
   curl -X POST http://localhost:8080/api/exchange/async-process \
     -H "Content-Type: application/json" \
     -d '{"userId": 1, "itemId": 1}'
   ```

### 库存管理测试

1. **更新库存**
   ```bash
   curl -X POST http://localhost:8080/api/inventory/update \
     -H "Content-Type: application/json" \
     -d '{"itemId": 1, "quantity": -1}'
   ```

2. **异步更新库存（削峰）**
   ```bash
   curl -X POST http://localhost:8080/api/inventory/async-update \
     -H "Content-Type: application/json" \
     -d '{"itemId": 1, "quantity": -1}'
   ```

3. **同步库存**
   ```bash
   curl -X POST http://localhost:8080/api/inventory/sync
   ```

### 区块链测试

1. **获取最佳网络**
   ```bash
   curl http://localhost:8080/api/blockchain/best-network
   ```

2. **获取Gas费用**
   ```bash
   curl http://localhost:8080/api/blockchain/gas-price/ethereum/mainnet
   ```

3. **发送交易**
   ```bash
   curl -X POST http://localhost:8080/api/blockchain/transaction/send \
     -H "Content-Type: application/json" \
     -d '{"from": "0x1234567890123456789012345678901234567890", "to": "0x0987654321098765432109876543210987654321", "amount": 1, "network": "ethereum", "chainType": "testnet"}'
   ```

### 签到测试

1. **用户签到**
   ```bash
   curl -X POST http://localhost:8080/api/user/users/checkin \
     -H "Content-Type: application/json" \
     -d '{"userId": 1, "deviceId": "device_123456"}'
   ```

2. **签到状态查询**
   ```bash
   curl -X POST http://localhost:8080/api/user/users/checkin/status \
     -H "Content-Type: application/json" \
     -d '{"userId": 1, "deviceId": "device_123456"}'
   ```

3. **获取用户签到记录**
   ```bash
   curl http://localhost:8080/api/user/users/1/checkin-records
   ```

4. **获取用户签到统计**
   ```bash
   curl "http://localhost:8080/api/user/users/1/checkin-stats?month=1&year=2026"
   ```

## 配置说明

### RabbitMQ 配置

在各服务的 `application.yml` 文件中配置 RabbitMQ 连接信息：

```yaml
spring:
  rabbitmq:
    host: localhost
    port: 5672
    username: guest
    password: guest
    virtual-host: /
```

### Seata 配置

在各服务的 `application.yml` 文件中配置 Seata 连接信息：

```yaml
seata:
  enabled: true
  application-id: exchange-service
  tx-service-group: my_test_tx_group
  service:
    vgroup-mapping:
      my_test_tx_group: default
    grouplist:
      default: 127.0.0.1:8091
  config:
    type: file
  registry:
    type: file
```

### 区块链配置

在 blockchain-service 的 `application.yml` 文件中配置区块链节点连接信息：

```yaml
blockchain:
  networks:
    ethereum:
      mainnet: "https://mainnet.infura.io/v3/YOUR_INFURA_KEY"
      testnet: "https://sepolia.infura.io/v3/YOUR_INFURA_KEY"
    bsc:
      mainnet: "https://bsc-dataseed.binance.org/"
      testnet: "https://data-seed-prebsc-1-s1.binance.org:8545/"
    polygon:
      mainnet: "https://polygon-rpc.com"
      testnet: "https://rpc-mumbai.maticvigil.com"
    okc:
      mainnet: "https://exchainrpc.okex.org"
      testnet: "https://exchaintestrpc.okex.org"
  okx:
    apiKey: "YOUR_OKX_API_KEY"
    secretKey: "YOUR_OKX_SECRET_KEY"
    passphrase: "YOUR_OKX_PASSPHRASE"
```

## 监控与维护

### 服务监控

- Eureka Server 控制台: http://localhost:8761
- H2 数据库控制台:
  - User Service: http://localhost:8082/h2-console
  - Inventory Service: http://localhost:8084/h2-console
  - Exchange Service: http://localhost:8083/h2-console
  - Blockchain Service: http://localhost:8085/h2-console

### 日志管理

各服务的日志文件位于 `target/logs` 目录下，可通过修改 `application.yml` 文件调整日志级别：

```yaml
logging:
  level:
    root: info
    com.cmatedata: debug
```

## 故障处理

### 常见问题

1. **RabbitMQ 连接失败**
   - 检查 RabbitMQ 服务是否启动
   - 检查连接配置是否正确

2. **Seata 事务协调失败**
   - 检查 Seata Server 是否启动
   - 检查事务组配置是否正确

3. **服务注册失败**
   - 检查 Eureka Server 是否启动
   - 检查服务网络连接是否正常

4. **区块链连接失败**
   - 检查区块链节点是否可访问
   - 检查 API 密钥是否正确

### 故障恢复

1. **消息队列故障**
   - 重启 RabbitMQ 服务
   - 检查死信队列中的消息，手动处理失败的消息

2. **数据库故障**
   - 检查数据库连接配置
   - 重启服务，H2 数据库会自动重建

3. **服务节点故障**
   - 重启故障节点
   - 其他节点会自动接管服务

4. **区块链网络故障**
   - 切换到备用网络
   - 等待网络恢复后重试交易

## 性能优化

1. **消息队列削峰**
   - 使用异步处理模式，减轻服务直接压力
   - 合理设置队列大小和消费者数量

2. **缓存优化**
   - 对热点数据进行缓存
   - 使用 Redis 作为分布式缓存

3. **数据库优化**
   - 使用索引优化查询性能
   - 合理设计数据库表结构

4. **服务优化**
   - 合理设置线程池大小
   - 优化服务间调用，减少网络延迟

5. **区块链优化**
   - 基于Gas费用选择最优网络
   - 批量处理交易，减少网络请求

## 安全措施

1. **接口安全**
   - 使用 API Gateway 进行请求过滤
   - 实现接口访问限流

2. **数据安全**
   - 对敏感数据进行加密存储
   - 实现数据访问权限控制

3. **网络安全**
   - 使用 HTTPS 协议
   - 配置防火墙规则

4. **区块链安全**
   - 安全管理私钥
   - 验证交易签名
   - 防止重放攻击

## 版本管理

### 版本历史

| 版本 | 日期 | 描述 |
|------|------|------|
| 1.0.0 | 2026-01-27 | 初始版本，实现积分兑换和库存管理功能 |
| 1.1.0 | 2026-01-27 | 添加区块链服务，支持多区块链网络交互和OKX API集成 |
| 1.2.0 | 2026-01-27 | 添加签到功能，支持设备ID签到限制，每个设备每天只能签到一次 |

### 代码仓库

- 仓库地址: [项目代码仓库]
- 分支管理:
  - `master`: 主分支，稳定版本
  - `develop`: 开发分支，新功能开发
  - `feature/*`: 特性分支，特定功能开发

## 团队协作

### 开发流程

1. 从 `develop` 分支创建特性分支
2. 在特性分支上进行开发
3. 提交代码并创建 Pull Request
4. 代码审查通过后合并到 `develop` 分支
5. 定期从 `develop` 分支合并到 `master` 分支，发布稳定版本

### 代码规范

- 遵循 Spring Boot 代码规范
- 使用 Lombok 简化代码
- 实现接口文档（如 Swagger）
- 编写单元测试和集成测试

## 未来规划

1. **功能扩展**
   - 添加更多类型的积分兑换物品
   - 实现积分商城功能
   - 添加用户等级系统
   - 支持更多区块链网络
   - 实现跨链交易

2. **技术升级**
   - 升级到 Spring Boot 3.0+
   - 使用 Spring Cloud Alibaba 生态
   - 实现 Kubernetes 容器化部署

3. **性能优化**
   - 引入缓存中间件
   - 优化数据库性能
   - 实现服务网格
   - 优化区块链交易处理速度

4. **运维改进**
   - 实现自动化部署
   - 完善监控系统
   - 实现日志聚合分析

---

**项目维护者**: 化学学习平台开发团队
**联系方式**: [团队邮箱]
**最后更新**: 2026-01-27
