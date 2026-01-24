@echo off

echo ==============================
echo 启动Harbor私有镜像仓库
echo ==============================

cd /d f:\TEST\CMateData\harbor

echo 步骤1: 检查Docker是否安装...
echo ==============================
where docker >nul 2>nul
if %errorlevel% neq 0 (
    echo 错误: Docker未安装或未添加到PATH环境变量
    echo 请先安装Docker Desktop并重启电脑
    pause
    exit /b 1
)

echo 步骤2: 启动Harbor服务...
echo ==============================
docker-compose up -d

if %errorlevel% neq 0 (
    echo 错误: Harbor服务启动失败
    pause
    exit /b 1
)

echo 步骤3: 查看服务状态...
echo ==============================
docker-compose ps

echo ==============================
echo Harbor启动完成!
echo ==============================
echo 访问地址:
echo 1. Web界面: http://localhost:8081
echo 2. Docker Registry: http://localhost:5000
echo ==============================
echo 登录信息:
echo 用户名: admin
echo 密码: Harbor12345
echo ==============================

pause