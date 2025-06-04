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
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String achievements = '/achievements';
  static const String challenge = '/challenge';
  static const String review = '/review';
  static const String shop = '/shop';
  static const String courses = '/courses';
  static const String statistics = '/statistics';
  
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
        
        // 个人资料页
        GoRoute(
          path: profile,
          name: 'profile',
          builder: (context, state) => const Scaffold(
            appBar: null,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, size: 64, color: Colors.blue),
                  SizedBox(height: 16),
                  Text('个人资料页面', style: TextStyle(fontSize: 24)),
                  Text('功能开发中...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
        
        // 设置页
        GoRoute(
          path: settings,
          name: 'settings',
          builder: (context, state) => const Scaffold(
            appBar: null,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.settings, size: 64, color: Colors.blue),
                  SizedBox(height: 16),
                  Text('设置页面', style: TextStyle(fontSize: 24)),
                  Text('功能开发中...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
        
        // 搜索页
        GoRoute(
          path: search,
          name: 'search',
          builder: (context, state) => const Scaffold(
            appBar: null,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 64, color: Colors.blue),
                  SizedBox(height: 16),
                  Text('搜索页面', style: TextStyle(fontSize: 24)),
                  Text('功能开发中...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
        
        // 收藏页
        GoRoute(
          path: favorites,
          name: 'favorites',
          builder: (context, state) => const Scaffold(
            appBar: null,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text('收藏页面', style: TextStyle(fontSize: 24)),
                  Text('功能开发中...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
        
        // 成就页
        GoRoute(
          path: achievements,
          name: 'achievements',
          builder: (context, state) => const Scaffold(
            appBar: null,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.emoji_events, size: 64, color: Colors.amber),
                  SizedBox(height: 16),
                  Text('成就页面', style: TextStyle(fontSize: 24)),
                  Text('功能开发中...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
        
        // 挑战页
        GoRoute(
          path: challenge,
          name: 'challenge',
          builder: (context, state) => const Scaffold(
            appBar: null,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sports_esports, size: 64, color: Colors.green),
                  SizedBox(height: 16),
                  Text('每日挑战页面', style: TextStyle(fontSize: 24)),
                  Text('功能开发中...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
        
        // 复习页
        GoRoute(
          path: review,
          name: 'review',
          builder: (context, state) => const Scaffold(
            appBar: null,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh, size: 64, color: Colors.purple),
                  SizedBox(height: 16),
                  Text('复习模式页面', style: TextStyle(fontSize: 24)),
                  Text('功能开发中...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
        
        // 商店页
        GoRoute(
          path: shop,
          name: 'shop',
          builder: (context, state) => const Scaffold(
            appBar: null,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.store, size: 64, color: Colors.orange),
                  SizedBox(height: 16),
                  Text('商店页面', style: TextStyle(fontSize: 24)),
                  Text('功能开发中...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
        
        // 课程列表页
        GoRoute(
          path: courses,
          name: 'courses',
          builder: (context, state) => const Scaffold(
            appBar: null,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, size: 64, color: Colors.indigo),
                  SizedBox(height: 16),
                  Text('所有课程页面', style: TextStyle(fontSize: 24)),
                  Text('功能开发中...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
        
        // 统计页
        GoRoute(
          path: statistics,
          name: 'statistics',
          builder: (context, state) => const Scaffold(
            appBar: null,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.analytics, size: 64, color: Colors.teal),
                  SizedBox(height: 16),
                  Text('详细统计页面', style: TextStyle(fontSize: 24)),
                  Text('功能开发中...', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
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