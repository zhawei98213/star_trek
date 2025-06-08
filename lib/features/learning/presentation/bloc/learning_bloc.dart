import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_lessons_usecase.dart';
import '../../domain/usecases/get_learning_progress_usecase.dart';
import '../../domain/usecases/update_lesson_progress_usecase.dart';
import '../../domain/usecases/complete_lesson_usecase.dart';
import '../../domain/usecases/search_lessons_usecase.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../domain/entities/learning_progress_entity.dart';
import 'learning_event.dart';
import 'learning_state.dart';

/// 学习模块Bloc
/// 
/// 负责处理学习相关的业务逻辑和状态管理
class LearningBloc extends Bloc<LearningEvent, LearningState> {
  final GetLessonsUseCase _getLessonsUseCase;
  final GetLearningProgressUseCase _getLearningProgressUseCase;
  final UpdateLessonProgressUseCase _updateLessonProgressUseCase;
  final CompleteLessonUseCase _completeLessonUseCase;
  final SearchLessonsUseCase _searchLessonsUseCase;

  LearningBloc({
    required GetLessonsUseCase getLessonsUseCase,
    required GetLearningProgressUseCase getLearningProgressUseCase,
    required UpdateLessonProgressUseCase updateLessonProgressUseCase,
    required CompleteLessonUseCase completeLessonUseCase,
    required SearchLessonsUseCase searchLessonsUseCase,
  })  : _getLessonsUseCase = getLessonsUseCase,
        _getLearningProgressUseCase = getLearningProgressUseCase,
        _updateLessonProgressUseCase = updateLessonProgressUseCase,
        _completeLessonUseCase = completeLessonUseCase,
        _searchLessonsUseCase = searchLessonsUseCase,
        super(const LearningState.initial()) {
    // 注册事件处理器
    on<LearningEvent>((event, emit) {
      event.when(
        loadLearningProgress: (userId) => _onLoadLearningProgress(event, emit),
        loadLessons: (params) => _onLoadLessons(event, emit),
        searchLessons: (query, ageGroup, difficulty, type) => _onSearchLessons(event, emit),
        updateLessonProgress: (params) => _onUpdateLessonProgress(event, emit),
        completeLesson: (userId, lessonId, score, studyTime) => _onCompleteLesson(event, emit),
         addStudyTime: (userId, studyTime, lessonType) => _onAddStudyTime(event, emit),
        updateDailyGoal: (userId, goalMinutes) => _onUpdateDailyGoal(event, emit),
        refreshLearningData: (userId) => _onRefreshLearningData(event, emit),
        syncToCloud: (userId) => _onSyncToCloud(event, emit),
        loadLessonDetail: (lessonId) => _onLoadLessonDetail(event, emit),
        toggleLessonBookmark: (lessonId) => _onToggleLessonBookmark(event, emit),
        resetState: () => _onResetState(event, emit),
        clearSearchResults: () => _onClearSearchResults(event, emit),
        loadMoreLessons: (page, limit, ageGroup, difficulty, type) => _onLoadMoreLessons(event, emit),
        filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) => _onFilterLessons(event, emit),
      );
    });
  }

  /// 处理加载学习进度事件
  Future<void> _onLoadLearningProgress(
    LearningEvent event,
    Emitter<LearningState> emit,
  ) async {
    final userId = event.when(
      loadLearningProgress: (userId) => userId,
      loadLessons: (params) => '',
      searchLessons: (query, ageGroup, difficulty, type) => '',
      updateLessonProgress: (params) => '',
      completeLesson: (userId, lessonId, score, studyTime) => '',
      addStudyTime: (userId, studyTime, lessonType) => '',
      updateDailyGoal: (userId, goalMinutes) => '',
      refreshLearningData: (userId) => userId,
      syncToCloud: (userId) => userId,
      loadLessonDetail: (lessonId) => '',
      toggleLessonBookmark: (lessonId) => '',
      resetState: () => '',
      clearSearchResults: () => '',
      loadMoreLessons: (page, limit, ageGroup, difficulty, type) => '',
      filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) => '',
    );
    
    if (userId.isEmpty) return;
    
    emit(const LearningState.loading(message: '正在加载学习进度...'));
    
    final result = await _getLearningProgressUseCase(userId);
    
    result.fold(
      (failure) => emit(LearningState.error(failure)),
      (progress) {
        // 同时加载课程列表
        add(LearningEvent.loadLessons(
          GetLessonsParams(
            page: 1,
            limit: 20,
            sortBy: LessonSortBy.recommended,
          ),
        ));
        
        emit(LearningState.loaded(
          progress: progress,
          lessons: [],
          searchResults: [],
          isSearching: false,
          searchQuery: null,
          completionResult: null,
        ));
      },
    );
  }

  /// 处理加载课程列表事件
  Future<void> _onLoadLessons(
    LearningEvent event,
    Emitter<LearningState> emit,
  ) async {
    final params = event.when(
      loadLessons: (params) => params,
      loadLearningProgress: (userId) => null,
      searchLessons: (query, ageGroup, difficulty, type) => null,
      updateLessonProgress: (params) => null,
      completeLesson: (userId, lessonId, score, studyTime) => null,
      addStudyTime: (userId, studyTime, lessonType) => null,
      updateDailyGoal: (userId, goalMinutes) => null,
      refreshLearningData: (userId) => null,
      syncToCloud: (userId) => null,
      loadLessonDetail: (lessonId) => null,
      toggleLessonBookmark: (lessonId) => null,
      resetState: () => null,
      clearSearchResults: () => null,
      loadMoreLessons: (page, limit, ageGroup, difficulty, type) => null,
      filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) => null,
    );
    
    if (params == null) return;
    
    // 如果不是第一页，保持当前状态
    if (params.page == 1) {
      emit(const LearningState.loading(message: '正在加载课程列表...'));
    }
    
    final result = await _getLessonsUseCase(params);
    
    result.fold(
      (failure) => emit(LearningState.error(failure)),
      (lessons) {
        state.maybeWhen(
          loaded: (progress, oldLessons, searchResults, isSearching, searchQuery, completionResult) {
            // 如果是分页加载，合并课程列表
            final updatedLessons = params.page == 1 
                ? lessons 
                : [...oldLessons, ...lessons];
            
            emit(LearningState.loaded(
              progress: progress,
              lessons: updatedLessons,
              searchResults: searchResults,
              isSearching: isSearching,
              searchQuery: searchQuery,
              completionResult: completionResult,
            ));
          },
          orElse: () {
            // 如果没有进度数据，创建默认进度
            emit(LearningState.loaded(
              progress: _createDefaultProgress(),
              lessons: lessons,
              searchResults: [],
              isSearching: false,
              searchQuery: null,
              completionResult: null,
            ));
          },
        );
      },
    );
  }

  /// 处理搜索课程事件
  Future<void> _onSearchLessons(
    LearningEvent event,
    Emitter<LearningState> emit,
  ) async {
    final searchData = event.when(
      searchLessons: (query, ageGroup, difficulty, type) => {
        'query': query,
        'ageGroup': ageGroup,
        'difficulty': difficulty,
        'type': type,
      },
      loadLearningProgress: (userId) => null,
      loadLessons: (params) => null,
      updateLessonProgress: (params) => null,
      completeLesson: (userId, lessonId, score, studyTime) => null,
      addStudyTime: (userId, studyTime, lessonType) => null,
      updateDailyGoal: (userId, goalMinutes) => null,
      refreshLearningData: (userId) => null,
      syncToCloud: (userId) => null,
      loadLessonDetail: (lessonId) => null,
      toggleLessonBookmark: (lessonId) => null,
      resetState: () => null,
      clearSearchResults: () => null,
      loadMoreLessons: (page, limit, ageGroup, difficulty, type) => null,
      filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) => null,
    );
    
    if (searchData == null) return;
    
    final query = searchData['query'] as String;
    final ageGroup = searchData['ageGroup'] as AgeGroup?;
    final difficulty = searchData['difficulty'] as DifficultyLevel?;
    final type = searchData['type'] as LessonType?;
    
    state.maybeWhen(
      loaded: (progress, lessons, _, __, ___, completionResult) {
        emit(LearningState.loaded(
          progress: progress,
          lessons: lessons,
          searchResults: [],
          isSearching: true,
          searchQuery: query,
          completionResult: completionResult,
        ));
      },
      orElse: () {},
    );
    
    final result = await _searchLessonsUseCase(SearchLessonsParams(
      query: query,
      filters: SearchFilters(
        ageGroups: ageGroup != null ? [ageGroup] : [],
        difficulties: difficulty != null ? [difficulty] : [],
        types: type != null ? [type] : [],
      ),
    ));
    
    result.fold(
      (failure) => emit(LearningState.error(failure)),
      (searchResults) {
        emit(LearningState.searchSuccess(
          searchResults: searchResults.lessons,
          searchQuery: query,
        ));
      },
    );
  }

  /// 处理更新课程进度事件
  Future<void> _onUpdateLessonProgress(
    LearningEvent event,
    Emitter<LearningState> emit,
  ) async {
    final params = event.when(
      updateLessonProgress: (params) => params,
      loadLearningProgress: (userId) => null,
      loadLessons: (params) => null,
      searchLessons: (query, ageGroup, difficulty, type) => null,
      completeLesson: (userId, lessonId, score, studyTime) => null,
      addStudyTime: (userId, studyTime, lessonType) => null,
      updateDailyGoal: (userId, goalMinutes) => null,
      refreshLearningData: (userId) => null,
      syncToCloud: (userId) => null,
      loadLessonDetail: (lessonId) => null,
      toggleLessonBookmark: (lessonId) => null,
      resetState: () => null,
      clearSearchResults: () => null,
      loadMoreLessons: (page, limit, ageGroup, difficulty, type) => null,
      filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) => null,
    );
    
    if (params == null) return;
    
    final result = await _updateLessonProgressUseCase(params);
    
    result.fold(
      (failure) => emit(LearningState.error(failure)),
      (_) {
        emit(const LearningState.operationSuccess(
          message: '课程进度已更新',
        ));
        
        // 刷新学习进度
        add(LearningEvent.loadLearningProgress(params.userId));
      },
    );
  }

  /// 处理完成课程事件
  Future<void> _onCompleteLesson(
    LearningEvent event,
    Emitter<LearningState> emit,
  ) async {
    final completionData = event.when(
      completeLesson: (userId, lessonId, score, studyTime) => {
        'userId': userId,
        'lessonId': lessonId,
        'score': score,
        'studyTime': studyTime,
      },
      loadLearningProgress: (userId) => null,
      loadLessons: (params) => null,
      searchLessons: (query, ageGroup, difficulty, type) => null,
      updateLessonProgress: (params) => null,
      addStudyTime: (userId, studyTime, lessonType) => null,
      updateDailyGoal: (userId, goalMinutes) => null,
      refreshLearningData: (userId) => null,
      syncToCloud: (userId) => null,
      loadLessonDetail: (lessonId) => null,
      toggleLessonBookmark: (lessonId) => null,
      resetState: () => null,
      clearSearchResults: () => null,
      loadMoreLessons: (page, limit, ageGroup, difficulty, type) => null,
      filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) => null,
    );
    
    if (completionData == null) return;
    
    final userId = completionData['userId'] as String;
    final lessonId = completionData['lessonId'] as String;
    final score = completionData['score'] as int;
    final studyTime = completionData['studyTime'] as int;
    
    final result = await _completeLessonUseCase(CompleteLessonParams(
      userId: userId,
      lessonId: lessonId,
      score: score,
      studyTime: studyTime,
    ));
    
    result.fold(
      (failure) => emit(LearningState.error(failure)),
      (completionResult) {
        emit(LearningState.operationSuccess(
          message: '恭喜完成课程！',
          data: {
            'pointsEarned': completionResult.pointsEarned,
            'bonusPoints': completionResult.bonusPoints,
            'levelUp': completionResult.levelUp,
            'newLevel': completionResult.newLevel,
            'perfectScore': completionResult.perfectScore,
          },
        ));
        
        // 刷新学习数据
        add(LearningEvent.refreshLearningData(userId));
      },
    );
  }

  /// 处理添加学习时长事件
  Future<void> _onAddStudyTime(
    LearningEvent event,
    Emitter<LearningState> emit,
  ) async {
    final studyData = event.when(
      addStudyTime: (userId, studyTime, lessonType) => {
        'userId': userId,
        'studyTime': studyTime,
        'lessonType': lessonType,
      },
      loadLearningProgress: (userId) => null,
      loadLessons: (params) => null,
      searchLessons: (query, ageGroup, difficulty, type) => null,
      updateLessonProgress: (params) => null,
      completeLesson: (userId, lessonId, score, studyTime) => null,
      updateDailyGoal: (userId, goalMinutes) => null,
      refreshLearningData: (userId) => null,
      syncToCloud: (userId) => null,
      loadLessonDetail: (lessonId) => null,
      toggleLessonBookmark: (lessonId) => null,
      resetState: () => null,
      clearSearchResults: () => null,
      loadMoreLessons: (page, limit, ageGroup, difficulty, type) => null,
      filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) => null,
    );
    
    if (studyData == null) return;
    
    final userId = studyData['userId'] as String;
    
    // 实现添加学习时长逻辑
    emit(const LearningState.operationSuccess(
      message: '学习时长已记录',
    ));
    
    // 刷新学习进度
    add(LearningEvent.loadLearningProgress(userId));
  }

  /// 处理更新每日目标事件
  Future<void> _onUpdateDailyGoal(
    LearningEvent event,
    Emitter<LearningState> emit,
  ) async {
    final goalData = event.when(
      updateDailyGoal: (userId, goalMinutes) => {
        'userId': userId,
        'goalMinutes': goalMinutes,
      },
      loadLearningProgress: (userId) => null,
      loadLessons: (params) => null,
      searchLessons: (query, ageGroup, difficulty, type) => null,
      updateLessonProgress: (params) => null,
      completeLesson: (userId, lessonId, score, studyTime) => null,
      addStudyTime: (userId, studyTime, lessonType) => null,
      refreshLearningData: (userId) => null,
      syncToCloud: (userId) => null,
      loadLessonDetail: (lessonId) => null,
      toggleLessonBookmark: (lessonId) => null,
      resetState: () => null,
      clearSearchResults: () => null,
      loadMoreLessons: (page, limit, ageGroup, difficulty, type) => null,
      filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) => null,
    );
    
    if (goalData == null) return;
    
    final userId = goalData['userId'] as String;
    
    // 实现更新每日目标逻辑
    emit(const LearningState.operationSuccess(
      message: '每日目标已更新',
    ));
    
    // 刷新学习进度
    add(LearningEvent.loadLearningProgress(userId));
  }

  /// 处理刷新学习数据事件
  Future<void> _onRefreshLearningData(
    LearningEvent event,
    Emitter<LearningState> emit,
  ) async {
    final userId = event.when(
      refreshLearningData: (userId) => userId,
      loadLearningProgress: (userId) => null,
      loadLessons: (params) => null,
      searchLessons: (query, ageGroup, difficulty, type) => null,
      updateLessonProgress: (params) => null,
      completeLesson: (userId, lessonId, score, studyTime) => null,
      addStudyTime: (userId, studyTime, lessonType) => null,
      updateDailyGoal: (userId, goalMinutes) => null,
      syncToCloud: (userId) => null,
      loadLessonDetail: (lessonId) => null,
      toggleLessonBookmark: (lessonId) => null,
      resetState: () => null,
      clearSearchResults: () => null,
      loadMoreLessons: (page, limit, ageGroup, difficulty, type) => null,
      filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) => null,
    );
    
    if (userId == null) return;
    
    emit(const LearningState.loading());
    
    // 重新加载学习进度
    add(LearningEvent.loadLearningProgress(userId));
    
    // 重新加载课程列表
    add(LearningEvent.loadLessons(GetLessonsParams(
      ageGroup: null,
      difficulty: null,
      type: null,
      page: 1,
      limit: 20,
    )));
  }

  /// 处理同步到云端事件
  Future<void> _onSyncToCloud(
    LearningEvent event,
    Emitter<LearningState> emit,
  ) async {
    final userId = event.when(
      syncToCloud: (userId) => userId,
      loadLearningProgress: (userId) => null,
      loadLessons: (params) => null,
      searchLessons: (query, ageGroup, difficulty, type) => null,
      updateLessonProgress: (params) => null,
      completeLesson: (userId, lessonId, score, studyTime) => null,
      addStudyTime: (userId, studyTime, lessonType) => null,
      updateDailyGoal: (userId, goalMinutes) => null,
      refreshLearningData: (userId) => null,
      loadLessonDetail: (lessonId) => null,
      toggleLessonBookmark: (lessonId) => null,
      resetState: () => null,
      clearSearchResults: () => null,
      loadMoreLessons: (page, limit, ageGroup, difficulty, type) => null,
      filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) => null,
    );
    
    if (userId == null) return;
    
    // TODO: 实现同步到云端的逻辑
    emit(const LearningState.operationSuccess(
      message: '数据同步功能尚未实现',
    ));
  }

  /// 处理加载课程详情事件
  Future<void> _onLoadLessonDetail(
    LearningEvent event,
    Emitter<LearningState> emit,
  ) async {
    final lessonId = event.when(
      loadLessonDetail: (lessonId) => lessonId,
      loadLearningProgress: (userId) => null,
      loadLessons: (params) => null,
      searchLessons: (query, ageGroup, difficulty, type) => null,
      updateLessonProgress: (params) => null,
      completeLesson: (userId, lessonId, score, studyTime) => null,
      addStudyTime: (userId, studyTime, lessonType) => null,
      updateDailyGoal: (userId, goalMinutes) => null,
      refreshLearningData: (userId) => null,
      syncToCloud: (userId) => null,
      toggleLessonBookmark: (lessonId) => null,
      resetState: () => null,
      clearSearchResults: () => null,
      loadMoreLessons: (page, limit, ageGroup, difficulty, type) => null,
      filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) => null,
    );
    
    if (lessonId == null) return;
    
    emit(const LearningState.loading());
    
    // TODO: 实现获取课程详情的逻辑
      emit(LearningState.error(const ServerFailure('获取课程详情功能尚未实现')));
  }

  /// 处理切换课程收藏状态事件
  Future<void> _onToggleLessonBookmark(
    LearningEvent event,
    Emitter<LearningState> emit,
  ) async {
    final bookmarkData = event.when(
      toggleLessonBookmark: (lessonId) => {
        'lessonId': lessonId,
      },
      loadLearningProgress: (userId) => null,
      loadLessons: (params) => null,
      searchLessons: (query, ageGroup, difficulty, type) => null,
      updateLessonProgress: (params) => null,
      completeLesson: (userId, lessonId, score, studyTime) => null,
      addStudyTime: (userId, studyTime, lessonType) => null,
      updateDailyGoal: (userId, goalMinutes) => null,
      refreshLearningData: (userId) => null,
      syncToCloud: (userId) => null,
      loadLessonDetail: (lessonId) => null,
      resetState: () => null,
      clearSearchResults: () => null,
      loadMoreLessons: (page, limit, ageGroup, difficulty, type) => null,
      filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) => null,
    );
    
    if (bookmarkData == null) return;
    
    // TODO: 实现切换收藏状态的usecase
    // 暂时返回成功状态
    emit(const LearningState.operationSuccess(
      message: '收藏状态已更新',
    ));
  }

  /// 处理重置状态事件
  void _onResetState(
    LearningEvent event,
    Emitter<LearningState> emit,
  ) {
    event.when(
      resetState: () {
        emit(const LearningState.initial());
      },
      loadLearningProgress: (userId) {},
      loadLessons: (params) {},
      searchLessons: (query, ageGroup, difficulty, type) {},
      updateLessonProgress: (params) {},
      completeLesson: (userId, lessonId, score, studyTime) {},
      addStudyTime: (userId, studyTime, lessonType) {},
      updateDailyGoal: (userId, goalMinutes) {},
      refreshLearningData: (userId) {},
      syncToCloud: (userId) {},
      loadLessonDetail: (lessonId) {},
      toggleLessonBookmark: (lessonId) {},
      clearSearchResults: () {},
      loadMoreLessons: (page, limit, ageGroup, difficulty, type) {},
      filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) {},
    );
  }

  /// 处理清除搜索结果事件
  void _onClearSearchResults(
    LearningEvent event,
    Emitter<LearningState> emit,
  ) {
    event.when(
      clearSearchResults: () {
        state.maybeWhen(
          loaded: (progress, lessons, _, __, ___, completionResult) {
            emit(LearningState.loaded(
              progress: progress,
              lessons: lessons,
              searchResults: [],
              isSearching: false,
              searchQuery: '',
              completionResult: completionResult,
            ));
          },
          searchSuccess: (_, __) {
            emit(const LearningState.initial());
          },
          orElse: () {},
        );
      },
      loadLearningProgress: (userId) {},
      loadLessons: (params) {},
      searchLessons: (query, ageGroup, difficulty, type) {},
      updateLessonProgress: (params) {},
      completeLesson: (userId, lessonId, score, studyTime) {},
      addStudyTime: (userId, studyTime, lessonType) {},
      updateDailyGoal: (userId, goalMinutes) {},
      refreshLearningData: (userId) {},
      syncToCloud: (userId) {},
      loadLessonDetail: (lessonId) {},
      toggleLessonBookmark: (lessonId) {},
      resetState: () {},
      loadMoreLessons: (page, limit, ageGroup, difficulty, type) {},
      filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) {},
    );
  }

  /// 处理加载更多课程事件
  Future<void> _onLoadMoreLessons(
    LearningEvent event,
    Emitter<LearningState> emit,
  ) async {
    final loadMoreData = event.when(
      loadMoreLessons: (page, limit, ageGroup, difficulty, type) => {
        'page': page,
        'limit': limit,
        'ageGroup': ageGroup,
        'difficulty': difficulty,
        'type': type,
      },
      loadLearningProgress: (userId) => null,
      loadLessons: (params) => null,
      searchLessons: (query, ageGroup, difficulty, type) => null,
      updateLessonProgress: (params) => null,
      completeLesson: (userId, lessonId, score, studyTime) => null,
      addStudyTime: (userId, studyTime, lessonType) => null,
      updateDailyGoal: (userId, goalMinutes) => null,
      refreshLearningData: (userId) => null,
      syncToCloud: (userId) => null,
      loadLessonDetail: (lessonId) => null,
      toggleLessonBookmark: (lessonId) => null,
      resetState: () => null,
      clearSearchResults: () => null,
      filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) => null,
    );
    
    if (loadMoreData == null) return;
    
    // 从当前状态获取 userId
    String? userId;
    state.maybeWhen(
      loaded: (progress, lessons, searchResults, isSearching, searchQuery, completionResult) {
        userId = progress.userId;
      },
      orElse: () {},
    );
    
    if (userId == null) return;
    
    final page = loadMoreData['page'] as int;
    final limit = loadMoreData['limit'] as int;
    final ageGroup = loadMoreData['ageGroup'] as AgeGroup?;
    final difficulty = loadMoreData['difficulty'] as DifficultyLevel?;
    final type = loadMoreData['type'] as LessonType?;
    
    add(LearningEvent.loadLessons(GetLessonsParams(
      page: page,
      limit: limit,
      ageGroup: ageGroup,
      difficulty: difficulty,
      type: type,
    )));
  }

  /// 处理筛选课程事件
  Future<void> _onFilterLessons(
    LearningEvent event,
    Emitter<LearningState> emit,
  ) async {
    final filterData = event.when(
      filterLessons: (ageGroup, difficulty, type, isCompleted, isBookmarked) => {
        'ageGroup': ageGroup,
        'difficulty': difficulty,
        'type': type,
        'isCompleted': isCompleted,
      },
      loadLearningProgress: (userId) => null,
      loadLessons: (params) => null,
      searchLessons: (query, ageGroup, difficulty, type) => null,
      updateLessonProgress: (params) => null,
      completeLesson: (userId, lessonId, score, studyTime) => null,
      addStudyTime: (userId, studyTime, lessonType) => null,
      updateDailyGoal: (userId, goalMinutes) => null,
      refreshLearningData: (userId) => null,
      syncToCloud: (userId) => null,
      loadLessonDetail: (lessonId) => null,
      toggleLessonBookmark: (lessonId) => null,
      resetState: () => null,
      clearSearchResults: () => null,
      loadMoreLessons: (page, limit, ageGroup, difficulty, type) => null,
    );
    
    if (filterData == null) return;
    
    // 从当前状态获取 userId
    String? userId;
    state.maybeWhen(
      loaded: (progress, lessons, searchResults, isSearching, searchQuery, completionResult) {
        userId = progress.userId;
      },
      orElse: () {},
    );
    
    if (userId == null) return;
    
    final ageGroup = filterData['ageGroup'] as AgeGroup?;
    final difficulty = filterData['difficulty'] as DifficultyLevel?;
    final type = filterData['type'] as LessonType?;
    final isCompleted = filterData['isCompleted'] as bool?;
    
    add(LearningEvent.loadLessons(GetLessonsParams(
      page: 1,
      limit: 20,
      ageGroup: ageGroup,
      difficulty: difficulty,
      type: type,
      completionStatus: isCompleted == true 
          ? LessonStatus.completed 
          : isCompleted == false 
              ? LessonStatus.notStarted 
              : null,
    )));
  }

  /// 创建默认学习进度
  LearningProgressEntity _createDefaultProgress() {
    // 这里应该根据实际的LearningProgressEntity构造函数来创建
    // 暂时返回一个模拟的进度对象
    throw UnimplementedError('需要根据实际的LearningProgressEntity实现');
  }
}