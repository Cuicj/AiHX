@echo off

echo ==============================
echo 清理当天的Docker资源
echo ==============================

REM 检查Docker是否安装
where docker >nul 2>nul
if %errorlevel% neq 0 (
    echo 错误: Docker未安装或未添加到PATH环境变量
    echo 请先安装Docker Desktop并重启电脑
    pause
    exit /b 1
)

REM 获取当天日期（格式：YYYY-MM-DD）
for /f "tokens=2 delims==" %%i in ('wmic os get localdatetime /value') do set datetime=%%i
set today=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%
echo 当天日期: %today%

REM 清理当天创建的容器
echo 步骤1: 清理当天创建的容器
echo ==============================
docker ps -a --format "{{.CreatedAt}} {{.ID}} {{.Names}}" | findstr "%today%" > containers.txt

if exist containers.txt (
    for /f "tokens=2" %%i in (containers.txt) do (
        echo 清理容器: %%i
        docker rm -f %%i
    )
    del containers.txt
) else (
    echo 当天没有创建的容器
)

REM 清理当天创建的镜像
echo 步骤2: 清理当天创建的镜像
echo ==============================
docker images --format "{{.CreatedSince}} {{.ID}} {{.Repository}}:{{.Tag}}" | findstr "hours ago" > images.txt

if exist images.txt (
    for /f "tokens=2" %%i in (images.txt) do (
        echo 清理镜像: %%i
        docker rmi -f %%i
    )
    del images.txt
) else (
    echo 当天没有创建的镜像
)

REM 清理未使用的卷
echo 步骤3: 清理未使用的卷
echo ==============================
docker volume prune -f

REM 清理Docker系统垃圾
echo 步骤4: 清理Docker系统垃圾
echo ==============================
docker system prune -f

echo ==============================
echo 清理完成!
echo ==============================
echo 已清理以下资源:
echo 1. 当天创建的容器
 echo 2. 当天创建的镜像
 echo 3. 未使用的卷
 echo 4. Docker系统垃圾

echo ==============================
echo 建议: 可以将此脚本添加到Windows任务计划程序中，每天自动执行
pause