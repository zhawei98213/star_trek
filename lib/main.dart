import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/router/app_router.dart';
import 'core/constants/app_constants.dart';
import 'core/config/app_config.dart';
import 'core/theme/theme_manager.dart';
import 'core/utils/logger.dart';
import 'core/utils/error_handler.dart';
import 'features/learning/injection_container.dart' as learning_di;
import 'features/learning/presentation/bloc/learning_bloc.dart';
import 'features/home/injection_container.dart' as home_di;
import 'features/home/presentation/bloc/home_bloc.dart';

void main() async {
  // 确保Flutter绑定初始化
  WidgetsFlutterBinding.ensureInitialized();
  
  // 设置系统UI样式
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  // 初始化应用配置
  await AppConfig.instance.initialize(
    environment: AppEnvironment.development,
  );
  
  // 初始化主题管理器
  await ThemeManager.instance.initialize();
  
  // 设置全局错误处理
  FlutterError.onError = (FlutterErrorDetails details) {
    Logger.instance.exception(
      details.exception,
      message: 'Flutter Error',
      stackTrace: details.stack,
    );
    ErrorHandler.handleError(details.exception, stackTrace: details.stack);
  };
  
  // 初始化依赖注入
  await learning_di.initLearningDependencies();
  await home_di.initHomeDependencies();
  
  // 设置首选方向（优先横屏，适配iPad）
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  Logger.instance.i('Application starting', tag: 'MAIN');
  
  runApp(const StartTrekApp());
}

/// Start Trek 主应用
class StartTrekApp extends StatelessWidget {
  const StartTrekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LearningBloc>(
          create: (context) => GetIt.instance<LearningBloc>(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => GetIt.instance<HomeBloc>(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (_) => ThemeManager.instance,
        child: Consumer<ThemeManager>(
          builder: (context, themeManager, child) {
            return MaterialApp.router(
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.createRouter(),
              theme: themeManager.lightTheme,
              darkTheme: themeManager.darkTheme,
              themeMode: themeManager.flutterThemeMode,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: TextScaler.linear(themeManager.textScaleFactor),
                  ),
                  child: child!,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
