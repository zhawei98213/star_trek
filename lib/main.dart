import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/constants/app_constants.dart';
import 'features/learning/injection_container.dart' as learning_di;
import 'features/learning/presentation/bloc/learning_bloc.dart';

void main() async {
  // 确保Flutter绑定初始化
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化依赖注入
  await learning_di.initLearningDependencies();
  
  // 设置系统UI样式
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  // 设置首选方向（优先横屏，适配iPad）
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const StartTrekApp());
}

/// Start Trek 主应用
class StartTrekApp extends StatelessWidget {
  const StartTrekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Learning Bloc
        BlocProvider<LearningBloc>(
          create: (context) => GetIt.instance<LearningBloc>(),
        ),
        // TODO: 添加其他 Bloc 提供者
      ],
      child: MaterialApp.router(
        // 应用基本信息
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        
        // 主题配置
        theme: AppTheme.lightTheme,
        
        // 路由配置
        routerConfig: AppRouter.createRouter(),
        
        // 构建器配置
        builder: (context, child) {
          return MediaQuery(
            // 禁用系统字体缩放，确保UI一致性
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1.0),
            ),
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
