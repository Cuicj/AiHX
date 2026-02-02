@echo off

REM 项目自动启动脚本
REM 功能：自动启动所有必要的服务

echo =======================================
echo CMateData 项目自动启动脚本
echo =======================================
echo.

REM 检查PowerShell是否可用
powershell -Command "Write-Host 'PowerShell 可用'" >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: PowerShell 不可用
    pause
    exit /b 1
)

REM 运行PowerShell启动脚本
powershell -ExecutionPolicy Bypass -File "%~dp0start-project.ps1"

pause
