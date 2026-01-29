# EasyOCR 集成说明文档

## 1. 功能概述

本项目集成了 EasyOCR 库，提供了从图像中提取文本的功能。通过 REST API 端点，用户可以上传包含文本的图像，系统会返回提取出的文本内容。

## 2. 技术实现

### 2.1 核心组件

1. **OcrService** - Java 服务类，负责调用 Python 脚本执行 OCR 操作
2. **ocr.py** - Python 脚本，使用 EasyOCR 库实现文本提取
3. **AiController** - REST 控制器，提供 OCR API 端点

### 2.2 技术栈

- **后端**：Spring Boot 3.3.0
- **Python 集成**：通过 Runtime.exec() 调用 Python 脚本
- **OCR 引擎**：EasyOCR
- **图像处理**：OpenCV, Pillow

## 3. 依赖要求

### 3.1 系统依赖

- **Python 3.x** - 必须安装
- **pip** - Python 包管理工具

### 3.2 Python 依赖

需要安装以下 Python 包：

```bash
pip install easyocr opencv-python Pillow numpy
```

### 3.3 Java 依赖

项目使用了以下 Java 依赖：

- spring-boot-starter-web
- spring-boot-starter-data-redis
- commons-pool2
- javacv-platform (用于图像相关功能)
- jython-standalone (备用 Python 执行环境)

## 4. API 接口

### 4.1 OCR 文本提取

**端点**：`POST /api/ai/ocr`

**请求体**：

```json
{
  "image": "base64编码的图像数据"
}
```

**响应**：

```json
{
  "success": true,
  "text": "提取的文本内容",
  "python_available": true
}
```

### 4.2 健康检查

**端点**：`GET /api/ai/health`

**响应**：

```json
{
  "success": true,
  "status": "AI service is running",
  "ocr_available": true
}
```

## 5. 实现细节

### 5.1 Python 脚本 (ocr.py)

Python 脚本负责实际的 OCR 操作：

1. 初始化 EasyOCR 读取器，支持英文和中文
2. 接收 base64 编码的图像数据
3. 解码并转换为图像对象
4. 使用 EasyOCR 提取文本
5. 拼接并返回提取的文本

### 5.2 Java 服务 (OcrService)

Java 服务类负责：

1. 在启动时检查 Python 是否可用
2. 构建并执行 Python 命令
3. 处理脚本执行结果和错误
4. 返回提取的文本或错误信息

### 5.3 错误处理

系统包含多层错误处理：

1. **Python 脚本错误处理** - 捕获并返回依赖缺失等错误
2. **Java 服务错误处理** - 处理 IO 异常、中断异常等
3. **API 错误处理** - 验证请求参数，返回适当的错误响应

## 6. 使用示例

### 6.1 示例请求

```bash
curl -X POST http://localhost:8080/api/ai/ocr \
  -H "Content-Type: application/json" \
  -d '{
    "image": "base64编码的图像数据"
  }'
```

### 6.2 示例响应

```json
{
  "success": true,
  "text": "Hello World!\n这是一个测试",
  "python_available": true
}
```

## 7. 性能考虑

1. **首次启动** - EasyOCR 首次运行时会下载模型文件，可能需要一些时间
2. **图像处理** - 大型图像可能需要更长的处理时间
3. **并发请求** - 每个 OCR 请求都会启动一个新的 Python 进程，并发请求可能会增加系统负载

## 8. 故障排除

### 8.1 常见错误

1. **Python 不可用**
   - 确保 Python 已安装并添加到系统路径
   - 检查 Python 版本 (需要 3.x)

2. **依赖缺失**
   - 运行 `pip install easyocr opencv-python Pillow numpy` 安装所需依赖

3. **模型下载失败**
   - 确保网络连接正常
   - EasyOCR 首次运行时需要下载模型文件

4. **图像编码错误**
   - 确保提供的是有效的 base64 编码图像数据
   - 检查图像格式是否受支持 (JPG, PNG 等)

### 8.2 日志信息

系统会记录以下日志信息：

- Python 可用性检查结果
- OCR 脚本执行状态
- 错误信息和异常

## 9. 扩展建议

1. **模型优化** - 可以考虑使用更小的模型以提高性能
2. **缓存机制** - 为频繁处理的图像添加缓存
3. **批量处理** - 支持一次处理多个图像
4. **语言支持** - 扩展支持更多语言
5. **Docker 集成** - 提供包含所有依赖的 Docker 镜像

## 10. 版本信息

- **EasyOCR**：最新版本
- **Python**：3.x
- **Spring Boot**：3.3.0
- **Java**：17+

## 11. 安全注意事项

1. **图像大小限制** - 建议在 API 层面限制上传图像的大小
2. **输入验证** - 确保输入的 base64 数据是有效的图像
3. **错误信息** - 避免在错误响应中泄露系统细节
4. **资源管理** - 确保 Python 进程正确终止，避免资源泄漏

## 12. 部署说明

1. **环境准备**
   - 安装 Python 3.x
   - 安装所需 Python 依赖
   - 安装 Java 17+

2. **构建项目**
   ```bash
   mvn clean package -DskipTests
   ```

3. **运行服务**
   ```bash
   java -jar target/ai-service-0.0.1-SNAPSHOT.jar
   ```

4. **验证服务**
   ```bash
   curl http://localhost:8080/api/ai/health
   ```

## 13. 测试建议

1. **功能测试** - 使用包含不同语言、字体和大小的文本图像测试
2. **性能测试** - 测试不同大小图像的处理时间
3. **边界测试** - 测试空图像、无效图像等边界情况
4. **负载测试** - 测试并发请求处理能力

---

**注意**：本功能依赖外部 Python 环境和网络连接（首次下载模型时），请确保部署环境满足这些要求。