Write-Host "Starting Chemistry Learning Project Services..." -ForegroundColor Green

# 启动Eureka Server
Write-Host "Starting Eureka Server..." -ForegroundColor Cyan
Start-Process -FilePath "powershell.exe" -ArgumentList "-NoExit", "-Command", "cd 'f:\TEST\CMateData\eureka-server'; mvn spring-boot:run"

# 等待Eureka Server启动
Write-Host "Waiting for Eureka Server to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# 启动API Gateway
Write-Host "Starting API Gateway..." -ForegroundColor Cyan
Start-Process -FilePath "powershell.exe" -ArgumentList "-NoExit", "-Command", "cd 'f:\TEST\CMateData\api-gateway'; mvn spring-boot:run"

# 等待API Gateway启动
Write-Host "Waiting for API Gateway to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# 启动Chemistry Service
Write-Host "Starting Chemistry Service..." -ForegroundColor Cyan
Start-Process -FilePath "powershell.exe" -ArgumentList "-NoExit", "-Command", "cd 'f:\TEST\CMateData\chemistry-service'; mvn spring-boot:run"

# 等待Chemistry Service启动
Write-Host "Waiting for Chemistry Service to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# 启动User Service
Write-Host "Starting User Service..." -ForegroundColor Cyan
Start-Process -FilePath "powershell.exe" -ArgumentList "-NoExit", "-Command", "cd 'f:\TEST\CMateData\user-service'; mvn spring-boot:run"

# 等待User Service启动
Write-Host "Waiting for User Service to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# 启动Learning Progress Service
Write-Host "Starting Learning Progress Service..." -ForegroundColor Cyan
Start-Process -FilePath "powershell.exe" -ArgumentList "-NoExit", "-Command", "cd 'f:\TEST\CMateData\learning-progress-service'; mvn spring-boot:run"

# 启动Data Source Service
Write-Host "Starting Data Source Service..." -ForegroundColor Cyan
Start-Process -FilePath "powershell.exe" -ArgumentList "-NoExit", "-Command", "cd 'f:\TEST\CMateData\data-source-service'; mvn spring-boot:run"

# 等待Data Source Service启动
Write-Host "Waiting for Data Source Service to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# 启动AI Service
Write-Host "Starting AI Service..." -ForegroundColor Cyan
Start-Process -FilePath "powershell.exe" -ArgumentList "-NoExit", "-Command", "cd 'f:\TEST\CMateData\ai-service'; mvn spring-boot:run"

# 等待AI Service启动
Write-Host "Waiting for AI Service to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# 启动Task Management Service
Write-Host "Starting Task Management Service..." -ForegroundColor Cyan
Start-Process -FilePath "powershell.exe" -ArgumentList "-NoExit", "-Command", "cd 'f:\TEST\CMateData\task-management-service'; mvn spring-boot:run"

Write-Host "All services have been started!" -ForegroundColor Green
Write-Host "You can access the services at:" -ForegroundColor White
Write-Host "Eureka Server: http://localhost:8761" -ForegroundColor White
Write-Host "API Gateway: http://localhost:8080" -ForegroundColor White
Write-Host "Chemistry Service: http://localhost:8081" -ForegroundColor White
Write-Host "User Service: http://localhost:8082" -ForegroundColor White
Write-Host "Learning Progress Service: http://localhost:8085" -ForegroundColor White
Write-Host "Data Source Service: http://localhost:8086" -ForegroundColor White
Write-Host "AI Service: http://localhost:8087" -ForegroundColor White
Write-Host "Task Management Service: http://localhost:8088" -ForegroundColor White

Write-Host "Press Enter to exit..." -ForegroundColor Yellow
Read-Host