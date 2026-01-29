# AI Service 模块

## 功能概述

AI Service 是一个基于 Spring Boot 的微服务，提供以下功能：

1. **AI 问答** - 基于提供的问题和上下文生成回答
2. **化学主题解释** - 生成化学相关主题的解释
3. **分子分析** - 分析分子结构并提供相关信息
4. **反应预测** - 基于反应物预测化学反应结果
5. **OCR 文本提取** - 从图像中提取文本内容（新增）

## 技术栈

- Spring Boot 3.3.0
- Redis（用于缓存）
- Python 3.x（用于 OCR 功能）
- EasyOCR（用于文本提取）

## 快速开始

### 环境要求

- Java 17+
- Maven 3.6+
- Python 3.x（用于 OCR 功能）

### 安装 Python 依赖

OCR 功能需要以下 Python 包：

```bash
pip install easyocr opencv-python Pillow numpy
```

### 构建和运行

1. 构建项目：
   ```bash
   mvn clean package -DskipTests
   ```

2. 运行服务：
   ```bash
   java -jar target/ai-service-0.0.1-SNAPSHOT.jar
   ```

3. 验证服务：
   ```bash
   curl http://localhost:8080/api/ai/health
   ```

## API 端点

### 1. 健康检查

- **端点**：`GET /api/ai/health`
- **响应**：服务状态和 OCR 可用性

### 2. AI 问答

- **端点**：`POST /api/ai/ask`
- **请求体**：
  ```json
  {
    "question": "问题内容",
    "context": "上下文信息（可选）"
  }
  ```

### 3. 化学主题解释

- **端点**：`GET /api/ai/explain/{topic}`
- **路径参数**：`topic` - 要解释的化学主题

### 4. 分子分析

- **端点**：`POST /api/ai/analyze-molecule`
- **请求体**：
  ```json
  {
    "molecule": "分子结构"
  }
  ```

### 5. 反应预测

- **端点**：`POST /api/ai/predict-reaction`
- **请求体**：
  ```json
  {
    "reactants": "反应物"
  }
  ```

### 6. OCR 文本提取

- **端点**：`POST /api/ai/ocr`
- **请求体**：
  ```json
  {
    "image": "base64编码的图像数据"
  }
  ```
- **响应**：
  ```json
  {
    "success": true,
    "text": "提取的文本内容",
    "python_available": true
  }
  ```

## OCR 功能详细说明

有关 OCR 功能的详细实现和使用说明，请参考 [OCR_INTEGRATION.md](OCR_INTEGRATION.md) 文件。

## 配置

服务默认使用以下配置：

- 端口：8080
- Redis：localhost:6379

可以通过环境变量或 `application.properties` 文件修改这些配置。

## 故障排除

### 常见问题

1. **OCR 功能不可用**
   - 检查 Python 是否安装
   - 检查 Python 依赖是否安装
   - 检查 Python 是否在系统路径中

2. **服务启动失败**
   - 检查 Java 版本
   - 检查端口是否被占用
   - 检查 Redis 连接

3. **OCR 处理失败**
   - 检查图像是否为有效的 base64 编码
   - 检查图像格式是否受支持
   - 检查网络连接（首次运行需要下载模型）

## 日志

服务使用标准 Java 日志系统，日志级别可在 `application.properties` 中配置。

## 贡献

欢迎提交问题和改进建议。

## 许可证

本项目使用 MIT 许可证。