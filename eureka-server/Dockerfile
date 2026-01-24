# 使用OpenJDK 21作为基础镜像
FROM openjdk:21-jdk-slim

# 设置工作目录
WORKDIR /app

# 复制构建产物到容器中
COPY target/*.jar app.jar

# 暴露端口
EXPOSE 8761

# 运行应用
ENTRYPOINT ["java", "-jar", "app.jar"]