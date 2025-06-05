import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// Domain
import 'domain/repositories/home_repository.dart';
import 'domain/usecases/get_home_data_usecase.dart';
import 'domain/usecases/get_user_stats_usecase.dart';
import 'domain/usecases/get_notifications_usecase.dart';
import 'domain/usecases/mark_notification_read_usecase.dart';
import 'domain/usecases/refresh_home_data_usecase.dart';

// Data
import 'data/repositories/home_repository_impl.dart';
import 'data/datasources/home_local_datasource.dart';
import 'data/datasources/home_remote_datasource.dart';
import 'data/datasources/home_local_datasource_impl.dart';
import 'data/datasources/home_remote_datasource_impl.dart';

// Presentation
import 'presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;

/// 初始化主页功能的依赖注入
Future<void> initHomeDependencies() async {
  // ==================== External ====================
  
  // SharedPreferences (如果还没有注册)
  if (!sl.isRegistered<SharedPreferences>()) {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
  }
  
  // HTTP Client (如果还没有注册)
  if (!sl.isRegistered<http.Client>()) {
    sl.registerLazySingleton(() => http.Client());
  }
  
  // ==================== Data Sources ====================
  
  // Local Data Source
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );
  
  // Remote Data Source
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );
  
  // ==================== Repository ====================
  
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );
  
  // ==================== Use Cases ====================
  
  sl.registerLazySingleton(() => GetHomeDataUseCase(
    sl(),
  ));
  
  sl.registerLazySingleton(() => GetUserStatsUseCase(
    sl(),
  ));
  
  sl.registerLazySingleton(() => GetNotificationsUseCase(
    sl(),
  ));
  
  sl.registerLazySingleton(() => MarkNotificationReadUseCase(
    sl(),
  ));
  
  sl.registerLazySingleton(() => RefreshHomeDataUseCase(
    sl(),
  ));
  
  // ==================== Bloc ====================
  
  sl.registerFactory(() => HomeBloc(
    getHomeDataUseCase: sl(),
    getUserStatsUseCase: sl(),
    getNotificationsUseCase: sl(),
    markNotificationReadUseCase: sl(),
    refreshHomeDataUseCase: sl(),
  ));
}

/// 清理主页功能的依赖注入
void cleanupHomeDependencies() {
  // Bloc
  if (sl.isRegistered<HomeBloc>()) {
    sl.unregister<HomeBloc>();
  }
  
  // Use Cases
  if (sl.isRegistered<GetHomeDataUseCase>()) {
    sl.unregister<GetHomeDataUseCase>();
  }
  if (sl.isRegistered<GetUserStatsUseCase>()) {
    sl.unregister<GetUserStatsUseCase>();
  }
  if (sl.isRegistered<GetNotificationsUseCase>()) {
    sl.unregister<GetNotificationsUseCase>();
  }
  if (sl.isRegistered<MarkNotificationReadUseCase>()) {
    sl.unregister<MarkNotificationReadUseCase>();
  }
  if (sl.isRegistered<RefreshHomeDataUseCase>()) {
    sl.unregister<RefreshHomeDataUseCase>();
  }
  
  // Repository
  if (sl.isRegistered<HomeRepository>()) {
    sl.unregister<HomeRepository>();
  }
  
  // Data Sources
  if (sl.isRegistered<HomeLocalDataSource>()) {
    sl.unregister<HomeLocalDataSource>();
  }
  if (sl.isRegistered<HomeRemoteDataSource>()) {
    sl.unregister<HomeRemoteDataSource>();
  }
}