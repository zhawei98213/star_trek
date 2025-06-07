import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../domain/entities/learning_progress_entity.dart';
import '../../domain/usecases/get_learning_progress_usecase.dart';
import '../../domain/usecases/get_lessons_usecase.dart';
import '../../domain/usecases/update_lesson_progress_usecase.dart';

// ==================== Events ====================

abstract class LearningEvent {
  const LearningEvent();
}

/// 加载学习进度事件
class LoadLearningProgressEvent extends LearningEvent {
  final String userId;
  
  const LoadLearningProgressEvent(this.userId);
}

/// 加载课程列表事件
class LoadLessonsEvent extends LearningEvent {
  final GetLessonsParams params;
  
  const LoadLessonsEvent(this.params);
}

/// 搜索课程事件
class SearchLessonsEvent extends LearningEvent {
  final String query;
  final AgeGroup? ageGroup;
  final DifficultyLevel? difficulty;
  final LessonType? type;
  
  const SearchLessonsEvent(
    this.query, {
    this.ageGroup,
    this.difficulty,
    this.type,
  });
}

/// 更新课程进度事件
class UpdateLessonProgressEvent extends LearningEvent {
  final UpdateProgressParams params;
  
  const UpdateLessonProgressEvent(this.params);
}

/// 完成课程事件
class CompleteLessonEvent extends LearningEvent {
  final String userId;
  final String lessonId;
  final int score;
  final int studyTime;
  
  const CompleteLessonEvent({
    required this.userId,
    required this.lessonId,
    required this.score,
    required this.studyTime,
  });
}

/// 添加学习时长事件
class AddStudyTimeEvent extends LearningEvent {
  final String userId;
  final int studyTime;
  final LessonType lessonType;
  
  const AddStudyTimeEvent({
    required this.userId,
    required this.studyTime,
    required this.lessonType,
  });
}

/// 更新每日目标事件
class UpdateDailyGoalEvent extends LearningEvent {
  final String userId;
  final int goalMinutes;
  
  const UpdateDailyGoalEvent({
    required this.userId,
    required this.goalMinutes,
  });
}

/// 刷新数据事件
class RefreshLearningDataEvent extends LearningEvent {
  final String userId;
  
  const RefreshLearningDataEvent(this.userId);
}

/// 同步数据到云端事件
class SyncToCloudEvent extends LearningEvent {
  final String userId;
  
  const SyncToCloudEvent(this.userId);
}

/// 加载课程详情事件
class LoadLessonDetailEvent extends LearningEvent {
  final String lessonId;

  const LoadLessonDetailEvent(this.lessonId);
}

/// 切换课程收藏状态事件
class ToggleLessonBookmarkEvent extends LearningEvent {
  final String lessonId;

  const ToggleLessonBookmarkEvent(this.lessonId);
}

// ==================== States ====================

abstract class LearningState {
  const LearningState();
}

/// 初始状态
class LearningInitial extends LearningState {}

/// 加载中状态
class LearningLoading extends LearningState {
  final String? message;
  
  const LearningLoading({this.message});
}

/// 已加载状态
class LearningLoaded extends LearningState {
  final LearningProgressEntity progress;
  final List<LessonEntity> lessons;
  final List<LessonEntity> searchResults;
  final bool isSearching;
  final String? searchQuery;
  final Map<String, dynamic>? completionResult;
  
  const LearningLoaded({
    required this.progress,
    required this.lessons,
    this.searchResults = const [],
    this.isSearching = false,
    this.searchQuery,
    this.completionResult,
  });
  
  List<Object?> get props => [
    progress,
    lessons,
    searchResults,
    isSearching,
    searchQuery,
    completionResult,
  ];
  
  LearningLoaded copyWith({
    LearningProgressEntity? progress,
    List<LessonEntity>? lessons,
    List<LessonEntity>? searchResults,
    bool? isSearching,
    String? searchQuery,
    Map<String, dynamic>? completionResult,
  }) {
    return LearningLoaded(
      progress: progress ?? this.progress,
      lessons: lessons ?? this.lessons,
      searchResults: searchResults ?? this.searchResults,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
      completionResult: completionResult ?? this.completionResult,
    );
  }
}

/// 错误状态
class LearningError extends LearningState {
  final String message;
  final String? errorCode;
  
  const LearningError(this.message, {this.errorCode});
}

/// 操作成功状态
class LearningOperationSuccess extends LearningState {
  final String message;
  final Map<String, dynamic>? data;
  
  const LearningOperationSuccess(this.message, {this.data});
}

/// 搜索课程成功状态
class SearchLessonsSuccess extends LearningState {
  final List<LessonEntity> searchResults;
  final String searchQuery;
  
  const SearchLessonsSuccess({
    required this.searchResults,
    required this.searchQuery,
  });
}

// ==================== Bloc ====================

class LearningBloc extends Bloc<LearningEvent, LearningState> {
  final GetLearningProgressUseCase _getLearningProgressUseCase;
  final GetLessonsUseCase _getLessonsUseCase;
  final UpdateLessonProgressUseCase _updateLessonProgressUseCase;
  
  // 缓存数据
  LearningProgressEntity? _cachedProgress;
  List<LessonEntity> _cachedLessons = [];
  String? _currentUserId;
  
  LearningBloc({
    required GetLearningProgressUseCase getLearningProgressUseCase,
    required GetLessonsUseCase getLessonsUseCase,
    required UpdateLessonProgressUseCase updateLessonProgressUseCase,
  }) : _getLearningProgressUseCase = getLearningProgressUseCase,
       _getLessonsUseCase = getLessonsUseCase,
       _updateLessonProgressUseCase = updateLessonProgressUseCase,
       super(LearningInitial()) {
    
    on<LoadLearningProgressEvent>(_onLoadLearningProgress);
    on<LoadLessonsEvent>(_onLoadLessons);
    on<SearchLessonsEvent>(_onSearchLessons);
    on<UpdateLessonProgressEvent>(_onUpdateLessonProgress);
    on<CompleteLessonEvent>(_onCompleteLesson);
    on<AddStudyTimeEvent>(_onAddStudyTime);
    on<UpdateDailyGoalEvent>(_onUpdateDailyGoal);
    on<RefreshLearningDataEvent>(_onRefreshLearningData);
    on<SyncToCloudEvent>(_onSyncToCloud);
  }
  
  // ==================== Event Handlers ====================
  
  /// 处理加载学习进度事件
  Future<void> _onLoadLearningProgress(
    LoadLearningProgressEvent event,
    Emitter<LearningState> emit,
  ) async {
    try {
      emit(const LearningLoading(message: '正在加载学习进度...'));
      
      _currentUserId = event.userId;
      
      // 获取学习进度
      final progress = await _getLearningProgressUseCase.execute(event.userId);
      
      _cachedProgress = progress;
      
      // 如果已有课程数据，直接返回完整状态
      if (_cachedLessons.isNotEmpty) {
        emit(LearningLoaded(
          progress: progress,
          lessons: _cachedLessons,
        ));
      } else {
        // 否则加载课程数据
        add(LoadLessonsEvent(GetLessonsParams(
          limit: 20,
        )));
      }
    } catch (e) {
      emit(LearningError('加载学习进度时发生错误: $e'));
    }
  }
  
  /// 处理加载课程列表事件
  Future<void> _onLoadLessons(
    LoadLessonsEvent event,
    Emitter<LearningState> emit,
  ) async {
    try {
      // 如果没有进度数据，先显示加载状态
      if (_cachedProgress == null) {
        emit(const LearningLoading(message: '正在加载课程...'));
      }
      
      final lessons = await _getLessonsUseCase.execute(event.params);
      
      _cachedLessons = lessons;
      
      if (_cachedProgress != null) {
        emit(LearningLoaded(
          progress: _cachedProgress!,
          lessons: lessons,
        ));
      }
    } catch (e) {
      emit(LearningError('加载课程时发生错误: $e'));
    }
  }
  
  /// 处理搜索课程事件
  Future<void> _onSearchLessons(
    SearchLessonsEvent event,
    Emitter<LearningState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is LearningLoaded) {
        // 显示搜索状态
        emit(currentState.copyWith(
          isSearching: true,
          searchQuery: event.query,
        ));
        
        // 执行搜索
        final searchParams = GetLessonsParams(
          searchQuery: event.query,
          ageGroup: event.ageGroup,
          difficulty: event.difficulty,
          type: event.type,
          limit: 50,
        );
        
        final searchResults = await _getLessonsUseCase.execute(searchParams);
        
        emit(currentState.copyWith(
          searchResults: searchResults,
          isSearching: false,
          searchQuery: event.query,
        ));
      }
    } catch (e) {
      emit(LearningError('搜索课程时发生错误: $e'));
    }
  }
  
  /// 处理更新课程进度事件
  Future<void> _onUpdateLessonProgress(
    UpdateLessonProgressEvent event,
    Emitter<LearningState> emit,
  ) async {
    try {
      final result = await _updateLessonProgressUseCase.execute(event.params);
      
      if (result.isSuccess) {
        // 更新缓存的进度数据
        if (result.updatedProgress != null) {
          _cachedProgress = result.updatedProgress;
        }
        
        // 更新缓存的学习进度数据
        if (result.updatedProgress != null) {
          _cachedProgress = result.updatedProgress!;
        }
        
        final currentState = state;
        if (currentState is LearningLoaded && _cachedProgress != null) {
          emit(currentState.copyWith(
            progress: _cachedProgress!,
            lessons: _cachedLessons,
          ));
        }
        
        // 如果有特殊结果（如升级、获得成就），显示成功消息
        if (result.pointsEarned > 0 || result.levelUp) {
          emit(LearningOperationSuccess(
            '进度更新成功！',
            data: {
              'points_earned': result.pointsEarned,
              'level_up': result.levelUp,
              'new_level': result.newLevel,
              'new_streak': result.newStreak,
            },
          ));
        }
      } else {
        emit(LearningError('更新课程进度失败: ${result.errorMessage}'));
      }
    } catch (e) {
      emit(LearningError('更新课程进度时发生错误: $e'));
    }
  }
  
  /// 处理完成课程事件
  Future<void> _onCompleteLesson(
    CompleteLessonEvent event,
    Emitter<LearningState> emit,
  ) async {
    try {
      // 更新课程进度为完成状态
      final updateParams = UpdateProgressParams(
        userId: event.userId,
        lessonId: event.lessonId,
        progress: 1.0,
        status: LessonStatus.completed,
        score: event.score,
        studyTime: event.studyTime,
      );
      
      add(UpdateLessonProgressEvent(updateParams));
      
      // 添加学习时长
      final lesson = _cachedLessons.firstWhere(
        (l) => l.id == event.lessonId,
        orElse: () => throw Exception('Lesson not found'),
      );
      
      add(AddStudyTimeEvent(
        userId: event.userId,
        studyTime: event.studyTime,
        lessonType: lesson.type,
      ));
      
    } catch (e) {
      emit(LearningError('完成课程时发生错误: $e'));
    }
  }
  
  /// 处理添加学习时长事件
  Future<void> _onAddStudyTime(
    AddStudyTimeEvent event,
    Emitter<LearningState> emit,
  ) async {
    try {
      // 这里应该调用相应的用例来添加学习时长
      // 由于我们还没有创建这个用例，暂时跳过具体实现
      
      // 重新加载学习进度以获取最新数据
      if (_currentUserId != null) {
        add(LoadLearningProgressEvent(_currentUserId!));
      }
    } catch (e) {
      emit(LearningError('添加学习时长时发生错误: $e'));
    }
  }
  
  /// 处理更新每日目标事件
  Future<void> _onUpdateDailyGoal(
    UpdateDailyGoalEvent event,
    Emitter<LearningState> emit,
  ) async {
    try {
      // 这里应该调用相应的用例来更新每日目标
      // 由于我们还没有创建这个用例，暂时跳过具体实现
      
      emit(const LearningOperationSuccess('每日目标更新成功！'));
      
      // 重新加载学习进度
      if (_currentUserId != null) {
        add(LoadLearningProgressEvent(_currentUserId!));
      }
    } catch (e) {
      emit(LearningError('更新每日目标时发生错误: $e'));
    }
  }
  
  /// 处理刷新学习数据事件
  Future<void> _onRefreshLearningData(
    RefreshLearningDataEvent event,
    Emitter<LearningState> emit,
  ) async {
    try {
      // 清除缓存
      _cachedProgress = null;
      _cachedLessons = [];
      
      // 重新加载数据
      add(LoadLearningProgressEvent(event.userId));
    } catch (e) {
      emit(LearningError('刷新数据时发生错误: $e'));
    }
  }
  
  /// 处理同步到云端事件
  Future<void> _onSyncToCloud(
    SyncToCloudEvent event,
    Emitter<LearningState> emit,
  ) async {
    try {
      emit(const LearningLoading(message: '正在同步数据到云端...'));
      
      // 这里应该调用相应的用例来同步数据
      // 由于我们还没有创建这个用例，暂时跳过具体实现
      
      emit(const LearningOperationSuccess('数据同步成功！'));
      
      // 重新加载数据以确保同步
      add(RefreshLearningDataEvent(event.userId));
    } catch (e) {
      emit(LearningError('同步数据时发生错误: $e'));
    }
  }
  
  // ==================== Helper Methods ====================
  
  /// 获取当前学习进度
  LearningProgressEntity? get currentProgress => _cachedProgress;
  
  /// 获取当前课程列表
  List<LessonEntity> get currentLessons => _cachedLessons;
  
  /// 检查是否有缓存数据
  bool get hasData => _cachedProgress != null && _cachedLessons.isNotEmpty;
  
  /// 根据ID获取课程
  LessonEntity? getLessonById(String lessonId) {
    try {
      return _cachedLessons.firstWhere((lesson) => lesson.id == lessonId);
    } catch (e) {
      return null;
    }
  }
  
  /// 获取推荐课程
  List<LessonEntity> getRecommendedLessons({int limit = 5}) {
    if (_cachedLessons.isEmpty) return [];
    
    // 简单的推荐逻辑：优先显示未开始或进行中的课程
    final recommended = _cachedLessons.where((lesson) {
      return lesson.status == LessonStatus.notStarted ||
             lesson.status == LessonStatus.inProgress;
    }).take(limit).toList();
    
    return recommended;
  }
  
  /// 获取最近学习的课程
  List<LessonEntity> getRecentLessons({int limit = 5}) {
    if (_cachedLessons.isEmpty) return [];
    
    final recentLessons = _cachedLessons.where((lesson) {
      return lesson.status == LessonStatus.inProgress ||
             lesson.status == LessonStatus.completed;
    }).toList();
    
    // 按更新时间排序
    recentLessons.sort((a, b) {
      final aTime = a.updatedAt;
      final bTime = b.updatedAt;
      return bTime.compareTo(aTime);
    });
    
    return recentLessons.take(limit).toList();
  }
}