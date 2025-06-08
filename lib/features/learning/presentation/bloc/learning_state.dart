import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../domain/entities/learning_progress_entity.dart';
import '../../../../core/error/failures.dart';

part 'learning_state.freezed.dart';

/// 学习模块状态
@freezed
class LearningState with _$LearningState {
  /// 初始状态
  const factory LearningState.initial() = _Initial;
  
  /// 加载中状态
  const factory LearningState.loading({String? message}) = _Loading;
  
  /// 已加载状态
  const factory LearningState.loaded({
    required LearningProgressEntity progress,
    required List<LessonEntity> lessons,
    @Default([]) List<LessonEntity> searchResults,
    @Default(false) bool isSearching,
    String? searchQuery,
    Map<String, dynamic>? completionResult,
  }) = _Loaded;
  
  /// 错误状态
  const factory LearningState.error(Failure failure) = _Error;
  
  /// 操作成功状态
  const factory LearningState.operationSuccess({
    required String message,
    Map<String, dynamic>? data,
  }) = _OperationSuccess;
  
  /// 搜索成功状态
  const factory LearningState.searchSuccess({
    required List<LessonEntity> searchResults,
    required String searchQuery,
  }) = _SearchSuccess;
  
  /// 课程详情加载状态
  const factory LearningState.lessonDetailLoading(String lessonId) = _LessonDetailLoading;
  
  /// 课程详情已加载状态
  const factory LearningState.lessonDetailLoaded({
    required LessonEntity lesson,
    required bool isBookmarked,
  }) = _LessonDetailLoaded;
  
  /// 进度更新状态
  const factory LearningState.progressUpdated({
    required LearningProgressEntity progress,
    required String message,
  }) = _ProgressUpdated;
  
  /// 同步状态
  const factory LearningState.syncing() = _Syncing;
  
  /// 同步完成状态
  const factory LearningState.syncCompleted(String message) = _SyncCompleted;
}