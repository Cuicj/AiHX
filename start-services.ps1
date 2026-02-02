Write-Host "Starting Chemistry Learning Project Services..."

# Start Eureka Server
Write-Host "Starting Eureka Server..."
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location 'f:\TEST\CMateData\eureka-server'; mvn spring-boot:run"
# Wait for Eureka Server to start
Start-Sleep -Seconds 10

# Start API Gateway
Write-Host "Starting API Gateway..."
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location 'f:\TEST\CMateData\api-gateway'; mvn spring-boot:run"
# Wait for API Gateway to start
Start-Sleep -Seconds 5

# Start User Auth Service
Write-Host "Starting User Auth Service..."
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location 'f:\TEST\CMateData\user-auth-service'; mvn spring-boot:run"
# Wait for User Auth Service to start
Start-Sleep -Seconds 5

# Start Resource Service
Write-Host "Starting Resource Service..."
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location 'f:\TEST\CMateData\resource-service'; mvn spring-boot:run"
# Wait for Resource Service to start
Start-Sleep -Seconds 5

# Start Chemistry Content Service
Write-Host "Starting Chemistry Content Service..."
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location 'f:\TEST\CMateData\chemistry-content-service'; mvn spring-boot:run"
# Wait for Chemistry Content Service to start
Start-Sleep -Seconds 5

# Start Quiz Service
Write-Host "Starting Quiz Service..."
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location 'f:\TEST\CMateData\quiz-service'; mvn spring-boot:run"
# Wait for Quiz Service to start
Start-Sleep -Seconds 5

# Start Reward Service
Write-Host "Starting Reward Service..."
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location 'f:\TEST\CMateData\reward-service'; mvn spring-boot:run"
# Wait for Reward Service to start
Start-Sleep -Seconds 5

# Start Learning Service
Write-Host "Starting Learning Service..."
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location 'f:\TEST\CMateData\learning-service'; mvn spring-boot:run"
# Wait for Learning Service to start
Start-Sleep -Seconds 5

# Start Task Management Service
Write-Host "Starting Task Management Service..."
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location 'f:\TEST\CMateData\task-management-service'; mvn spring-boot:run"

# Start NFT Marketplace Service
Write-Host "Starting NFT Marketplace Service..."
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Set-Location 'f:\TEST\CMateData\nft-marketplace-service'; mvn spring-boot:run"

# Wait for all services to start
Write-Host "所有服务启动中，请等待10秒..."
Start-Sleep -Seconds 10

Write-Host "All services have been started!"
Write-Host "You can access the services at:"
Write-Host "Eureka Server: http://localhost:8761"
Write-Host "API Gateway: https://localhost:8443"
Write-Host "User Auth Service: http://localhost:8081"
Write-Host "Resource Service: http://localhost:8082"
Write-Host "Chemistry Content Service: http://localhost:8083"
Write-Host "Quiz Service: http://localhost:8084"
Write-Host "Reward Service: http://localhost:8085"
Write-Host "Learning Service: http://localhost:8086"
Write-Host "Task Management Service: http://localhost:8087"
Write-Host "NFT Marketplace Service: http://localhost:8088"
Write-Host "定时任务管理页面: https://localhost:8443/tasks.html"
Write-Host "NFT商城页面: https://localhost:8443/nft-marketplace.html"
