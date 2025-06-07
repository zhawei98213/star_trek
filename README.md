# 🚀 Star Trek - 儿童学习探险应用

一个专为儿童设计的互动学习应用，通过星际探险的主题让孩子们在游戏中快乐学习。

## 📱 项目概述

Star Trek 是一款基于 Flutter 开发的跨平台儿童教育应用，旨在通过生动有趣的星际探险主题，激发孩子们的学习兴趣，培养他们的认知能力和创造力。

### 🎯 目标用户
- 3-12岁儿童
- 关注孩子教育的家长
- 教育工作者

## ✨ 核心功能

### 🏠 首页功能
- [x] 响应式布局设计（支持手机和iPad横屏）
- [x] 用户欢迎界面
- [x] 快捷操作入口
- [x] 学习进度展示
- [x] 每日挑战预览
- [x] 最近成就展示

### 📚 学习系统
- [x] 学习主页面（完整的Clean Architecture实现）
- [x] 个性化学习路径
- [x] 互动课程内容展示
- [x] 进度追踪系统
- [x] 学习统计数据
- [x] 推荐课程功能
- [x] 课程详情页面
- [ ] 学习报告生成

### 🎮 游戏化功能（规划中）
- [ ] 每日挑战任务
- [ ] 成就徽章系统
- [ ] 积分奖励机制
- [ ] 排行榜功能

### 🔧 最新修复
- [x] 修复了 ColorScheme 命名冲突问题
- [x] 解决了主题系统的编译错误
- [x] 应用现在可以正常启动和运行
- [x] 支持多种星际主题切换
- [x] 实现了模块化依赖注入系统
- [x] 修复了 Provider/BLoC 错误问题
- [x] 完善了 Home 模块的依赖注入配置
- [x] 添加了详细的调试指南和错误处理文档
- [x] 完善了侧边导航栏的页面跳转功能

### 🧩 共享组件
- [x] 通用加载组件（LoadingWidget）
- [x] 通用错误处理组件（CustomErrorWidget）
- [x] 响应式底部导航栏
- [x] 统一的主题系统
- [x] 多主题支持（星际舰队、企业号、克林贡、瓦肯、罗慕兰）

### 👨‍👩‍👧‍👦 家长功能（规划中）
- [ ] 学习监控面板
- [ ] 进度报告
- [ ] 使用时间管理
- [ ] 内容筛选设置

## 🛠 技术栈

### 前端框架
- **Flutter 3.x** - 跨平台UI框架
- **Dart** - 编程语言

### 架构设计
- **Clean Architecture** - 分层架构（Domain/Data/Presentation）
- **Feature-First** - 功能优先的目录结构
- **Modular DI** - 模块化依赖注入系统
- **Responsive Design** - 响应式设计
- **BLoC Pattern** - 状态管理模式

### 状态管理
- **BLoC Pattern** - 业务逻辑组件
- **Provider** - 依赖注入和状态管理
- **GetIt** - 服务定位器模式

### 本地存储
- **SharedPreferences** - 轻量级数据存储
- **SQLite** - 本地数据库（规划中）

### 路由管理
- **GoRouter** - 声明式路由

## 🚧 开发进度

### 最新完成功能 (2024年12月)

#### 🧭 导航系统增强 (最新)
- **侧边导航栏功能完善**
  - 为首页侧边导航栏的所有项目添加了页面跳转功能
  - 课程导航：直接跳转到学习页面
  - 成就导航：跳转到成就展示页面
  - 商店导航：跳转到应用商店页面
  - 设置导航：跳转到应用设置页面
- **路由集成优化**
  - 使用 GoRouter 的 `context.go()` 方法实现页面切换
  - 确保导航的一致性和流畅性
  - 提升用户体验和应用内导航效率

#### 🏗️ 架构优化
- **模块化依赖注入系统**
  - 实现了基于 GetIt 的服务定位器模式
  - 每个功能模块独立的依赖注入配置
  - 支持模块间的依赖管理和解耦
  - 完善的错误处理和调试支持

#### 🏠 Home 模块完善
- **Clean Architecture 实现**
  - Domain Layer: 业务逻辑和用例定义
  - Data Layer: 数据源和仓储实现
  - Presentation Layer: BLoC 状态管理和 UI
- **依赖注入配置**
  - HomeBloc 的完整依赖链配置
  - 数据源和仓储的注册管理
  - 用例层的依赖注入实现

#### 🐛 问题修复
- **Provider/BLoC 错误解决**
  - 修复了 "Could not find the correct Provider" 错误
  - 完善了 MultiBlocProvider 配置
  - 添加了详细的调试指南和最佳实践
- **主题系统优化**
  - 解决了 ColorScheme 命名冲突
  - 支持多种星际主题动态切换

#### 📚 文档完善
- **架构文档更新**
  - 添加了模块依赖注入章节
  - 详细的代码示例和配置说明
  - 依赖关系图和模块结构说明
- **开发指南增强**
  - Provider/BLoC 错误调试指南
  - 常见问题解决方案
  - 调试工具和技巧说明

### 下一步计划
- [ ] 完善 Learning 模块的功能实现
- [ ] 添加单元测试和集成测试
- [ ] 实现数据持久化功能
- [ ] 优化性能和用户体验

## 📱 支持平台

- ✅ iOS (iPhone/iPad)
- ✅ Android (手机/平板)
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 🚀 快速开始

### 环境要求

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- iOS: Xcode 14.0+
- Android: Android Studio 4.1+

### 安装步骤

1. **克隆项目**
   ```bash
   git clone https://github.com/zhawei98213/star_trek.git
   cd star_trek
   ```

2. **安装依赖**
   ```bash
   flutter pub get
   ```

3. **iOS 额外配置**
   ```bash
   cd ios
   pod install
   cd ..
   ```

4. **运行应用**
   ```bash
   # 运行在模拟器/设备上
   flutter run
   
   # 指定设备运行
   flutter run -d "iPad Pro (12.9-inch) (6th generation)"
   ```

### 开发环境配置

1. **检查Flutter环境**
   ```bash
   flutter doctor
   ```

2. **启用Web支持**
   ```bash
   flutter config --enable-web
   ```

3. **启用桌面支持**
   ```bash
   flutter config --enable-macos-desktop
   flutter config --enable-windows-desktop
   flutter config --enable-linux-desktop
   ```

## 📁 项目结构

```
lib/
├── core/                    # 核心功能
│   ├── constants/          # 常量定义
│   ├── router/            # 路由配置
│   ├── theme/             # 主题样式
│   └── utils/             # 工具类
├── features/              # 功能模块
│   ├── home/             # 首页功能
│   ├── onboarding/       # 引导页
│   └── splash/           # 启动页
├── shared/               # 共享组件
│   └── widgets/         # 通用组件
└── main.dart            # 应用入口
```

## 🎨 设计规范

### 色彩主题
- **主色调**: 星空蓝 (#2196F3)
- **辅助色**: 温暖橙 (#FF9800)
- **背景色**: 纯净白 (#FFFFFF)
- **文字色**: 深空灰 (#333333)

### 响应式设计
- **手机端**: 垂直滚动布局
- **平板横屏**: 侧边栏 + 主内容区域
- **自适应间距**: 根据屏幕尺寸调整

## 🧪 测试

```bash
# 运行单元测试
flutter test

# 运行集成测试
flutter test integration_test/

# 生成测试覆盖率报告
flutter test --coverage
```

## 📦 构建发布

### Android
```bash
# 构建APK
flutter build apk --release

# 构建App Bundle
flutter build appbundle --release
```

### iOS
```bash
# 构建iOS应用
flutter build ios --release
```

### Web
```bash
# 构建Web应用
flutter build web --release
```

## 🤝 贡献指南

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

### 开发规范
- 遵循 [Effective Dart](https://dart.dev/guides/language/effective-dart) 编码规范
- 使用有意义的提交信息
- 为新功能添加相应的测试
- 更新相关文档

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 📞 联系方式

- 项目维护者: [zhawei98213](https://github.com/zhawei98213)
- 项目地址: [https://github.com/zhawei98213/star_trek](https://github.com/zhawei98213/star_trek)
- 问题反馈: [Issues](https://github.com/zhawei98213/star_trek/issues)

## 🙏 致谢

感谢所有为这个项目做出贡献的开发者和设计师！

---

⭐ 如果这个项目对你有帮助，请给它一个星标！