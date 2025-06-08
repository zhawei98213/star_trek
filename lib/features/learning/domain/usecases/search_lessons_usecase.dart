import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/lesson_entity.dart';
import '../repositories/learning_repository.dart';

/// 搜索课程用例
/// 
/// 提供强大的课程搜索、筛选和排序功能
class SearchLessonsUseCase implements UseCase<SearchResult, SearchLessonsParams> {
  final LearningRepository _repository;
  
  const SearchLessonsUseCase(this._repository);
  
  /// 执行课程搜索
  /// 
  /// [params] 搜索参数
  /// 返回搜索结果，包含课程列表和搜索元数据
  @override
  Future<Either<Failure, SearchResult>> call(
    SearchLessonsParams params,
  ) async {
    try {
      // 1. 获取基础课程列表
      Either<Failure, List<LessonEntity>> lessonsResult;
      
      if (params.query.isNotEmpty) {
        // 如果有搜索关键词，进行文本搜索
        lessonsResult = await _repository.searchLessons(params.query);
      } else {
        // 否则获取所有课程
        lessonsResult = await _repository.getLessons();
      }
      
      return await lessonsResult.fold(
        (failure) async => Left(failure),
        (lessons) async {
          // 2. 应用筛选条件
          var filteredLessons = _applyFilters(lessons, params.filters);
          
          // 3. 应用排序
          filteredLessons = _applySorting(filteredLessons, params.sortBy, params.sortOrder);
          
          // 4. 应用分页
          final paginatedResult = _applyPagination(filteredLessons, params.page, params.pageSize);
          
          // 5. 生成搜索建议（如果搜索结果较少）
          final suggestions = await _generateSuggestions(
            params.query,
            filteredLessons.length,
            params.filters,
          );
          
          // 6. 构建搜索结果
          final result = SearchResult(
            lessons: paginatedResult.items,
            totalCount: filteredLessons.length,
            page: params.page,
            pageSize: params.pageSize,
            totalPages: paginatedResult.totalPages,
            hasNextPage: paginatedResult.hasNextPage,
            hasPreviousPage: paginatedResult.hasPreviousPage,
            query: params.query,
            filters: params.filters,
            sortBy: params.sortBy,
            sortOrder: params.sortOrder,
            suggestions: suggestions,
            searchTime: DateTime.now(),
          );
          
          return Right(result);
        },
      );
    } catch (e) {
      return Left(ServerFailure('搜索课程失败: ${e.toString()}'));
    }
  }
  
  /// 应用筛选条件
  List<LessonEntity> _applyFilters(
    List<LessonEntity> lessons,
    SearchFilters filters,
  ) {
    var filteredLessons = lessons;
    
    // 按课程类型筛选
    if (filters.types.isNotEmpty) {
      filteredLessons = filteredLessons
          .where((lesson) => filters.types.contains(lesson.type))
          .toList();
    }
    
    // 按难度筛选
    if (filters.difficulties.isNotEmpty) {
      filteredLessons = filteredLessons
          .where((lesson) => filters.difficulties.contains(lesson.difficulty))
          .toList();
    }
    
    // 按年龄组筛选
    if (filters.ageGroups.isNotEmpty) {
      filteredLessons = filteredLessons
          .where((lesson) => filters.ageGroups.contains(lesson.ageGroup))
          .toList();
    }
    
    // 按完成状态筛选
    if (filters.completionStatus.isNotEmpty) {
      filteredLessons = filteredLessons
          .where((lesson) => filters.completionStatus.contains(lesson.status))
          .toList();
    }
    
    // 按解锁状态筛选
    if (filters.unlockedOnly) {
      filteredLessons = filteredLessons
          .where((lesson) => lesson.isUnlocked)
          .toList();
    }
    
    // 按学习时长筛选
    if (filters.minDuration != null) {
      filteredLessons = filteredLessons
          .where((lesson) => lesson.estimatedDuration >= filters.minDuration!)
          .toList();
    }
    
    if (filters.maxDuration != null) {
      filteredLessons = filteredLessons
          .where((lesson) => lesson.estimatedDuration <= filters.maxDuration!)
          .toList();
    }
    
    // 按进度筛选
    if (filters.minProgress != null) {
      filteredLessons = filteredLessons
          .where((lesson) => lesson.progress >= filters.minProgress!)
          .toList();
    }
    
    if (filters.maxProgress != null) {
      filteredLessons = filteredLessons
          .where((lesson) => lesson.progress <= filters.maxProgress!)
          .toList();
    }
    
    // 按分数筛选
    if (filters.minScore != null) {
      filteredLessons = filteredLessons
          .where((lesson) => lesson.bestScore != null && lesson.bestScore! >= filters.minScore!)
          .toList();
    }
    
    // 按创建时间筛选
    if (filters.createdAfter != null) {
      filteredLessons = filteredLessons
          .where((lesson) => lesson.createdAt.isAfter(filters.createdAfter!))
          .toList();
    }
    
    if (filters.createdBefore != null) {
      filteredLessons = filteredLessons
          .where((lesson) => lesson.createdAt.isBefore(filters.createdBefore!))
          .toList();
    }
    
    return filteredLessons;
  }
  
  /// 应用排序
  List<LessonEntity> _applySorting(
    List<LessonEntity> lessons,
    SortBy sortBy,
    SortOrder sortOrder,
  ) {
    final sortedLessons = List<LessonEntity>.from(lessons);
    
    switch (sortBy) {
      case SortBy.title:
        sortedLessons.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortBy.difficulty:
        sortedLessons.sort((a, b) => a.difficulty.index.compareTo(b.difficulty.index));
        break;
      case SortBy.duration:
        sortedLessons.sort((a, b) => a.estimatedDuration.compareTo(b.estimatedDuration));
        break;
      case SortBy.progress:
        sortedLessons.sort((a, b) => a.progress.compareTo(b.progress));
        break;
      case SortBy.score:
        sortedLessons.sort((a, b) {
          final scoreA = a.bestScore ?? 0;
          final scoreB = b.bestScore ?? 0;
          return scoreA.compareTo(scoreB);
        });
        break;
      case SortBy.createdAt:
        sortedLessons.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case SortBy.updatedAt:
        sortedLessons.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
        break;
      case SortBy.completionCount:
        sortedLessons.sort((a, b) => a.completionCount.compareTo(b.completionCount));
        break;
      case SortBy.relevance:
        // 相关性排序（基于搜索匹配度）
        // 这里可以实现更复杂的相关性算法
        break;
    }
    
    if (sortOrder == SortOrder.descending) {
      return sortedLessons.reversed.toList();
    }
    
    return sortedLessons;
  }
  
  /// 应用分页
  PaginationResult<LessonEntity> _applyPagination(
    List<LessonEntity> lessons,
    int page,
    int pageSize,
  ) {
    final totalCount = lessons.length;
    final totalPages = (totalCount / pageSize).ceil();
    final startIndex = (page - 1) * pageSize;
    final endIndex = (startIndex + pageSize).clamp(0, totalCount);
    
    final items = startIndex < totalCount
        ? lessons.sublist(startIndex, endIndex)
        : <LessonEntity>[];
    
    return PaginationResult(
      items: items,
      totalCount: totalCount,
      totalPages: totalPages,
      currentPage: page,
      pageSize: pageSize,
      hasNextPage: page < totalPages,
      hasPreviousPage: page > 1,
    );
  }
  
  /// 生成搜索建议
  Future<List<SearchSuggestion>> _generateSuggestions(
    String query,
    int resultCount,
    SearchFilters filters,
  ) async {
    final suggestions = <SearchSuggestion>[];
    
    // 如果搜索结果较少，提供建议
    if (resultCount < 5 && query.isNotEmpty) {
      // 建议移除一些筛选条件
      if (filters.difficulties.isNotEmpty) {
        suggestions.add(SearchSuggestion(
          type: SuggestionType.removeFilter,
          text: '尝试移除难度筛选',
          action: 'remove_difficulty_filter',
        ));
      }
      
      if (filters.types.isNotEmpty) {
        suggestions.add(SearchSuggestion(
          type: SuggestionType.removeFilter,
          text: '尝试移除课程类型筛选',
          action: 'remove_type_filter',
        ));
      }
      
      // 建议相似的搜索词
      final similarQueries = await _getSimilarQueries(query);
      for (final similarQuery in similarQueries) {
        suggestions.add(SearchSuggestion(
          type: SuggestionType.similarQuery,
          text: '试试搜索 "$similarQuery"',
          action: 'search:$similarQuery',
        ));
      }
    }
    
    // 如果没有搜索词，提供热门搜索建议
    if (query.isEmpty) {
      final popularQueries = await _getPopularQueries();
      for (final popularQuery in popularQueries) {
        suggestions.add(SearchSuggestion(
          type: SuggestionType.popular,
          text: popularQuery,
          action: 'search:$popularQuery',
        ));
      }
    }
    
    return suggestions;
  }
  
  /// 获取相似搜索词
  Future<List<String>> _getSimilarQueries(String query) async {
    // 这里可以实现更复杂的相似词算法
    // 目前返回简单的建议
    final suggestions = <String>[];
    
    // 基于常见的拼写错误和同义词
    final synonyms = {
      '字母': ['alphabet', 'abc', '拼音'],
      '数字': ['number', '数学', '计算'],
      '颜色': ['color', '彩色', '色彩'],
      '形状': ['shape', '几何', '图形'],
    };
    
    for (final entry in synonyms.entries) {
      if (query.contains(entry.key)) {
        suggestions.addAll(entry.value);
      }
    }
    
    return suggestions.take(3).toList();
  }
  
  /// 获取热门搜索词
  Future<List<String>> _getPopularQueries() async {
    // 这里可以从数据库获取热门搜索词
    // 目前返回预定义的热门词
    return [
      '字母学习',
      '数字认知',
      '颜色识别',
      '形状配对',
      '简单加法',
    ];
  }
}

/// 搜索参数
class SearchLessonsParams {
  final String query; // 搜索关键词
  final SearchFilters filters; // 筛选条件
  final SortBy sortBy; // 排序字段
  final SortOrder sortOrder; // 排序顺序
  final int page; // 页码
  final int pageSize; // 每页大小
  
  const SearchLessonsParams({
    required this.query,
    required this.filters,
    this.sortBy = SortBy.relevance,
    this.sortOrder = SortOrder.descending,
    this.page = 1,
    this.pageSize = 20,
  });
  
  /// 创建默认搜索参数
  factory SearchLessonsParams.defaultParams(String query) {
    return SearchLessonsParams(
      query: query,
      filters: SearchFilters.empty(),
    );
  }
}

/// 搜索筛选条件
class SearchFilters {
  final List<LessonType> types; // 课程类型
  final List<DifficultyLevel> difficulties; // 难度等级
  final List<AgeGroup> ageGroups; // 年龄组
  final List<LessonStatus> completionStatus; // 完成状态
  final bool unlockedOnly; // 仅显示已解锁
  final int? minDuration; // 最小时长（分钟）
  final int? maxDuration; // 最大时长（分钟）
  final double? minProgress; // 最小进度
  final double? maxProgress; // 最大进度
  final int? minScore; // 最小分数
  final DateTime? createdAfter; // 创建时间之后
  final DateTime? createdBefore; // 创建时间之前
  
  const SearchFilters({
    this.types = const [],
    this.difficulties = const [],
    this.ageGroups = const [],
    this.completionStatus = const [],
    this.unlockedOnly = false,
    this.minDuration,
    this.maxDuration,
    this.minProgress,
    this.maxProgress,
    this.minScore,
    this.createdAfter,
    this.createdBefore,
  });
  
  /// 创建空筛选条件
  factory SearchFilters.empty() {
    return const SearchFilters();
  }
  
  /// 检查是否有活动的筛选条件
  bool get hasActiveFilters {
    return types.isNotEmpty ||
        difficulties.isNotEmpty ||
        ageGroups.isNotEmpty ||
        completionStatus.isNotEmpty ||
        unlockedOnly ||
        minDuration != null ||
        maxDuration != null ||
        minProgress != null ||
        maxProgress != null ||
        minScore != null ||
        createdAfter != null ||
        createdBefore != null;
  }
  
  /// 复制并修改筛选条件
  SearchFilters copyWith({
    List<LessonType>? types,
    List<DifficultyLevel>? difficulties,
    List<AgeGroup>? ageGroups,
    List<LessonStatus>? completionStatus,
    bool? unlockedOnly,
    int? minDuration,
    int? maxDuration,
    double? minProgress,
    double? maxProgress,
    int? minScore,
    DateTime? createdAfter,
    DateTime? createdBefore,
  }) {
    return SearchFilters(
      types: types ?? this.types,
      difficulties: difficulties ?? this.difficulties,
      ageGroups: ageGroups ?? this.ageGroups,
      completionStatus: completionStatus ?? this.completionStatus,
      unlockedOnly: unlockedOnly ?? this.unlockedOnly,
      minDuration: minDuration ?? this.minDuration,
      maxDuration: maxDuration ?? this.maxDuration,
      minProgress: minProgress ?? this.minProgress,
      maxProgress: maxProgress ?? this.maxProgress,
      minScore: minScore ?? this.minScore,
      createdAfter: createdAfter ?? this.createdAfter,
      createdBefore: createdBefore ?? this.createdBefore,
    );
  }
}

/// 排序字段
enum SortBy {
  relevance, // 相关性
  title, // 标题
  difficulty, // 难度
  duration, // 时长
  progress, // 进度
  score, // 分数
  createdAt, // 创建时间
  updatedAt, // 更新时间
  completionCount, // 完成次数
}

/// 排序顺序
enum SortOrder {
  ascending, // 升序
  descending, // 降序
}

/// 搜索结果
class SearchResult {
  final List<LessonEntity> lessons; // 课程列表
  final int totalCount; // 总数量
  final int page; // 当前页
  final int pageSize; // 每页大小
  final int totalPages; // 总页数
  final bool hasNextPage; // 是否有下一页
  final bool hasPreviousPage; // 是否有上一页
  final String query; // 搜索关键词
  final SearchFilters filters; // 筛选条件
  final SortBy sortBy; // 排序字段
  final SortOrder sortOrder; // 排序顺序
  final List<SearchSuggestion> suggestions; // 搜索建议
  final DateTime searchTime; // 搜索时间
  
  const SearchResult({
    required this.lessons,
    required this.totalCount,
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.query,
    required this.filters,
    required this.sortBy,
    required this.sortOrder,
    required this.suggestions,
    required this.searchTime,
  });
  
  /// 是否为空结果
  bool get isEmpty => lessons.isEmpty;
  
  /// 是否有结果
  bool get isNotEmpty => lessons.isNotEmpty;
}

/// 分页结果
class PaginationResult<T> {
  final List<T> items;
  final int totalCount;
  final int totalPages;
  final int currentPage;
  final int pageSize;
  final bool hasNextPage;
  final bool hasPreviousPage;
  
  const PaginationResult({
    required this.items,
    required this.totalCount,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });
}

/// 搜索建议
class SearchSuggestion {
  final SuggestionType type; // 建议类型
  final String text; // 建议文本
  final String action; // 建议操作
  
  const SearchSuggestion({
    required this.type,
    required this.text,
    required this.action,
  });
}

/// 建议类型
enum SuggestionType {
  removeFilter, // 移除筛选
  similarQuery, // 相似查询
  popular, // 热门搜索
  correction, // 拼写纠正
}