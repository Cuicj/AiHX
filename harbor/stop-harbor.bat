@echo off

echo ==============================
echo 停止Harbor私有镜像仓库
echo ==============================

cd /d f:\TEST\CMateData\harbor

echo 步骤1: 停止Harbor服务...
echo ==============================
docker-compose down

if %errorlevel% neq 0 (
    echo 错误: Harbor服务停止失败
    pause
    exit /b 1
)

echo 步骤2: 查看服务状态...
echo ==============================
docker-compose ps

echo ==============================
echo Harbor停止完成!
echo ==============================

pause