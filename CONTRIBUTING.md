# 🤝 贡献指南

感谢您对 Star Trek 项目的关注！我们欢迎所有形式的贡献，无论是代码、文档、设计还是反馈建议。

## 📋 目录

- [贡献方式](#贡献方式)
- [开发环境设置](#开发环境设置)
- [代码贡献流程](#代码贡献流程)
- [编码规范](#编码规范)
- [提交规范](#提交规范)
- [问题报告](#问题报告)
- [功能建议](#功能建议)
- [文档贡献](#文档贡献)
- [社区准则](#社区准则)

## 🎯 贡献方式

### 代码贡献
- 修复 bug
- 实现新功能
- 性能优化
- 代码重构
- 测试用例编写

### 非代码贡献
- 文档改进
- UI/UX 设计
- 翻译工作
- 问题反馈
- 功能建议
- 代码审查

## 🔧 开发环境设置

### 前置要求

1. **Flutter SDK**
   ```bash
   # 安装 Flutter (推荐使用 Flutter 3.16+)
   git clone https://github.com/flutter/flutter.git
   export PATH="$PATH:`pwd`/flutter/bin"
   
   # 验证安装
   flutter doctor
   ```

2. **开发工具**
   - **推荐**: VS Code + Flutter 扩展
   - **备选**: Android Studio + Flutter 插件
   - **备选**: IntelliJ IDEA + Dart/Flutter 插件

3. **平台工具**
   ```bash
   # iOS 开发 (macOS)
   xcode-select --install
   
   # Android 开发
   # 安装 Android Studio 和 Android SDK
   
   # Web 开发
   flutter config --enable-web
   ```

### 项目设置

1. **Fork 项目**
   - 访问 [Star Trek GitHub 页面](https://github.com/zhawei98213/star_trek)
   - 点击右上角的 "Fork" 按钮

2. **克隆项目**
   ```bash
   git clone https://github.com/YOUR_USERNAME/star_trek.git
   cd star_trek
   ```

3. **添加上游仓库**
   ```bash
   git remote add upstream https://github.com/zhawei98213/star_trek.git
   ```

4. **安装依赖**
   ```bash
   flutter pub get
   ```

5. **运行项目**
   ```bash
   # 检查可用设备
   flutter devices
   
   # 运行应用
   flutter run
   
   # 指定设备运行
   flutter run -d "iPhone 15 Pro"
   ```

### 开发工具配置

#### VS Code 配置

创建 `.vscode/settings.json`：

```json
{
  "dart.flutterSdkPath": "/path/to/flutter",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll": true
  },
  "dart.lineLength": 80,
  "dart.showTodos": true,
  "files.associations": {
    "*.dart": "dart"
  }
}
```

创建 `.vscode/launch.json`：

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "star_trek",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "args": ["--flavor", "development"]
    },
    {
      "name": "star_trek (profile mode)",
      "request": "launch",
      "type": "dart",
      "flutterMode": "profile",
      "program": "lib/main.dart"
    }
  ]
}
```

## 🔄 代码贡献流程

### 1. 选择任务

- 查看 [Issues](https://github.com/zhawei98213/star_trek/issues) 页面
- 寻找标有 `good first issue` 或 `help wanted` 的问题
- 在 Issue 中评论表明您想要处理该问题

### 2. 创建分支

```bash
# 确保主分支是最新的
git checkout main
git pull upstream main

# 创建新的功能分支
git checkout -b feature/your-feature-name

# 或者修复分支
git checkout -b fix/issue-number-description
```

### 3. 开发代码

- 遵循项目的编码规范
- 编写清晰的代码注释
- 添加必要的测试用例
- 确保代码通过所有测试

### 4. 测试代码

```bash
# 运行所有测试
flutter test

# 运行特定测试
flutter test test/features/home/

# 代码分析
flutter analyze

# 格式化代码
dart format .
```

### 5. 提交代码

```bash
# 添加文件
git add .

# 提交代码（遵循提交规范）
git commit -m "feat(home): add responsive layout for iPad"

# 推送到您的 fork
git push origin feature/your-feature-name
```

### 6. 创建 Pull Request

1. 访问您的 fork 页面
2. 点击 "Compare & pull request"
3. 填写 PR 模板
4. 等待代码审查

## 📝 编码规范

### Dart 代码规范

1. **遵循 Effective Dart**
   - [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style)
   - [Effective Dart: Documentation](https://dart.dev/guides/language/effective-dart/documentation)
   - [Effective Dart: Usage](https://dart.dev/guides/language/effective-dart/usage)
   - [Effective Dart: Design](https://dart.dev/guides/language/effective-dart/design)

2. **命名规范**
   ```dart
   // 类名：PascalCase
   class UserProfileWidget {}
   
   // 变量和方法：camelCase
   String userName = 'John';
   void getUserData() {}
   
   // 常量：lowerCamelCase
   const double maxWidth = 400.0;
   
   // 私有成员：下划线前缀
   String _privateField;
   void _privateMethod() {}
   
   // 文件名：snake_case
   user_profile_widget.dart
   ```

3. **代码组织**
   ```dart
   // 导入顺序
   import 'dart:async';  // Dart 核心库
   import 'dart:io';
   
   import 'package:flutter/material.dart';  // Flutter 库
   import 'package:provider/provider.dart';  // 第三方包
   
   import '../core/theme/app_theme.dart';  // 项目内部导入
   import '../shared/widgets/custom_button.dart';
   ```

4. **Widget 编写规范**
   ```dart
   class CustomWidget extends StatelessWidget {
     const CustomWidget({
       super.key,
       required this.title,
       this.subtitle,
       this.onTap,
     });
     
     final String title;
     final String? subtitle;
     final VoidCallback? onTap;
     
     @override
     Widget build(BuildContext context) {
       return Container(
         // Widget 实现
       );
     }
   }
   ```

### 项目特定规范

1. **目录结构**
   ```
   lib/features/feature_name/
   ├── data/
   │   ├── datasources/
   │   ├── models/
   │   └── repositories/
   ├── domain/
   │   ├── entities/
   │   ├── repositories/
   │   └── usecases/
   └── presentation/
       ├── pages/
       ├── widgets/
       └── providers/
   ```

2. **文件命名**
   - 页面：`feature_page.dart`
   - Widget：`feature_widget.dart`
   - Provider：`feature_provider.dart`
   - 模型：`feature_model.dart`
   - 实体：`feature_entity.dart`

3. **注释规范**
   ```dart
   /// 用户资料 Widget
   /// 
   /// 显示用户的基本信息，包括头像、姓名和等级。
   /// 支持点击事件处理。
   class UserProfileWidget extends StatelessWidget {
     /// 创建用户资料 Widget
     /// 
     /// [user] 用户实体对象
     /// [onTap] 点击回调函数
     const UserProfileWidget({
       super.key,
       required this.user,
       this.onTap,
     });
   }
   ```

## 📋 提交规范

### 提交信息格式

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type 类型

- `feat`: 新功能
- `fix`: 修复 bug
- `docs`: 文档更新
- `style`: 代码格式调整（不影响功能）
- `refactor`: 重构（既不是新功能也不是修复）
- `perf`: 性能优化
- `test`: 测试相关
- `chore`: 构建过程或辅助工具的变动
- `ci`: CI/CD 相关变更

### Scope 范围

- `home`: 首页功能
- `auth`: 认证功能
- `learning`: 学习功能
- `profile`: 个人资料
- `core`: 核心功能
- `ui`: UI 组件
- `docs`: 文档

### 示例

```bash
# 新功能
git commit -m "feat(home): add responsive layout for iPad landscape mode"

# 修复 bug
git commit -m "fix(auth): resolve login validation issue"

# 文档更新
git commit -m "docs(readme): update installation instructions"

# 重构
git commit -m "refactor(core): improve error handling mechanism"
```

### 详细提交信息

```
feat(home): add responsive layout for iPad landscape mode

- Implement ResponsiveUtils for screen size detection
- Add tablet-specific sidebar and header components
- Update theme system with tablet spacing constants
- Optimize screen orientation preferences

Closes #123
Breaking change: ResponsiveUtils API has changed
```

## 🐛 问题报告

### 报告 Bug

使用 [Bug Report 模板](https://github.com/zhawei98213/star_trek/issues/new?template=bug_report.md)：

1. **问题描述**: 清晰描述遇到的问题
2. **复现步骤**: 详细的复现步骤
3. **预期行为**: 描述期望的正确行为
4. **实际行为**: 描述实际发生的行为
5. **环境信息**: 
   - Flutter 版本
   - Dart 版本
   - 操作系统
   - 设备信息
6. **截图/录屏**: 如果适用
7. **日志信息**: 相关的错误日志

### 问题标签

- `bug`: 确认的 bug
- `enhancement`: 功能增强
- `question`: 问题咨询
- `documentation`: 文档相关
- `good first issue`: 适合新手
- `help wanted`: 需要帮助
- `priority: high`: 高优先级
- `priority: low`: 低优先级

## 💡 功能建议

使用 [Feature Request 模板](https://github.com/zhawei98213/star_trek/issues/new?template=feature_request.md)：

1. **功能描述**: 详细描述建议的功能
2. **使用场景**: 说明功能的使用场景
3. **解决问题**: 该功能解决什么问题
4. **实现建议**: 如果有实现想法
5. **替代方案**: 是否有其他解决方案
6. **附加信息**: 其他相关信息

## 📚 文档贡献

### 文档类型

- **README**: 项目介绍和快速开始
- **API 文档**: 接口文档和使用说明
- **开发指南**: 开发环境和编码规范
- **部署指南**: 部署流程和配置
- **架构文档**: 技术架构和设计决策
- **用户手册**: 用户使用指南

### 文档规范

1. **Markdown 格式**: 使用标准 Markdown 语法
2. **结构清晰**: 合理的标题层级和目录
3. **内容准确**: 确保信息的准确性和时效性
4. **示例丰富**: 提供充足的代码示例
5. **语言规范**: 使用简洁明了的语言

### 文档更新流程

1. 识别需要更新的文档
2. 创建文档分支
3. 编写或更新文档
4. 本地预览检查
5. 提交 Pull Request
6. 等待审查和合并

## 🎨 设计贡献

### UI/UX 设计

- **设计规范**: 遵循 Material Design 3 规范
- **色彩主题**: 保持星际探险的主题风格
- **无障碍性**: 考虑无障碍用户的需求
- **响应式**: 适配不同屏幕尺寸

### 设计工具

- **Figma**: 推荐使用 Figma 进行设计
- **Sketch**: 备选设计工具
- **Adobe XD**: 备选设计工具

### 设计交付

- 提供设计稿和标注
- 导出所需的图标和图片资源
- 说明设计理念和交互逻辑

## 🧪 测试贡献

### 测试类型

1. **单元测试**: 测试单个函数或类
2. **Widget 测试**: 测试 UI 组件
3. **集成测试**: 测试完整的用户流程
4. **性能测试**: 测试应用性能

### 测试规范

```dart
// 单元测试示例
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserEntity', () {
    test('should create user with valid data', () {
      // arrange
      const userData = {
        'id': '1',
        'name': 'Test User',
        'email': 'test@example.com',
      };
      
      // act
      final user = UserEntity.fromJson(userData);
      
      // assert
      expect(user.id, '1');
      expect(user.name, 'Test User');
      expect(user.email, 'test@example.com');
    });
  });
}
```

### 测试覆盖率

- 目标覆盖率：80% 以上
- 核心业务逻辑：90% 以上
- UI 组件：70% 以上

## 👥 社区准则

### 行为准则

1. **尊重他人**: 尊重所有贡献者和用户
2. **包容性**: 欢迎不同背景的贡献者
3. **建设性**: 提供建设性的反馈和建议
4. **专业性**: 保持专业的沟通方式
5. **耐心**: 对新手保持耐心和友善

### 沟通渠道

- **GitHub Issues**: 问题报告和功能建议
- **GitHub Discussions**: 社区讨论和问答
- **Pull Requests**: 代码审查和讨论
- **Email**: 私人或敏感问题

### 冲突解决

如果遇到冲突或不当行为：

1. 首先尝试私下沟通解决
2. 如果无法解决，联系项目维护者
3. 严重违规行为将被禁止参与项目

## 🏆 贡献者认可

### 贡献类型认可

- **代码贡献**: 在 README 中列出贡献者
- **文档贡献**: 在文档中署名
- **设计贡献**: 在设计相关页面署名
- **测试贡献**: 在测试报告中感谢

### 特殊贡献

- **核心贡献者**: 长期活跃的贡献者
- **专家贡献者**: 在特定领域有突出贡献
- **社区建设者**: 在社区建设方面有贡献

## 📞 联系方式

- **项目维护者**: [zhawei98213](https://github.com/zhawei98213)
- **项目地址**: [https://github.com/zhawei98213/star_trek](https://github.com/zhawei98213/star_trek)
- **问题反馈**: [Issues](https://github.com/zhawei98213/star_trek/issues)
- **功能建议**: [Discussions](https://github.com/zhawei98213/star_trek/discussions)

---

🙏 **感谢您的贡献！** 每一个贡献都让 Star Trek 变得更好，帮助更多的孩子在学习中获得乐趣！