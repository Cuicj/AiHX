@echo off

REM 进入脚本所在目录
cd /d "%~dp0"

echo 正在停止MySQL容器...
docker-compose -f docker-compose-mysql.yml down

echo MySQL容器已停止！
echo 按任意键退出...
pause >nul
