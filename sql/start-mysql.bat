@echo off

REM 进入脚本所在目录
cd /d "%~dp0"

echo 正在启动MySQL容器...
docker-compose -f docker-compose-mysql.yml up -d

echo MySQL容器启动中，请稍候...
timeout /t 10 /nobreak >nul

echo 正在检查MySQL容器状态...
docker ps -a | findstr mysql-chemistry

echo 正在查看MySQL初始化日志...
docker logs mysql-chemistry --tail=50

echo MySQL数据库初始化完成！
echo 数据库连接信息：
echo - 主机：localhost

echo - 端口：3306

echo - 数据库：chemistry_learning

echo - 用户名：root

echo - 密码：123456

echo 您可以使用以下命令停止MySQL容器：
echo docker-compose -f docker-compose-mysql.yml down

echo 按任意键退出...
pause >nul
