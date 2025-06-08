import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../domain/usecases/get_lessons_usecase.dart';
import '../../domain/usecases/update_lesson_progress_usecase.dart';

part 'learning_event.freezed.dart';

/// 学习模块事件
@freezed
class LearningEvent with _$LearningEvent {
  /// 加载学习进度事件
  const factory LearningEvent.loadLearningProgress(String userId) = _LoadLearningProgress;
  
  /// 加载课程列表事件
  const factory LearningEvent.loadLessons(GetLessonsParams params) = _LoadLessons;
  
  /// 搜索课程事件
  const factory LearningEvent.searchLessons({
    required String query,
    AgeGroup? ageGroup,
    DifficultyLevel? difficulty,
    LessonType? type,
  }) = _SearchLessons;
  
  /// 更新课程进度事件
  const factory LearningEvent.updateLessonProgress(UpdateProgressParams params) = _UpdateLessonProgress;
  
  /// 完成课程事件
  const factory LearningEvent.completeLesson({
    required String userId,
    required String lessonId,
    required int score,
    required int studyTime,
  }) = _CompleteLesson;
  
  /// 添加学习时长事件
  const factory LearningEvent.addStudyTime({
    required String userId,
    required int studyTime,
    required LessonType lessonType,
  }) = _AddStudyTime;
  
  /// 更新每日目标事件
  const factory LearningEvent.updateDailyGoal({
    required String userId,
    required int goalMinutes,
  }) = _UpdateDailyGoal;
  
  /// 刷新数据事件
  const factory LearningEvent.refreshLearningData(String userId) = _RefreshLearningData;
  
  /// 同步数据到云端事件
  const factory LearningEvent.syncToCloud(String userId) = _SyncToCloud;
  
  /// 加载课程详情事件
  const factory LearningEvent.loadLessonDetail(String lessonId) = _LoadLessonDetail;
  
  /// 切换课程收藏状态事件
  const factory LearningEvent.toggleLessonBookmark(String lessonId) = _ToggleLessonBookmark;
  
  /// 重置状态事件
  const factory LearningEvent.resetState() = _ResetState;
  
  /// 清除搜索结果事件
  const factory LearningEvent.clearSearchResults() = _ClearSearchResults;
  
  /// 加载更多课程事件
  const factory LearningEvent.loadMoreLessons({
    required int page,
    required int limit,
    AgeGroup? ageGroup,
    DifficultyLevel? difficulty,
    LessonType? type,
  }) = _LoadMoreLessons;
  
  /// 筛选课程事件
  const factory LearningEvent.filterLessons({
    AgeGroup? ageGroup,
    DifficultyLevel? difficulty,
    LessonType? type,
    bool? isCompleted,
    bool? isBookmarked,
  }) = _FilterLessons;
}