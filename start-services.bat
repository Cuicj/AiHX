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

:: 启动User Auth Service
echo Starting User Auth Service...
start cmd /k "cd f:\TEST\CMateData\user-auth-service && mvn spring-boot:run"
:: 等待User Auth Service启动
timeout 5 > nul

:: 启动Resource Service
echo Starting Resource Service...
start cmd /k "cd f:\TEST\CMateData\resource-service && mvn spring-boot:run"
:: 等待Resource Service启动
timeout 5 > nul

:: 启动Chemistry Content Service
echo Starting Chemistry Content Service...
start cmd /k "cd f:\TEST\CMateData\chemistry-content-service && mvn spring-boot:run"
:: 等待Chemistry Content Service启动
timeout 5 > nul

:: 启动Quiz Service
echo Starting Quiz Service...
start cmd /k "cd f:\TEST\CMateData\quiz-service && mvn spring-boot:run"
:: 等待Quiz Service启动
timeout 5 > nul

:: 启动Reward Service
echo Starting Reward Service...
start cmd /k "cd f:\TEST\CMateData\reward-service && mvn spring-boot:run"
:: 等待Reward Service启动
timeout 5 > nul

:: 启动Learning Service
echo Starting Learning Service...
start cmd /k "cd f:\TEST\CMateData\learning-service && mvn spring-boot:run"
:: 等待Learning Service启动
timeout 5 > nul

:: 启动Task Management Service
echo Starting Task Management Service...
start cmd /k "cd f:\TEST\CMateData\task-management-service && mvn spring-boot:run"

:: 启动NFT Marketplace Service
echo Starting NFT Marketplace Service...
start cmd /k "cd f:\TEST\CMateData\nft-marketplace-service && mvn spring-boot:run"

:: 等待所有服务启动
echo 所有服务启动中，请等待10秒...
timeout /t 10 /nobreak >nul

echo All services have been started!
echo You can access the services at:
echo Eureka Server: http://localhost:8761
echo API Gateway: https://localhost:8443
echo User Auth Service: http://localhost:8081
echo Resource Service: http://localhost:8082
echo Chemistry Content Service: http://localhost:8083
echo Quiz Service: http://localhost:8084
echo Reward Service: http://localhost:8085
echo Learning Service: http://localhost:8086
echo Task Management Service: http://localhost:8087
echo NFT Marketplace Service: http://localhost:8088
echo 定时任务管理页面: https://localhost:8443/tasks.html
echo NFT商城页面: https://localhost:8443/nft-marketplace.html
pause