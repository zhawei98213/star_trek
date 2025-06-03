import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/learning/presentation/pages/learning_page.dart';
import '../../features/learning/presentation/pages/lesson_detail_page.dart';

/// 应用路由配置
/// 定义应用中所有页面的路由规则
class AppRouter {
  // 路由路径常量
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  // TODO: 添加其他页面路径常量
  
  /// 创建路由配置
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: splash,
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        // 启动页
        GoRoute(
          path: splash,
          name: 'splash',
          builder: (context, state) => const SplashPage(),
        ),
        
        // 引导页
        GoRoute(
          path: onboarding,
          name: 'onboarding',
          builder: (context, state) => const OnboardingPage(),
        ),
        
        // 主页
        GoRoute(
          path: home,
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        
        // Learning routes
        GoRoute(
          path: '/learning/:userId',
          name: 'learning',
          builder: (context, state) {
            final userId = state.pathParameters['userId']!;
            return LearningPage(userId: userId);
          },
        ),
        
        GoRoute(
          path: '/lesson/:lessonId',
          name: 'lesson_detail',
          builder: (context, state) {
            final lessonId = state.pathParameters['lessonId']!;
            return LessonDetailPage(lessonId: lessonId);
          },
        ),
        
        // TODO: 添加其他页面路由
      ],
      
      // 错误页面处理
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('页面未找到'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                '抱歉，找不到您要访问的页面',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                '错误信息: ${state.error}',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(home),
                child: const Text('返回首页'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 路由扩展方法
extension AppRouterExtension on BuildContext {
  /// 导航到指定路由
  void navigateTo(String route, {Map<String, String>? pathParameters}) {
    if (pathParameters != null) {
      String path = route;
      pathParameters.forEach((key, value) {
        path = path.replaceAll(':$key', value);
      });
      go(path);
    } else {
      go(route);
    }
  }
  
  /// 推送新页面
  void pushTo(String route, {Map<String, String>? pathParameters}) {
    if (pathParameters != null) {
      String path = route;
      pathParameters.forEach((key, value) {
        path = path.replaceAll(':$key', value);
      });
      push(path);
    } else {
      push(route);
    }
  }
  
  /// 返回上一页
  void goBack() {
    if (canPop()) {
      pop();
    } else {
      go(AppRouter.home);
    }
  }
}