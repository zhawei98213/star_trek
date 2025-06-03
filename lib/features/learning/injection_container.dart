import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// Domain
import 'domain/repositories/learning_repository.dart';
import 'domain/usecases/get_learning_progress_usecase.dart';
import 'domain/usecases/get_lessons_usecase.dart';
import 'domain/usecases/update_lesson_progress_usecase.dart';

// Data
import 'data/repositories/learning_repository_impl.dart';
import 'data/datasources/learning_local_datasource.dart';
import 'data/datasources/learning_remote_datasource.dart';

// Presentation
import 'presentation/bloc/learning_bloc.dart';

final sl = GetIt.instance;

/// 初始化学习功能的依赖注入
Future<void> initLearningDependencies() async {
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
  sl.registerLazySingleton<LearningLocalDataSource>(
    () => LearningLocalDataSourceImpl(
      sl(),
    ),
  );
  
  // Remote Data Source
  sl.registerLazySingleton<LearningRemoteDataSource>(
    () => LearningRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  
  // ==================== Repository ====================
  
  sl.registerLazySingleton<LearningRepository>(
    () => LearningRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );
  
  // ==================== Use Cases ====================
  
  sl.registerLazySingleton(() => GetLearningProgressUseCase(
    sl(),
  ));
  
  sl.registerLazySingleton(() => GetLessonsUseCase(
    sl(),
  ));
  
  sl.registerLazySingleton(() => UpdateLessonProgressUseCase(
    sl(),
  ));
  
  // ==================== Bloc ====================
  
  sl.registerFactory(() => LearningBloc(
    getLearningProgressUseCase: sl(),
    getLessonsUseCase: sl(),
    updateLessonProgressUseCase: sl(),
  ));
}

/// 清理学习功能的依赖注入
void cleanupLearningDependencies() {
  // Bloc
  if (sl.isRegistered<LearningBloc>()) {
    sl.unregister<LearningBloc>();
  }
  
  // Use Cases
  if (sl.isRegistered<GetLearningProgressUseCase>()) {
    sl.unregister<GetLearningProgressUseCase>();
  }
  if (sl.isRegistered<GetLessonsUseCase>()) {
    sl.unregister<GetLessonsUseCase>();
  }
  if (sl.isRegistered<UpdateLessonProgressUseCase>()) {
    sl.unregister<UpdateLessonProgressUseCase>();
  }
  
  // Repository
  if (sl.isRegistered<LearningRepository>()) {
    sl.unregister<LearningRepository>();
  }
  
  // Data Sources
  if (sl.isRegistered<LearningLocalDataSource>()) {
    sl.unregister<LearningLocalDataSource>();
  }
  if (sl.isRegistered<LearningRemoteDataSource>()) {
    sl.unregister<LearningRemoteDataSource>();
  }
}