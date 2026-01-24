@echo off

echo ==============================
echo Chemistry Learning Microservice Project - Docker Build Script
echo ==============================

REM Check if Docker is installed
where docker >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: Docker is not installed or not added to PATH environment variable
    echo Please install Docker Desktop and restart your computer first
    pause
    exit /b 1
)

REM Check if Docker Compose is installed
where docker-compose >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: Docker Compose is not installed
    echo Please install Docker Compose first
    pause
    exit /b 1
)

REM Check if Maven is installed
where mvn >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: Maven is not installed or not added to PATH environment variable
    echo Please install Maven and configure environment variables first
    pause
    exit /b 1
)

echo Step 1: Build Maven project...
echo ==============================
cd /d f:\TEST\CMateData
mvn clean install -DskipTests

if %errorlevel% neq 0 (
    echo Error: Maven build failed
    pause
    exit /b 1
)

echo Step 2: Build Docker images...
echo ==============================
docker-compose build

if %errorlevel% neq 0 (
    echo Error: Docker image build failed
    pause
    exit /b 1
)

echo Step 3: View build results...
echo ==============================
docker images | findstr "cmatedata"

echo ==============================
echo Docker build completed successfully!
echo ==============================
echo Available commands:
echo 1. Start all services: docker-compose up -d
echo 2. Stop all services: docker-compose down
echo 3. View service status: docker-compose ps
echo 4. View service logs: docker-compose logs [service name]
echo ==============================

pause