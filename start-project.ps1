#!/usr/bin/env powershell

# 项目自动启动脚本
# 功能：自动启动所有必要的服务，包括Eureka Server、API Gateway、User Auth Service等

Write-Host "=======================================" -ForegroundColor Green
Write-Host "CMateData 项目自动启动脚本" -ForegroundColor Green
Write-Host "=======================================" -ForegroundColor Green

# 检查必要的依赖
function Check-Dependencies {
    Write-Host "正在检查必要的依赖..." -ForegroundColor Cyan
    
    # 检查Java
    $javaVersion = java -version 2>&1
    if ($javaVersion -match "1\.8") {
        Write-Host "警告: 检测到Java 8，Spring Boot 3.3.0需要Java 17+" -ForegroundColor Yellow
        return $false
    } elseif ($javaVersion -match "17") {
        Write-Host "✓ Java 17 已安装" -ForegroundColor Green
    } else {
        Write-Host "错误: 未检测到Java 17" -ForegroundColor Red
        return $false
    }
    
    # 检查Maven
    $mavenVersion = mvn -version 2>&1
    if ($mavenVersion -match "3\.6\.[3-9]" -or $mavenVersion -match "3\.[7-9]") {
        Write-Host "✓ Maven 3.6.3+ 已安装" -ForegroundColor Green
    } else {
        Write-Host "警告: Maven版本可能不兼容，建议使用3.6.3+" -ForegroundColor Yellow
    }
    
    return $true
}

# 启动服务
function Start-Service {
    param(
        [string]$ServiceName,
        [string]$ServicePath,
        [string]$Port
    )
    
    Write-Host "\n正在启动 $ServiceName (端口: $Port)..." -ForegroundColor Cyan
    
    # 检查端口是否已被占用
    $portInUse = netstat -ano | Select-String ":$Port "
    if ($portInUse) {
        Write-Host "警告: 端口 $Port 已被占用，可能需要先停止占用该端口的进程" -ForegroundColor Yellow
        $processId = $portInUse.ToString().Split(' ')[-1]
        Write-Host "占用端口的进程ID: $processId" -ForegroundColor Yellow
        
        # 提示用户是否终止占用端口的进程
        $response = Read-Host "是否终止占用端口的进程? (Y/N)"
        if ($response -eq "Y" -or $response -eq "y") {
            taskkill /PID $processId /F
            Write-Host "已终止进程 $processId" -ForegroundColor Green
        }
    }
    
    # 启动服务
    Push-Location $ServicePath
    try {
        # 使用start-process在后台启动服务
        $process = Start-Process "mvn" -ArgumentList "spring-boot:run" -PassThru -WindowStyle Normal
        Write-Host "$ServiceName 已启动，进程ID: $($process.Id)" -ForegroundColor Green
        
        # 等待服务启动
        Write-Host "正在等待 $ServiceName 启动完成..." -ForegroundColor Cyan
        Start-Sleep -Seconds 10
        
        # 检查服务是否启动成功
        $serviceUp = $false
        for ($i = 0; $i -lt 30; $i++) {
            try {
                $response = Invoke-WebRequest -Uri "http://localhost:$Port" -UseBasicParsing -ErrorAction SilentlyContinue
                if ($response.StatusCode -eq 200) {
                    $serviceUp = $true
                    break
                }
            } catch {
                # 服务未就绪，继续等待
            }
            Start-Sleep -Seconds 2
        }
        
        if ($serviceUp) {
            Write-Host "✓ $ServiceName 启动成功!" -ForegroundColor Green
        } else {
            Write-Host "⚠ $ServiceName 启动可能失败，请检查日志" -ForegroundColor Yellow
        }
        
        return $process
    } catch {
        Write-Host "错误: 启动 $ServiceName 失败: $($_.Exception.Message)" -ForegroundColor Red
        return $null
    } finally {
        Pop-Location
    }
}

# 主启动函数
function Start-Project {
    # 检查依赖
    if (-not (Check-Dependencies)) {
        Write-Host "依赖检查失败，是否继续启动?" -ForegroundColor Yellow
        $response = Read-Host "(Y/N)"
        if ($response -ne "Y" -and $response -ne "y") {
            Write-Host "启动已取消" -ForegroundColor Red
            return
        }
    }
    
    # 定义服务配置
    $services = @(
        @{
            Name = "Eureka Server"
            Path = "eureka-server"
            Port = "8761"
            Description = "服务注册与发现中心"
        },
        @{
            Name = "API Gateway"
            Path = "api-gateway"
            Port = "8080"
            Description = "API网关，处理所有请求路由"
        },
        @{
            Name = "User Auth Service"
            Path = "user-auth-service"
            Port = "8081"
            Description = "用户认证服务"
        }
    )
    
    # 启动服务
    $processes = @()
    
    foreach ($service in $services) {
        $process = Start-Service -ServiceName $service.Name -ServicePath $service.Path -Port $service.Port
        if ($process) {
            $processes += $process
        }
    }
    
    # 显示启动状态
    Write-Host "\n=======================================" -ForegroundColor Green
    Write-Host "启动完成! 服务状态:" -ForegroundColor Green
    Write-Host "=======================================" -ForegroundColor Green
    
    foreach ($service in $services) {
        try {
            $response = Invoke-WebRequest -Uri "http://localhost:$($service.Port)" -UseBasicParsing -ErrorAction SilentlyContinue
            if ($response.StatusCode -eq 200) {
                Write-Host "✓ $($service.Name) : http://localhost:$($service.Port)" -ForegroundColor Green
            } else {
                Write-Host "⚠ $($service.Name) : http://localhost:$($service.Port) (状态未知)" -ForegroundColor Yellow
            }
        } catch {
            Write-Host "✗ $($service.Name) : http://localhost:$($service.Port) (未响应)" -ForegroundColor Red
        }
    }
    
    # 显示访问信息
    Write-Host "\n=======================================" -ForegroundColor Cyan
    Write-Host "访问信息:" -ForegroundColor Cyan
    Write-Host "=======================================" -ForegroundColor Cyan
    Write-Host "前端页面: http://localhost:8080" -ForegroundColor White
    Write-Host "Eureka控制台: http://localhost:8761" -ForegroundColor White
    Write-Host "\n按任意键退出..." -ForegroundColor Cyan
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    
    # 停止服务（可选）
    Write-Host "\n是否停止所有服务? (Y/N)" -ForegroundColor Yellow
    $response = Read-Host
    if ($response -eq "Y" -or $response -eq "y") {
        foreach ($process in $processes) {
            if ($process.HasExited -eq $false) {
                Write-Host "正在停止进程: $($process.Id)..." -ForegroundColor Cyan
                $process.Kill()
                $process.WaitForExit()
                Write-Host "进程 $($process.Id) 已停止" -ForegroundColor Green
            }
        }
    }
}

# 运行主函数
Start-Project
