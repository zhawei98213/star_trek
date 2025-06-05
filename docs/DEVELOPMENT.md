# 🛠 开发指南

本文档提供了 Star Trek 项目的详细开发指南，帮助开发者快速上手并遵循项目规范。

## 📋 目录

- [开发环境设置](#开发环境设置)
- [项目架构](#项目架构)
- [编码规范](#编码规范)
- [Git 工作流](#git-工作流)
- [测试策略](#测试策略)
- [性能优化](#性能优化)
- [调试技巧](#调试技巧)

## 🔧 开发环境设置

### 必需工具

1. **Flutter SDK**
   ```bash
   # 检查 Flutter 版本
   flutter --version
   
   # 应该显示 >= 3.0.0
   ```

2. **IDE 推荐**
   - **VS Code** + Flutter 扩展
   - **Android Studio** + Flutter 插件
   - **IntelliJ IDEA** + Dart/Flutter 插件

3. **代码格式化**
   ```bash
   # 格式化代码
   dart format .
   
   # 分析代码
   dart analyze
   ```

### VS Code 配置

创建 `.vscode/settings.json`：

```json
{
  "dart.flutterSdkPath": "/path/to/flutter",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll": true
  },
  "dart.lineLength": 80,
  "dart.showTodos": true
}
```

## 🏗 项目架构

### Clean Architecture 分层

```
lib/
├── core/                    # 核心层
│   ├── constants/          # 应用常量
│   ├── errors/            # 错误处理
│   ├── network/           # 网络配置
│   ├── router/            # 路由管理
│   ├── theme/             # 主题配置
│   └── utils/             # 工具类
├── features/              # 功能层
│   └── [feature_name]/    # 具体功能
│       ├── data/          # 数据层
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/        # 业务层
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/  # 表现层
│           ├── pages/
│           ├── widgets/
│           └── providers/
└── shared/               # 共享组件
    ├── widgets/         # 通用组件
    └── extensions/      # 扩展方法
```

### 功能模块结构

每个功能模块应遵循以下结构：

```
feature_name/
├── data/
│   ├── datasources/
│   │   ├── feature_local_datasource.dart
│   │   └── feature_remote_datasource.dart
│   ├── models/
│   │   └── feature_model.dart
│   └── repositories/
│       └── feature_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── feature_entity.dart
│   ├── repositories/
│   │   └── feature_repository.dart
│   └── usecases/
│       └── get_feature_usecase.dart
└── presentation/
    ├── pages/
    │   └── feature_page.dart
    ├── widgets/
    │   └── feature_widget.dart
    └── providers/
        └── feature_provider.dart
```

## 📝 编码规范

### Dart 编码规范

1. **命名规范**
   ```dart
   // 类名：PascalCase
   class UserProfile {}
   
   // 变量名：camelCase
   String userName = 'John';
   
   // 常量：lowerCamelCase
   const double maxWidth = 400.0;
   
   // 私有成员：下划线前缀
   String _privateField;
   ```

2. **文件命名**
   ```
   // 文件名：snake_case
   user_profile_page.dart
   learning_progress_widget.dart
   ```

3. **导入顺序**
   ```dart
   // 1. Dart 核心库
   import 'dart:async';
   import 'dart:io';
   
   // 2. Flutter 库
   import 'package:flutter/material.dart';
   import 'package:flutter/services.dart';
   
   // 3. 第三方包
   import 'package:provider/provider.dart';
   import 'package:go_router/go_router.dart';
   
   // 4. 项目内部导入
   import '../core/theme/app_theme.dart';
   import '../shared/widgets/custom_button.dart';
   ```

### Widget 编写规范

1. **StatelessWidget 优先**
   ```dart
   class MyWidget extends StatelessWidget {
     const MyWidget({super.key, required this.title});
     
     final String title;
     
     @override
     Widget build(BuildContext context) {
       return Container(
         child: Text(title),
       );
     }
   }
   ```

2. **构造函数规范**
   ```dart
   class CustomButton extends StatelessWidget {
     const CustomButton({
       super.key,
       required this.onPressed,
       required this.text,
       this.isLoading = false,
       this.backgroundColor,
     });
     
     final VoidCallback onPressed;
     final String text;
     final bool isLoading;
     final Color? backgroundColor;
   }
   ```

3. **Build 方法优化**
   ```dart
   @override
   Widget build(BuildContext context) {
     final theme = Theme.of(context);
     final responsive = ResponsiveUtils(context);
     
     return Scaffold(
       body: _buildBody(context),
       bottomNavigationBar: _buildBottomNavigation(),
     );
   }
   
   Widget _buildBody(BuildContext context) {
     // 复杂的 UI 逻辑拆分到私有方法
   }
   ```

## 🔄 Git 工作流

### 分支策略

```
main                 # 主分支，生产环境代码
├── develop         # 开发分支
├── feature/xxx     # 功能分支
├── bugfix/xxx      # 修复分支
└── release/xxx     # 发布分支
```

### 提交信息规范

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Type 类型：**
- `feat`: 新功能
- `fix`: 修复bug
- `docs`: 文档更新
- `style`: 代码格式调整
- `refactor`: 重构
- `test`: 测试相关
- `chore`: 构建过程或辅助工具的变动

**示例：**
```
feat(home): add responsive layout for iPad landscape mode

- Implement ResponsiveUtils for screen size detection
- Add tablet-specific sidebar and header components
- Update theme system with tablet spacing constants
- Optimize screen orientation preferences

Closes #123
```

### 开发流程

1. **创建功能分支**
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/learning-progress
   ```

2. **开发和提交**
   ```bash
   # 开发代码...
   git add .
   git commit -m "feat(learning): implement progress tracking system"
   ```

3. **推送和创建PR**
   ```bash
   git push origin feature/learning-progress
   # 在GitHub上创建Pull Request
   ```

## 🧪 测试策略

### 测试金字塔

```
    /\     E2E Tests (少量)
   /  \    
  /____\   Integration Tests (适量)
 /______\  Unit Tests (大量)
```

### 单元测试

```dart
// test/features/home/domain/usecases/get_user_data_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('GetUserDataUseCase', () {
    late GetUserDataUseCase usecase;
    late MockUserRepository mockRepository;
    
    setUp(() {
      mockRepository = MockUserRepository();
      usecase = GetUserDataUseCase(mockRepository);
    });
    
    test('should return user data when repository call is successful', () async {
      // arrange
      const userData = UserEntity(id: '1', name: 'Test User');
      when(mockRepository.getUserData()).thenAnswer((_) async => userData);
      
      // act
      final result = await usecase.call();
      
      // assert
      expect(result, userData);
      verify(mockRepository.getUserData());
    });
  });
}
```

### Widget 测试

```dart
// test/features/home/presentation/widgets/home_header_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeHeader Widget', () {
    testWidgets('should display user name correctly', (tester) async {
      // arrange
      const userName = 'Test User';
      
      // act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HomeHeader(userName: userName),
          ),
        ),
      );
      
      // assert
      expect(find.text('欢迎回来，$userName！'), findsOneWidget);
    });
  });
}
```

### 集成测试

```dart
// integration_test/app_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:star_trek/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('App Integration Tests', () {
    testWidgets('complete user flow test', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      // 测试启动页到首页的流程
      expect(find.byType(SplashPage), findsOneWidget);
      
      await tester.pumpAndSettle(Duration(seconds: 3));
      
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
```

## ⚡ 性能优化

### Widget 性能优化

1. **使用 const 构造函数**
   ```dart
   const Text('Hello World')  // ✅ 好
   Text('Hello World')        // ❌ 避免
   ```

2. **避免在 build 方法中创建对象**
   ```dart
   class MyWidget extends StatelessWidget {
     // ✅ 好：在类级别定义
     static const EdgeInsets _padding = EdgeInsets.all(16.0);
     
     @override
     Widget build(BuildContext context) {
       return Padding(
         padding: _padding,  // 使用预定义的对象
         child: Text('Hello'),
       );
     }
   }
   ```

3. **使用 ListView.builder 处理长列表**
   ```dart
   ListView.builder(
     itemCount: items.length,
     itemBuilder: (context, index) {
       return ListTile(title: Text(items[index]));
     },
   )
   ```

### 内存管理

1. **及时释放资源**
   ```dart
   class _MyPageState extends State<MyPage> {
     late AnimationController _controller;
     
     @override
     void initState() {
       super.initState();
       _controller = AnimationController(vsync: this);
     }
     
     @override
     void dispose() {
       _controller.dispose();  // 释放动画控制器
       super.dispose();
     }
   }
   ```

2. **避免内存泄漏**
   ```dart
   // 使用 WeakReference 或及时取消订阅
   StreamSubscription? _subscription;
   
   @override
   void dispose() {
     _subscription?.cancel();
     super.dispose();
   }
   ```

## 🐛 调试技巧

### Flutter Inspector

1. **在 VS Code 中使用**
   - `Cmd+Shift+P` → "Flutter: Open Flutter Inspector"
   - 可视化 Widget 树
   - 检查布局问题

2. **性能分析**
   ```bash
   # 启用性能分析
   flutter run --profile
   ```

### 日志调试

```dart
import 'dart:developer' as developer;

// 使用 log 而不是 print
developer.log('Debug message', name: 'MyApp');

// 条件日志
assert(() {
  developer.log('This only runs in debug mode');
  return true;
}());
```

### 常用调试命令

```bash
# 热重载
r

# 热重启
R

# 打开 Flutter Inspector
w

# 切换性能叠加层
P

# 切换平台
o
```

### Provider/BLoC 错误调试

#### 常见错误：`Could not find the correct Provider<T> above this Widget`

**问题原因**：
- Widget 无法在其父级 Widget 树中找到对应的 Provider
- BLoC 未在依赖注入系统中正确注册
- MultiBlocProvider 配置缺失或错误

**调试步骤**：

1. **检查依赖注入配置**
   ```dart
   // 确保在 injection_container.dart 中注册了 BLoC
   sl.registerFactory(() => HomeBloc(
     getHomeDataUseCase: sl(),
     // ... 其他依赖
   ));
   ```

2. **检查 MultiBlocProvider 配置**
   ```dart
   // 在 main.dart 中确保添加了 BlocProvider
   MultiBlocProvider(
     providers: [
       BlocProvider<HomeBloc>(
         create: (context) => GetIt.instance<HomeBloc>(),
       ),
       // ... 其他 BLoC
     ],
     child: MaterialApp.router(...),
   )
   ```

3. **检查模块依赖注入初始化**
   ```dart
   // 在 main() 函数中确保初始化了模块依赖
   void main() async {
     await learning_di.initLearningDependencies();
     await home_di.initHomeDependencies();  // 确保添加了这行
     runApp(const StartTrekApp());
   }
   ```

4. **验证构造函数参数**
   ```dart
   // 确保数据源实现类的构造函数与注册时的参数匹配
   class HomeLocalDataSourceImpl implements HomeLocalDataSource {
     // 如果构造函数不需要参数，注册时也不要传参数
     HomeLocalDataSourceImpl(); // 无参构造函数
   }
   
   // 对应的注册代码
   sl.registerLazySingleton<HomeLocalDataSource>(
     () => HomeLocalDataSourceImpl(), // 不传参数
   );
   ```

**调试工具**：
```dart
// 在 Widget 中添加调试信息
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    try {
      final bloc = context.read<HomeBloc>();
      print('HomeBloc found: ${bloc.runtimeType}');
      return YourActualWidget();
    } catch (e) {
      print('Provider error: $e');
      return ErrorWidget(e);
    }
  }
}
```

## 📚 学习资源

### 官方文档
- [Flutter 官方文档](https://flutter.dev/docs)
- [Dart 语言指南](https://dart.dev/guides)
- [Flutter 最佳实践](https://flutter.dev/docs/perf/best-practices)

### 推荐阅读
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter 架构指南](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options)
- [Clean Architecture in Flutter](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

---

📝 **注意**: 本文档会随着项目发展持续更新，请定期查看最新版本。