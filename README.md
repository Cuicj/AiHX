# 化学学习平台 - 积分兑换与区块链系统

## 项目简介

本项目是一个基于微服务架构的化学学习平台，包含积分兑换、库存管理、化学内容管理和区块链交互功能。系统采用Spring Boot和Spring Cloud技术栈，实现了分布式事务管理、消息队列异步通信、数据库读写分离和多区块链网络交互。

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
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│ ┌───────────────┐  ┌────────────┐  ┌──────────────────┐  ┌────────────────┐  ┌──────────┐ │
│ │user-auth-     │  │resource-   │  │chemistry-content-│  │quiz-           │  │task-     │ │
│ │service        │  │service     │  │service          │  │service         │  │management-│ │
│ │- 用户认证      │  │- 资源管理   │  │- 化学内容管理    │  │- 答题管理       │  │service   │ │
│ │- 签到管理      │  │- 物品管理   │  │- 元素管理        │  │- 错题收藏       │  │- 定时任务管理│ │
│ └───────────────┘  └────────────┘  └──────────────────┘  └────────────────┘  └──────────┘ │
│                                                                                         │
│ ┌────────────┐  ┌────────────┐  ┌───────────────────┐                                     │
│ │reward-     │  │learning-   │  │nft-marketplace-   │                                     │
│ │service     │  │service     │  │service            │                                     │
│ │- 积分兑换   │  │- 学习进度管理 │  │- NFT商城管理      │                                     │
│ │- 库存管理   │  │- 任务管理    │  │- NFT创建与上架     │                                     │
│ └────────────┘  └────────────┘  └───────────────────┘                                     │
└─────────────────────────────────────────────────────────────────────────────────────────┘
                            │
                    ┌───────▼───────┐
                    │   RabbitMQ    │
                    │   消息队列    │
                    └───────────────┘
                            │
                    ┌───────▼───────┐
                    │ MySQL Cluster │
                    │ 主从复制      │
                    └───────────────┘
```

### 核心组件

1. **Eureka Server**: 服务注册与发现中心
2. **User Auth Service**: 用户认证和签到管理服务
3. **Resource Service**: 资源管理和物品管理服务
4. **Chemistry Content Service**: 化学内容管理和元素管理服务
5. **Quiz Service**: 答题管理和错题收藏服务
6. **Reward Service**: 积分兑换和库存管理服务（合并了原exchange-service和inventory-service）
7. **Learning Service**: 学习进度管理服务
8. **Task Management Service**: 定时任务管理服务，提供任务调度和监控
9. **NFT Marketplace Service**: NFT商城服务，提供NFT创建、上架、购买和管理功能
10. **API Gateway**: API网关，统一管理服务路由和限流
11. **RabbitMQ**: 消息队列，用于异步通信和削峰
12. **MySQL Cluster**: 数据库集群，实现主从复制和读写分离
13. **Seata**: 分布式事务管理，确保跨服务事务一致性

## 技术栈

- **Spring Boot 3.2.2**: 服务基础框架
- **Spring Cloud 2023.0.0**: 微服务框架
- **Spring Cloud Netflix Eureka**: 服务注册与发现
- **Spring Cloud Gateway**: API网关
- **Spring Cloud OpenFeign**: 服务间通信
- **Spring Cloud CircuitBreaker**: 服务熔断和降级
- **Seata 1.7.1**: 分布式事务管理
- **RabbitMQ**: 消息队列，用于异步通信和削峰
- **MySQL 8.0**: 主从复制数据库
- **Spring Data JPA**: 数据访问层
- **Spring Security**: 安全框架
- **AOP**: 面向切面编程，用于数据库读写分离
- **Web3j**: 以太坊客户端，用于区块链交互
- **OkHttp3**: HTTP客户端，用于OKX API交互
- **Spring Boot Actuator**: 服务监控

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

### 6. 论坛功能

- **帖子发布**: 用户可以发布关于化学相关的帖子
- **评论系统**: 支持对帖子进行评论，类似X平台的评论功能
- **点赞功能**: 用户可以对帖子进行点赞
- **违禁词过滤**: 自动过滤帖子和评论中的违禁词

### 7. 违禁词过滤系统

- **多端过滤**: 前端和后端双重违禁词过滤
- **配置管理**: 通过配置文件管理违禁词列表
- **自动替换**: 将违禁词自动替换为***
- **OCR集成**: 对OCR识别的文本也进行违禁词过滤

### 8. 用户级别系统

- **级别管理**: 支持ADMIN和CUSTOMER两个用户级别
- **自动初始化**: 服务启动时自动初始化默认管理员账户
- **配置管理**: 通过配置文件管理用户级别设置
- **注册集成**: 新用户注册时自动设置默认客户级别

### 9. 常量库系统

- **性能优化**: 通过常量库减少运行时字符串创建，提高编译和渲染速度
- **集中管理**: 将常量值集中管理，便于维护和修改
- **类型安全**: 使用Java常量类，提供类型安全的常量定义
- **服务隔离**: 每个服务都有独立的常量库，避免常量冲突

**常量库文件列表**:
- `UserAuthServiceConstants.java`: 用户认证服务常量
- `UserServiceConstants.java`: 用户服务常量
- `AiServiceConstants.java`: AI服务常量
- `ApiGatewayConstants.java`: API网关常量

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
| `/users/checkin` | POST | 用户签到（需要userId、deviceId和ipAddress） |
| `/users/checkin/status` | POST | 签到状态查询（需要userId、deviceId和ipAddress） |
| `/users/{id}/checkin-records` | GET | 获取用户签到记录 |
| `/users/{id}/checkin-stats` | GET | 获取用户签到统计（需要month和year） |

### Quiz Service

| 接口 | 方法 | 描述 |
|------|------|------|
| `/quiz/daily-questions` | GET | 获取每日随机题目（需要userId和deviceId） |
| `/quiz/submit` | POST | 提交答题结果（需要userId、deviceId和answers） |
| `/quiz/today-status` | GET | 获取今日答题状态（需要userId和deviceId） |
| `/quiz/records` | GET | 获取用户答题记录（需要userId） |
| `/quiz/stats` | GET | 获取用户答题统计（需要userId） |
| `/quiz/details/{quizRecordId}` | GET | 获取答题详情 |
| `/quiz/summary/{quizRecordId}` | GET | 获取答题总结（包含错题详情和平均答题时间） |
| `/quiz/collect-mistake` | POST | 收藏错题（需要userId和questionId） |
| `/quiz/remove-mistake` | POST | 取消收藏错题（需要userId和questionId） |
| `/quiz/mistakes` | GET | 获取用户错题集（需要userId） |

### API Gateway

| 路径 | 服务 | 描述 |
|------|------|------|
| `/api/user/**` | user-auth-service | 用户认证服务接口 |
| `/api/resources/**` | resource-service | 资源管理服务接口 |
| `/api/chemistry/**` | chemistry-content-service | 化学内容服务接口 |
| `/api/quiz/**` | quiz-service | 答题服务接口 |
| `/api/reward/**` | reward-service | 奖励服务接口（积分兑换和库存管理） |
| `/api/learning/**` | learning-service | 学习服务接口（学习进度管理） |
| `/api/tasks/**` | task-management-service | 任务管理服务接口（定时任务监控） |
| `/api/nft/**` | nft-marketplace-service | NFT商城服务接口（NFT管理和交易） |

### NFT Marketplace Service 接口说明

| 接口 | 方法 | 描述 |
|------|------|------|
| `/api/nft/available` | GET | 获取可购买的NFT列表 |
| `/api/nft/{id}` | GET | 获取NFT详情 |
| `/api/nft/purchase/{nftId}` | POST | 购买NFT |
| `/api/nft/user/{userId}` | GET | 获取用户拥有的NFT |
| `/api/nft/create` | POST | 创建NFT |
| `/api/nft/list` | POST | 上架NFT |
| `/api/nft/transfer/create` | POST | 创建NFT转赠记录 |
| `/api/nft/transfer/{transferId}/accept` | POST | 接受NFT转赠 |
| `/api/nft/transfer/{transferId}/reject` | POST | 拒绝NFT转赠 |
| `/api/message/send` | POST | 发送消息 |
| `/api/message/user/{phone}` | GET | 获取用户的消息列表 |
| `/api/message/{messageId}` | GET | 获取消息详情 |
| `/api/message/{messageId}/status` | PUT | 更新消息状态 |

#### 订单状态流转

NFT购买流程中的订单状态流转如下：

1. **待支付**：用户确认购买NFT后，订单进入待支付状态，此时用户需要完成支付操作
2. **支付中**：用户开始支付后，订单进入支付中状态，系统处理支付请求
3. **已完成**：支付成功后，订单进入已完成状态，NFT所有权转移给用户

**流转图**：
```
┌─────────┐     确认购买     ┌─────────┐     开始支付     ┌─────────┐     支付成功     ┌─────────┐
│ 初始状态 │ ──────────────> │ 待支付   │ ──────────────> │ 支付中   │ ──────────────> │ 已完成   │
└─────────┘                  └─────────┘                  └─────────┘                  └─────────┘
```

**状态说明**：
- **待支付**：用户可以在此状态下取消订单或继续支付
- **支付中**：系统处理支付请求，用户需要等待支付完成
- **已完成**：订单完成，NFT已转移到用户账户，用户可以在"我的NFT"页面查看

#### NFT转赠功能

NFT转赠流程中的状态流转如下：

1. **待接收**：用户发起转赠请求后，转赠记录进入待接收状态，此时接收人需要确认是否接受转赠
2. **已接受**：接收人确认接受转赠后，转赠记录进入已接受状态，NFT所有权转移给接收人
3. **已拒绝**：接收人拒绝转赠后，转赠记录进入已拒绝状态，NFT所有权保持不变
4. **已过期**：接收人在24小时内未确认接受转赠，转赠记录进入已过期状态，NFT所有权保持不变

**流转图**：
```
┌─────────┐     发起转赠     ┌─────────┐     接受转赠     ┌─────────┐
│ 初始状态 │ ──────────────> │ 待接收   │ ──────────────> │ 已接受   │
└─────────┘                  └─────────┘                  └─────────┘
                                │
                                │ 拒绝转赠
                                ▼
                            ┌─────────┐
                            │ 已拒绝   │
                            └─────────┘
                                │
                                │ 24小时过期
                                ▼
                            ┌─────────┐
                            │ 已过期   │
                            └─────────┘
```

**状态说明**：
- **待接收**：接收人可以在此状态下接受或拒绝转赠
- **已接受**：转赠完成，NFT已转移到接收人账户
- **已拒绝**：转赠被拒绝，NFT所有权保持不变
- **已过期**：转赠请求已过期，NFT所有权保持不变

#### 实时消息功能

系统支持实时消息推送功能，主要包括：

1. **系统通知**：向所有用户发送的系统级通知
2. **个人消息**：根据用户手机号发送的个人消息
3. **转赠消息**：NFT转赠相关的消息通知

**消息类型**：
- **info**：普通信息
- **success**：成功信息
- **warning**：警告信息
- **error**：错误信息

#### Elasticsearch搜索功能

系统集成了Elasticsearch搜索功能，为NFT和消息提供高效的全文搜索能力。

**搜索功能概述**：
- **NFT搜索**：支持按名称、描述、系列等字段进行全文搜索
- **消息搜索**：支持按标题、内容等字段进行全文搜索
- **多维度过滤**：支持按区块链、价格范围、状态等维度进行过滤
- **实时索引**：NFT和消息的变更会实时同步到Elasticsearch索引

**支持的搜索类型**：
- **全文搜索**：基于关键词的模糊匹配
- **精确搜索**：基于特定字段的精确匹配
- **范围搜索**：基于数值范围的搜索（如价格范围）
- **组合搜索**：多个搜索条件的组合

**Elasticsearch API接口**：

| 接口 | 方法 | 描述 |
|------|------|------|
| `/api/nft/search/es` | GET | 使用Elasticsearch搜索NFT |
| `/api/nft/search/es/status` | GET | 使用Elasticsearch根据状态搜索NFT |
| `/api/nft/search/es/blockchain` | GET | 使用Elasticsearch根据区块链搜索NFT |
| `/api/nft/search/es/price` | GET | 使用Elasticsearch根据价格范围搜索NFT |
| `/api/nft/search/es/owner` | GET | 使用Elasticsearch根据所有者搜索NFT |
| `/api/nft/search/es/creator` | GET | 使用Elasticsearch根据创建者搜索NFT |
| `/api/message/search/es` | GET | 使用Elasticsearch搜索消息 |
| `/api/message/search/es/type` | GET | 使用Elasticsearch根据类型搜索消息 |
| `/api/message/search/es/target` | GET | 使用Elasticsearch根据目标手机号搜索消息 |
| `/api/message/search/es/broadcast` | GET | 使用Elasticsearch获取所有广播消息 |
| `/api/message/search/es/sender` | GET | 使用Elasticsearch根据发送人搜索消息 |
| `/api/message/search/es/status` | GET | 使用Elasticsearch根据状态搜索消息 |

**前端搜索功能**：
- **搜索框**：位于NFT商城页面顶部，支持输入关键词搜索
- **过滤按钮**：支持按区块链类型进行快速过滤
- **搜索结果**：实时显示搜索结果，支持分页和排序
- **响应式设计**：适配不同屏幕尺寸的设备

## 部署说明

### 环境要求

- JDK 17+
- Maven 3.6.3+
- RabbitMQ 3.8+
- Seata 1.4.2+ (可选，用于分布式事务)
- 区块链节点连接（可选，用于区块链交互）

### 服务启动顺序

1. **启动 MySQL 主从复制集群**
   ```bash
   cd mysql-master-slave
   docker-compose up -d
   ```

2. **启动 RabbitMQ**
   ```bash
   docker run -d --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.8-management
   ```

3. **启动 Eureka Server**
   ```bash
   cd eureka-server
   mvn spring-boot:run
   ```

4. **启动 User Auth Service**
   ```bash
   cd user-auth-service
   mvn spring-boot:run
   ```

5. **启动 Resource Service**
   ```bash
   cd resource-service
   mvn spring-boot:run
   ```

6. **启动 Chemistry Content Service**
   ```bash
   cd chemistry-content-service
   mvn spring-boot:run
   ```

7. **启动 Quiz Service**
   ```bash
   cd quiz-service
   mvn spring-boot:run
   ```

8. **启动 Reward Service**
   ```bash
   cd reward-service
   mvn spring-boot:run
   ```

9. **启动 Learning Service**
   ```bash
   cd learning-service
   mvn spring-boot:run
   ```

10. **启动 Task Management Service**
    ```bash
    cd task-management-service
    mvn spring-boot:run
    ```

11. **启动 NFT Marketplace Service**
    ```bash
    cd nft-marketplace-service
    mvn spring-boot:run
    ```

12. **启动 API Gateway**
    ```bash
    cd api-gateway
    mvn spring-boot:run
    ```

### 服务地址

- Eureka Server: http://localhost:8761
- User Auth Service: http://localhost:8081
- Resource Service: http://localhost:8082
- Chemistry Content Service: http://localhost:8083
- Quiz Service: http://localhost:8084
- Reward Service: http://localhost:8085
- Learning Service: http://localhost:8086
- Task Management Service: http://localhost:8087
- NFT Marketplace Service: http://localhost:8088
- API Gateway: https://localhost:8443
- MySQL Master: localhost:3306
- MySQL Slave 1: localhost:3307
- MySQL Slave 2: localhost:3308
- RabbitMQ Management: http://localhost:15672

## 测试说明

### 积分兑换测试

1. **检查用户积分**
   ```bash
   curl http://localhost:8080/api/user/users/1
   ```

2. **检查物品库存**
   ```bash
   curl http://localhost:8080/api/resources/items/1
   ```

3. **处理积分兑换**
   ```bash
   curl -X POST http://localhost:8080/api/reward/process-exchange \
     -H "Content-Type: application/json" \
     -d '{"userId": 1, "itemId": 1}'
   ```

4. **检查兑换记录**
   ```bash
   curl http://localhost:8080/api/reward/exchange-records?userId=1
   ```

### 资源管理测试

1. **获取资源分类**
   ```bash
   curl http://localhost:8080/api/resources/categories
   ```

2. **获取资源物品**
   ```bash
   curl http://localhost:8080/api/resources/items
   ```

3. **创建资源物品**
   ```bash
   curl -X POST http://localhost:8080/api/resources/items \
     -H "Content-Type: application/json" \
     -d '{"name": "化学实验器材", "description": "基础化学实验器材套装", "categoryId": 1, "points": 200, "stock": 50}'
   ```

### 化学内容测试

1. **获取化学元素列表**
   ```bash
   curl http://localhost:8080/api/chemistry/elements
   ```

2. **获取化学元素详情**
   ```bash
   curl http://localhost:8080/api/chemistry/elements/1
   ```

3. **搜索化学元素**
   ```bash
   curl http://localhost:8080/api/chemistry/elements/search?query=氢
   ```

### 答题测试

1. **获取每日随机题目**
   ```bash
   curl "http://localhost:8080/api/quiz/quiz/daily-questions?userId=1&deviceId=device_123456"
   ```

2. **提交答题结果**
   ```bash
   curl -X POST "http://localhost:8080/api/quiz/quiz/submit?userId=1&deviceId=device_123456" \
     -H "Content-Type: application/json" \
     -d '{
       "answers": {
         "1": "B",
         "2": "C",
         "3": "A",
         "4": "D",
         "5": "A"
       },
       "timeSpent": 60
     }'
   ```

3. **获取今日答题状态**
   ```bash
   curl "http://localhost:8080/api/quiz/quiz/today-status?userId=1&deviceId=device_123456"
   ```

4. **获取用户答题记录**
   ```bash
   curl "http://localhost:8080/api/quiz/quiz/records?userId=1&page=1&size=10"
   ```

5. **获取用户答题统计**
   ```bash
   curl "http://localhost:8080/api/quiz/quiz/stats?userId=1"
   ```

6. **获取答题详情**
   ```bash
   curl "http://localhost:8080/api/quiz/quiz/details/1"
   ```

7. **获取答题总结**
   ```bash
   curl "http://localhost:8080/api/quiz/quiz/summary/1"
   ```

8. **收藏错题**
   ```bash
   curl -X POST "http://localhost:8080/api/quiz/quiz/collect-mistake?userId=1&questionId=1"
   ```

9. **取消收藏错题**
   ```bash
   curl -X POST "http://localhost:8080/api/quiz/quiz/remove-mistake?userId=1&questionId=1"
   ```

10. **获取用户错题集**
    ```bash
    curl "http://localhost:8080/api/quiz/quiz/mistakes?userId=1&page=1&size=10"
    ```

### 签到测试

1. **用户签到**
   ```bash
   curl -X POST http://localhost:8080/api/user/users/checkin \
     -H "Content-Type: application/json" \
     -d '{"userId": 1, "deviceId": "device_123456", "ipAddress": "192.168.1.100"}'
   ```

2. **签到状态查询**
   ```bash
   curl -X POST http://localhost:8080/api/user/users/checkin/status \
     -H "Content-Type: application/json" \
     -d '{"userId": 1, "deviceId": "device_123456", "ipAddress": "192.168.1.100"}'
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

## 系统优化

### 1. 监控和可观测性
- **Spring Boot Actuator**: 提供服务健康状态、性能指标和运行信息
- **Micrometer**: 指标收集框架，支持多种监控系统
- **Prometheus**: 开源监控系统，用于存储和查询指标数据
- **Grafana**: 数据可视化平台，提供实时监控面板

### 2. 服务容错和可靠性
- **Resilience4j**: 轻量级容错库，提供熔断器、限流、重试等功能
- **Circuit Breaker**: 服务熔断机制，防止故障扩散
- **Fallback**: 服务降级策略，确保系统在服务不可用时仍能正常运行

### 3. 缓存优化
- **Redis Cache**: 分布式缓存，提高系统响应速度
- **Spring Cache**: 缓存抽象，简化缓存操作
- **缓存策略**: 合理设置缓存过期时间，确保数据一致性

### 4. 安全措施
- **API Key认证**: 基于API密钥的访问控制
- **HTTPS加密**: 安全的HTTP传输，保护数据安全
- **Spring Security**: 提供全面的安全解决方案

### 5. 容器化部署
- **Docker**: 容器化运行环境
- **Kubernetes**: 容器编排平台，提供自动化部署、扩展和管理
- **Helm**: Kubernetes包管理器，简化应用部署

## 安全措施

1. **接口安全**
   - 使用 API Gateway 进行请求过滤
   - 实现接口访问限流
   - API Key认证，防止未授权访问

2. **数据安全**
   - 对敏感数据进行加密存储
   - 实现数据访问权限控制

3. **网络安全**
   - 使用 HTTPS 协议，确保数据传输安全
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
| 1.3.0 | 2026-01-27 | 添加随机答题功能，每天5题，包含化学知识与生活、生物等相关内容，支持AI与新闻题库 |
| 1.3.1 | 2026-01-27 | 更新答题功能，每道题的答题时间限制为40秒 |
| 1.3.2 | 2026-01-27 | 更新答题功能，每道题的答题时间限制为45秒，添加答题总结页面、错题收藏和错题集功能 |
| 1.3.3 | 2026-01-27 | 增强签到和答题功能：1. 相同IP地址一天只能签到一次 2. 每个设备ID只能做一次答题 3. 一天中每个人的题目不同 |
| 2.0.0 | 2026-01-28 | 系统优化版本：添加监控和可观测性（Prometheus+Grafana）、服务容错（Resilience4j）、缓存优化（Redis）、安全措施（API Key+HTTPS）、容器化部署（Kubernetes） |
| 2.1.0 | 2026-01-28 | 添加定时任务管理功能和专属页面，实现任务状态和执行历史的可视化展示 |
| 3.0.0 | 2026-01-28 | 集成NFT商城功能，包括NFT创建、上架、购买和管理，以及完整的前端展示页面 |
| 3.1.0 | 2026-01-28 | 添加实时弹窗消息功能和NFT转赠功能，包括消息发送、接收、转赠流程管理和24小时过期处理 |
| 3.2.0 | 2026-01-28 | 集成Elasticsearch搜索功能，为NFT和消息提供高效的全文搜索能力，支持多维度过滤和实时索引 |
| 3.3.0 | 2026-01-29 | 添加论坛功能和违禁词过滤系统：1. 创建论坛页面，支持帖子发布、评论和点赞 2. 实现前端和后端双重违禁词过滤 3. 集成违禁词过滤到OCR服务 4. 通过配置文件管理违禁词列表 |
| 3.4.0 | 2026-01-29 | 添加用户级别系统：1. 实现ADMIN和CUSTOMER两个用户级别 2. 服务启动时自动初始化默认管理员账户 3. 通过配置文件管理用户级别设置 4. 新用户注册时自动设置默认客户级别 |
| 3.5.0 | 2026-01-29 | 添加常量库系统：1. 为多个服务创建独立的常量库 2. 优化编译和渲染速度 3. 集中管理常量值 4. 提供类型安全的常量定义 |

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

**项目维护者**: C_cj
**联系方式**: 1204541710@QQ.com
**最后更新**: 2026-01-29
