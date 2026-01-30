#!/usr/bin/env pwsh

# 构建和测试脚本
# 功能：代码检验、单元测试、调优、自动提交、更新文档

Write-Host "=== 开始构建和测试流程 ==="

# 1. 代码检验
Write-Host "1. 执行代码检验..."
Set-Location "f:\TEST\CMateData"

# 检查Maven是否可用
Write-Host "   检查Maven是否可用..."
$mvnCheck = Get-Command mvn -ErrorAction SilentlyContinue
if ($mvnCheck) {
    Write-Host "   Maven 可用: $($mvnCheck.Source)"
} else {
    Write-Host "错误：Maven未安装或不在PATH中"
    exit 1
}

# 运行Maven构建和测试
Write-Host "2. 运行Maven构建和测试..."
mvn clean test -DskipTests=false
if ($LASTEXITCODE -ne 0) {
    Write-Host "构建或测试失败"
    exit 1
}

# 3. 性能调优检查
Write-Host "3. 执行性能调优检查..."

# 检查是否有未使用的导入
Write-Host "   检查未使用的导入..."
mvn dependency:analyze
if ($LASTEXITCODE -ne 0) {
    Write-Host "依赖分析过程中出错"
}

# 4. 自动提交
Write-Host "4. 执行自动提交..."

# 检查是否有更改
$changes = git status --porcelain
if ($changes) {
    Write-Host "   发现更改，执行提交..."
    git add .
    git commit -m "自动提交：构建和测试通过"
    git push
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   提交成功"
    } else {
        Write-Host "   提交失败"
    }
} else {
    Write-Host "   没有发现更改，跳过提交"
}

# 5. 更新文档
Write-Host "5. 更新文档说明..."

# 检查README.md是否存在
$readmePath = "f:\TEST\CMateData\README.md"
if (Test-Path $readmePath) {
    Write-Host "   README.md 存在，跳过更新"
} else {
    Write-Host "   README.md 不存在，创建默认文档"
    # 使用简单的字符串，避免PowerShell的特殊字符问题
    $defaultContent = "# 项目说明"
    Add-Content -Path $readmePath -Value $defaultContent
    Add-Content -Path $readmePath -Value ""
    Add-Content -Path $readmePath -Value "## 项目简介"
    Add-Content -Path $readmePath -Value ""
    Add-Content -Path $readmePath -Value "这是一个Spring Boot项目。"
    Add-Content -Path $readmePath -Value ""
    Add-Content -Path $readmePath -Value "## 版本管理"
    Add-Content -Path $readmePath -Value ""
    Add-Content -Path $readmePath -Value "| 版本 | 日期 | 描述 |"
    Add-Content -Path $readmePath -Value "|------|------|------|"
    Add-Content -Path $readmePath -Value "| 1.0.0 | $(Get-Date -Format 'yyyy-MM-dd') | 初始版本 |"
    Write-Host "   README.md 创建成功"
}

Write-Host "=== 构建和测试流程完成 ==="
