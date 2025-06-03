import '../entities/lesson_entity.dart';
import '../repositories/learning_repository.dart';

/// 获取课程列表用例
/// 
/// 负责获取和筛选课程列表的业务逻辑
class GetLessonsUseCase {
  final LearningRepository _repository;
  
  const GetLessonsUseCase(this._repository);
  
  /// 执行获取课程列表
  /// 
  /// [params] 筛选参数
  Future<List<LessonEntity>> execute(GetLessonsParams params) async {
    try {
      // 从仓库获取课程列表
      final lessons = await _repository.getLessons(
        ageGroup: params.ageGroup,
        difficulty: params.difficulty,
        type: params.type,
      );
      
      // 应用额外的筛选和排序逻辑
      var filteredLessons = lessons;
      
      // 根据解锁状态筛选
      if (params.onlyUnlocked) {
        filteredLessons = filteredLessons
            .where((lesson) => lesson.isUnlocked)
            .toList();
      }
      
      // 根据完成状态筛选
      if (params.completionStatus != null) {
        filteredLessons = filteredLessons
            .where((lesson) => lesson.status == params.completionStatus)
            .toList();
      }
      
      // 根据搜索关键词筛选
      if (params.searchQuery != null && params.searchQuery!.isNotEmpty) {
        final query = params.searchQuery!.toLowerCase();
        filteredLessons = filteredLessons
            .where((lesson) =>
                lesson.title.toLowerCase().contains(query) ||
                lesson.description.toLowerCase().contains(query))
            .toList();
      }
      
      // 应用排序
      _sortLessons(filteredLessons, params.sortBy);
      
      // 应用分页
      if (params.limit != null) {
        final startIndex = (params.page - 1) * params.limit!;
        final endIndex = startIndex + params.limit!;
        
        if (startIndex < filteredLessons.length) {
          filteredLessons = filteredLessons.sublist(
            startIndex,
            endIndex > filteredLessons.length
                ? filteredLessons.length
                : endIndex,
          );
        } else {
          filteredLessons = [];
        }
      }
      
      return filteredLessons;
    } catch (e) {
      // 发生错误时返回空列表
      return [];
    }
  }
  
  /// 对课程列表进行排序
  /// 
  /// [lessons] 课程列表
  /// [sortBy] 排序方式
  void _sortLessons(List<LessonEntity> lessons, LessonSortBy sortBy) {
    switch (sortBy) {
      case LessonSortBy.title:
        lessons.sort((a, b) => a.title.compareTo(b.title));
        break;
      case LessonSortBy.difficulty:
        lessons.sort((a, b) => a.difficulty.index.compareTo(b.difficulty.index));
        break;
      case LessonSortBy.duration:
        lessons.sort((a, b) => a.estimatedDuration.compareTo(b.estimatedDuration));
        break;
      case LessonSortBy.progress:
        lessons.sort((a, b) => b.progress.compareTo(a.progress));
        break;
      case LessonSortBy.recent:
        lessons.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;
      case LessonSortBy.recommended:
        // 推荐排序：优先显示进行中的课程，然后是未开始的，最后是已完成的
        lessons.sort((a, b) {
          if (a.status == b.status) {
            return a.title.compareTo(b.title);
          }
          
          // 进行中的课程优先级最高
          if (a.status == LessonStatus.inProgress) return -1;
          if (b.status == LessonStatus.inProgress) return 1;
          
          // 未开始的课程次优先
          if (a.status == LessonStatus.notStarted) return -1;
          if (b.status == LessonStatus.notStarted) return 1;
          
          // 已完成的课程最后
          return 0;
        });
        break;
    }
  }
}

/// 获取课程列表的参数
class GetLessonsParams {
  /// 年龄组筛选
  final AgeGroup? ageGroup;
  
  /// 难度筛选
  final DifficultyLevel? difficulty;
  
  /// 课程类型筛选
  final LessonType? type;
  
  /// 完成状态筛选
  final LessonStatus? completionStatus;
  
  /// 是否只显示已解锁的课程
  final bool onlyUnlocked;
  
  /// 搜索关键词
  final String? searchQuery;
  
  /// 排序方式
  final LessonSortBy sortBy;
  
  /// 页码（从1开始）
  final int page;
  
  /// 每页数量限制
  final int? limit;
  
  const GetLessonsParams({
    this.ageGroup,
    this.difficulty,
    this.type,
    this.completionStatus,
    this.onlyUnlocked = false,
    this.searchQuery,
    this.sortBy = LessonSortBy.recommended,
    this.page = 1,
    this.limit,
  });
  
  /// 复制并更新参数
  GetLessonsParams copyWith({
    AgeGroup? ageGroup,
    DifficultyLevel? difficulty,
    LessonType? type,
    LessonStatus? completionStatus,
    bool? onlyUnlocked,
    String? searchQuery,
    LessonSortBy? sortBy,
    int? page,
    int? limit,
  }) {
    return GetLessonsParams(
      ageGroup: ageGroup ?? this.ageGroup,
      difficulty: difficulty ?? this.difficulty,
      type: type ?? this.type,
      completionStatus: completionStatus ?? this.completionStatus,
      onlyUnlocked: onlyUnlocked ?? this.onlyUnlocked,
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }
  
  @override
  String toString() {
    return 'GetLessonsParams(ageGroup: $ageGroup, difficulty: $difficulty, type: $type, sortBy: $sortBy)';
  }
}

/// 课程排序方式
enum LessonSortBy {
  /// 按标题排序
  title,
  /// 按难度排序
  difficulty,
  /// 按时长排序
  duration,
  /// 按进度排序
  progress,
  /// 按最近更新排序
  recent,
  /// 推荐排序
  recommended,
}