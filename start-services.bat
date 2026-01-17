@echo off
echo Starting Chemistry Learning Project Services...

:: 启动Eureka Server
echo Starting Eureka Server...
start cmd /k "cd f:\TEST\CMateData\eureka-server && mvn spring-boot:run"
:: 等待Eureka Server启动
timeout 10 > nul

:: 启动API Gateway
echo Starting API Gateway...
start cmd /k "cd f:\TEST\CMateData\api-gateway && mvn spring-boot:run"
:: 等待API Gateway启动
timeout 5 > nul

:: 启动Chemistry Service
echo Starting Chemistry Service...
start cmd /k "cd f:\TEST\CMateData\chemistry-service && mvn spring-boot:run"
:: 等待Chemistry Service启动
timeout 5 > nul

:: 启动User Service
echo Starting User Service...
start cmd /k "cd f:\TEST\CMateData\user-service && mvn spring-boot:run"
:: 等待User Service启动
timeout 5 > nul

:: 启动Learning Progress Service
echo Starting Learning Progress Service...
start cmd /k "cd f:\TEST\CMateData\learning-progress-service && mvn spring-boot:run"

echo All services have been started!
echo You can access the services at:
echo Eureka Server: http://localhost:8761
echo API Gateway: http://localhost:8080
echo Chemistry Service: http://localhost:8081
echo User Service: http://localhost:8082
echo Learning Progress Service: http://localhost:8083
pause