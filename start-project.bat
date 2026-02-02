@echo off

REM CMateData Project Auto Start Script
REM Function: Automatically start all necessary services

cls
echo =======================================
echo CMateData Project Auto Start Script
echo =======================================
echo.

REM Check necessary dependencies
echo Checking necessary dependencies...
echo.

REM Check Java
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Java not found
    pause
    exit /b 1
)

REM Check Maven
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Maven not found
    pause
    exit /b 1
)

echo ✓ Dependencies checked successfully
echo.

REM Start Eureka Server
echo Starting Eureka Server (Port: 8761)...
echo.
start "Eureka Server" cmd /k "cd eureka-server && mvn spring-boot:run"
echo Eureka Server started
echo Waiting 10 seconds for service to start...
timeout /t 10 /nobreak >nul
echo.

REM Start API Gateway
echo Starting API Gateway (Port: 8080)...
echo.
start "API Gateway" cmd /k "cd api-gateway && mvn spring-boot:run"
echo API Gateway started
echo Waiting 10 seconds for service to start...
timeout /t 10 /nobreak >nul
echo.

REM Start User Auth Service
echo Starting User Auth Service (Port: 8081)...
echo.
start "User Auth Service" cmd /k "cd user-auth-service && mvn spring-boot:run"
echo User Auth Service started
echo Waiting 10 seconds for service to start...
timeout /t 10 /nobreak >nul
echo.

REM Display startup status
echo =======================================
echo Startup completed! Service status:
echo =======================================
echo Eureka Server: http://localhost:8761
echo API Gateway: http://localhost:8080
echo User Auth Service: http://localhost:8081
echo.
echo =======================================
echo Access information:
echo =======================================
echo Frontend page: http://localhost:8080
echo Eureka console: http://localhost:8761
echo.
echo Press any key to exit...
pause >nul
