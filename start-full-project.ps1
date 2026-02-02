#!/usr/bin/env powershell

# CMateData Full Project Auto Start Script
# Function: Automatically start MySQL, Redis, and all necessary services

Write-Host "=======================================" -ForegroundColor Green
Write-Host "CMateData Full Project Auto Start Script" -ForegroundColor Green
Write-Host "=======================================" -ForegroundColor Green

# Check necessary dependencies
Write-Host "Checking necessary dependencies..." -ForegroundColor Cyan
Write-Host ""

# Set Java 17 as the default for this session
$javaHome = "C:\Program Files\Java\jdk-17"
if (-not (Test-Path $javaHome)) {
    Write-Host "Error: Java 17 not found at $javaHome" -ForegroundColor Red
    Read-Host "Press any key to exit..."
    exit 1
}

$env:JAVA_HOME = $javaHome
$env:PATH = "$javaHome\bin;$env:PATH"

# Check Java
$javaVersion = java -version 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Java not found" -ForegroundColor Red
    Read-Host "Press any key to exit..."
    exit 1
}

# Check Maven
$mavenPath = "F:\TEST\CMateData\maven\apache-maven-3.6.3\bin\mvn"
$mavenVersion = & $mavenPath -version 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Maven not found" -ForegroundColor Red
    Read-Host "Press any key to exit..."
    exit 1
}

Write-Host "✓ Dependencies checked successfully" -ForegroundColor Green
Write-Host ""

# Start MySQL
Write-Host "Starting MySQL..." -ForegroundColor Cyan
Write-Host ""
try {
    # Check if MySQL service is running
    $mysqlStatus = Get-Service -Name "MySQL*" -ErrorAction SilentlyContinue
    if ($mysqlStatus -and $mysqlStatus.Status -eq "Running") {
        Write-Host "✓ MySQL is already running" -ForegroundColor Green
    } else {
        # Start MySQL service
        Start-Service -Name "MySQL*" -ErrorAction SilentlyContinue
        Write-Host "✓ MySQL started" -ForegroundColor Green
    }
} catch {
    Write-Host "⚠️  MySQL service not found or failed to start" -ForegroundColor Yellow
    Write-Host "Continuing with other services..." -ForegroundColor Cyan
}
Write-Host ""

# Start Redis
Write-Host "Starting Redis..." -ForegroundColor Cyan
Write-Host ""
$redisPath = "D:\redis\Redis-x64-3.2.100"
$redisExe = "$redisPath\redis-server.exe"

if (Test-Path $redisExe) {
    # Check if Redis is already running
    $redisProcess = Get-Process | Where-Object { $_.ProcessName -eq "redis-server" }
    if ($redisProcess) {
        Write-Host "✓ Redis is already running" -ForegroundColor Green
    } else {
        # Start Redis
        Start-Process -FilePath $redisExe -WorkingDirectory $redisPath -WindowStyle Normal
        Write-Host "✓ Redis started" -ForegroundColor Green
    }
} else {
    Write-Host "⚠️  Redis not found at $redisExe" -ForegroundColor Yellow
    Write-Host "Continuing with other services..." -ForegroundColor Cyan
}
Write-Host ""

# Wait for MySQL and Redis to start
Write-Host "Waiting 5 seconds for MySQL and Redis to initialize..." -ForegroundColor Cyan
Start-Sleep -Seconds 5
Write-Host ""

# Start Eureka Server
Write-Host "Starting Eureka Server (Port: 8761)..." -ForegroundColor Cyan
Write-Host ""
$eurekaProcess = Start-Process "$mavenPath" -ArgumentList "spring-boot:run" -WorkingDirectory "eureka-server" -PassThru -WindowStyle Normal
Write-Host "Eureka Server started, Process ID: $($eurekaProcess.Id)" -ForegroundColor Green
Write-Host "Waiting 15 seconds for service to start..." -ForegroundColor Cyan
Start-Sleep -Seconds 15
Write-Host ""

# Start API Gateway
Write-Host "Starting API Gateway (Port: 8080)..." -ForegroundColor Cyan
Write-Host ""
$gatewayProcess = Start-Process "$mavenPath" -ArgumentList "spring-boot:run" -WorkingDirectory "api-gateway" -PassThru -WindowStyle Normal
Write-Host "API Gateway started, Process ID: $($gatewayProcess.Id)" -ForegroundColor Green
Write-Host "Waiting 15 seconds for service to start..." -ForegroundColor Cyan
Start-Sleep -Seconds 15
Write-Host ""

# Start User Auth Service
Write-Host "Starting User Auth Service (Port: 8081)..." -ForegroundColor Cyan
Write-Host ""
$authProcess = Start-Process "$mavenPath" -ArgumentList "spring-boot:run" -WorkingDirectory "user-auth-service" -PassThru -WindowStyle Normal
Write-Host "User Auth Service started, Process ID: $($authProcess.Id)" -ForegroundColor Green
Write-Host "Waiting 15 seconds for service to start..." -ForegroundColor Cyan
Start-Sleep -Seconds 15
Write-Host ""

# Display startup status
Write-Host "=======================================" -ForegroundColor Green
Write-Host "Startup completed! Service status:" -ForegroundColor Green
Write-Host "=======================================" -ForegroundColor Green
Write-Host "MySQL: Checked and started if needed" -ForegroundColor White
Write-Host "Redis: Checked and started if needed" -ForegroundColor White
Write-Host "Eureka Server: http://localhost:8761" -ForegroundColor White
Write-Host "API Gateway: http://localhost:8080" -ForegroundColor White
Write-Host "User Auth Service: http://localhost:8081" -ForegroundColor White
Write-Host ""
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host "Access information:" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host "Frontend page: http://localhost:8080" -ForegroundColor White
Write-Host "Eureka console: http://localhost:8761" -ForegroundColor White
Write-Host ""
Write-Host "Press any key to exit..." -ForegroundColor Cyan
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
