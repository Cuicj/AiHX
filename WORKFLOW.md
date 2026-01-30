# 代码开发工作流程

## 概述

本文档描述了项目的标准开发工作流程，包括代码检验、单元测试、性能调优、自动提交和文档更新等步骤。遵循此工作流程可以确保代码质量、提高开发效率，并保持代码库的整洁和可维护性。

## 工作流程步骤

### 1. 代码开发

- **遵循代码规范**：使用项目现有的代码风格和命名约定
- **编写可测试的代码**：确保代码模块化、依赖注入和可测试性
- **使用常量库**：对于重复使用的值，使用常量库而不是硬编码
- **添加注释**：对于复杂的逻辑，添加清晰的注释说明

### 2. 代码检验

- **静态代码分析**：使用Maven的依赖分析工具检查未使用的导入和依赖
- **编译检查**：确保代码能够成功编译，无语法错误
- **类型检查**：确保类型安全，无类型转换错误

### 3. 单元测试

- **创建测试文件**：为每个服务和组件创建对应的测试文件
- **测试覆盖率**：确保关键功能都有测试覆盖
- **测试边界情况**：测试空值、边界值和异常情况
- **使用Mockito**：对于外部依赖，使用Mockito进行模拟

### 4. 性能调优

- **优化常量使用**：使用常量库减少运行时字符串创建
- **减少重复计算**：缓存频繁计算的结果
- **优化数据库查询**：使用索引和适当的查询策略
- **减少网络调用**：批量处理和缓存网络响应

### 5. 自动提交

- **构建和测试通过后**：只有当构建和测试都通过时，才执行自动提交
- **提交消息**：使用清晰、描述性的提交消息
- **推送更改**：自动将更改推送到远程仓库

### 6. 文档更新

- **更新README.md**：添加新功能、API变更和版本历史
- **更新配置说明**：对于新的配置项，添加详细说明
- **更新架构图**：如果架构发生变化，更新架构图

## 工具和脚本

### 构建和测试脚本

项目提供了`scripts/build-and-test.ps1`脚本，用于自动化执行构建、测试、调优、提交和文档更新流程。

**使用方法**：

```powershell
# 在项目根目录执行
.criptsuild-and-test.ps1
```

### 测试框架

- **JUnit 5**：用于编写单元测试
- **Mockito**：用于模拟外部依赖
- **Spring Boot Test**：用于集成测试

### 代码质量工具

- **Maven Dependency Analyzer**：检查未使用的依赖
- **Spring Boot Actuator**：监控应用性能

## 测试文件结构

```
src/
├── main/java/         # 主代码
└── test/java/         # 测试代码
    └── com/cmatedata/  # 包结构
        └── [service]/  # 服务名称
            └── service/ # 服务实现
                └── *Test.java # 测试文件
```

## 示例测试文件

### WordFilterServiceTest.java

```java
package com.cmatedata.aiservice.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@TestPropertySource(properties = {
        "forbidden.words=test,bad,evil",
        "forbidden.words.file=classpath:forbidden-words.txt"
})
class WordFilterServiceTest {

    private WordFilterService wordFilterService;

    @BeforeEach
    void setUp() {
        wordFilterService = new WordFilterService();
        wordFilterService.init();
    }

    @Test
    void testFilterText() {
        String originalText = "This is a test with bad words and evil content";
        String filteredText = wordFilterService.filterText(originalText);
        assertEquals("This is a *** with *** words and *** content", filteredText);
    }

    @Test
    void testContainsForbiddenWords() {
        String textWithForbiddenWords = "This contains bad words";
        String textWithoutForbiddenWords = "This is clean";
        assertTrue(wordFilterService.containsForbiddenWords(textWithForbiddenWords));
        assertFalse(wordFilterService.containsForbiddenWords(textWithoutForbiddenWords));
    }
}
```

## 最佳实践

1. **每次更改后运行测试**：确保更改不会破坏现有功能
2. **提交前运行完整构建**：确保所有测试都通过
3. **定期更新文档**：保持文档与代码同步
4. **使用常量库**：提高性能和可维护性
5. **编写清晰的测试**：测试应该易于理解和维护

## 故障排除

### 测试失败

- **检查测试依赖**：确保所有测试依赖都已正确配置
- **检查测试环境**：确保测试环境与生产环境一致
- **检查模拟对象**：确保模拟对象的行为符合预期

### 构建失败

- **检查依赖冲突**：使用`mvn dependency:tree`检查依赖冲突
- **检查Java版本**：确保使用的Java版本符合项目要求
- **检查Maven配置**：确保Maven配置正确

### 提交失败

- **检查Git配置**：确保Git已正确配置用户名和邮箱
- **检查网络连接**：确保能够连接到远程仓库
- **检查权限**：确保有推送到远程仓库的权限

## 结论

遵循此工作流程可以确保代码质量、提高开发效率，并保持代码库的整洁和可维护性。通过自动化脚本，可以减少手动操作，提高开发速度，同时确保所有步骤都被正确执行。
