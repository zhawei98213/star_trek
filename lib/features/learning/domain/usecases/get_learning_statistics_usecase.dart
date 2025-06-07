import '../entities/lesson_entity.dart';
import '../entities/learning_progress_entity.dart';
import '../repositories/learning_repository.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';

/// 获取学习统计用例
/// 
/// 提供详细的学习数据分析，包括时间分布、进度统计、成就分析等
class GetLearningStatisticsUseCase {
  final LearningRepository _repository;
  
  const GetLearningStatisticsUseCase(this._repository);
  
  /// 获取学习统计数据
  /// 
  /// [userId] 用户ID
  /// [timeRange] 时间范围（可选，默认为全部时间）
  Future<Either<Failure, LearningStatistics>> execute(
    String userId, {
    StatisticsTimeRange timeRange = StatisticsTimeRange.all,
  }) async {
    try {
      // 获取基础学习进度
      final progress = await _repository.getLearningProgress(userId);
      if (progress == null) {
        return Left(NotFoundFailure('用户学习进度不存在'));
      }
      
      // 获取用户完成的课程列表
      final completedLessons = await _repository.getCompletedLessons(userId);
      
      // 获取时间范围内的学习记录
      final studyRecords = await _getStudyRecordsInRange(userId, timeRange);
      
      // 计算各项统计数据
      final timeStats = _calculateTimeStatistics(studyRecords, timeRange);
      final progressStats = _calculateProgressStatistics(progress, completedLessons);
      final categoryStats = _calculateCategoryStatistics(progress, completedLessons);
      final achievementStats = _calculateAchievementStatistics(progress, completedLessons);
      final streakStats = _calculateStreakStatistics(progress, studyRecords);
      final performanceStats = _calculatePerformanceStatistics(completedLessons);
      
      final statistics = LearningStatistics(
        userId: userId,
        timeRange: timeRange,
        generatedAt: DateTime.now(),
        timeStatistics: timeStats,
        progressStatistics: progressStats,
        categoryStatistics: categoryStats,
        achievementStatistics: achievementStats,
        streakStatistics: streakStats,
        performanceStatistics: performanceStats,
        totalLessonsAvailable: await _repository.getTotalLessonsCount(),
        studyRecords: studyRecords,
      );
      
      return Right(statistics);
    } catch (e) {
      return Left(ServerFailure('获取学习统计失败: ${e.toString()}'));
    }
  }
  
  /// 获取指定时间范围内的学习记录
  Future<List<DailyStudyRecord>> _getStudyRecordsInRange(
    String userId,
    StatisticsTimeRange timeRange,
  ) async {
    final now = DateTime.now();
    DateTime startDate;
    
    switch (timeRange) {
      case StatisticsTimeRange.week:
        startDate = now.subtract(const Duration(days: 7));
        break;
      case StatisticsTimeRange.month:
        startDate = DateTime(now.year, now.month - 1, now.day);
        break;
      case StatisticsTimeRange.threeMonths:
        startDate = DateTime(now.year, now.month - 3, now.day);
        break;
      case StatisticsTimeRange.year:
        startDate = DateTime(now.year - 1, now.month, now.day);
        break;
      case StatisticsTimeRange.all:
        return await _repository.getAllStudyRecords(userId);
    }
    
    return await _repository.getStudyRecordsInRange(userId, startDate, now);
  }
  
  /// 计算时间统计
  TimeStatistics _calculateTimeStatistics(
    List<DailyStudyRecord> records,
    StatisticsTimeRange timeRange,
  ) {
    if (records.isEmpty) {
      return TimeStatistics.empty();
    }
    
    final totalMinutes = records.fold<int>(0, (sum, record) => sum + record.studyTime);
    final studyDays = records.where((r) => r.studyTime > 0).length;
    final averageDaily = studyDays > 0 ? totalMinutes / studyDays : 0.0;
    
    // 计算每周分布
    final weeklyDistribution = <int, int>{};
    for (final record in records) {
      final weekday = record.date.weekday;
      weeklyDistribution[weekday] = (weeklyDistribution[weekday] ?? 0) + record.studyTime;
    }
    
    // 计算每小时分布（如果有详细时间数据）
    final hourlyDistribution = <int, int>{};
    // 这里可以根据实际需求实现小时级别的统计
    
    // 找出最长学习日
    final longestStudyDay = records.isNotEmpty
        ? records.reduce((a, b) => a.studyTime > b.studyTime ? a : b)
        : null;
    
    return TimeStatistics(
      totalStudyTime: totalMinutes,
      studyDays: studyDays,
      averageDailyTime: averageDaily,
      longestStudyDay: longestStudyDay,
      weeklyDistribution: weeklyDistribution,
      hourlyDistribution: hourlyDistribution,
      timeRange: timeRange,
    );
  }
  
  /// 计算进度统计
  ProgressStatistics _calculateProgressStatistics(
    LearningProgressEntity progress,
    List<LessonEntity> completedLessons,
  ) {
    final completionRate = progress.totalLessons > 0
        ? progress.completedLessons / progress.totalLessons
        : 0.0;
    
    // 计算各难度完成情况
    final difficultyCompletion = <DifficultyLevel, int>{};
    for (final lesson in completedLessons) {
      difficultyCompletion[lesson.difficulty] = 
          (difficultyCompletion[lesson.difficulty] ?? 0) + 1;
    }
    
    // 计算平均分数
    final scoresWithValues = completedLessons
        .where((l) => l.bestScore != null)
        .map((l) => l.bestScore!)
        .toList();
    final averageScore = scoresWithValues.isNotEmpty
        ? scoresWithValues.reduce((a, b) => a + b) / scoresWithValues.length
        : 0.0;
    
    return ProgressStatistics(
      completedLessons: progress.completedLessons,
      totalLessons: progress.totalLessons,
      completionRate: completionRate,
      currentLevel: progress.currentLevel,
      totalPoints: progress.totalPoints,
      levelProgress: progress.levelProgress,
      difficultyCompletion: difficultyCompletion,
      averageScore: averageScore,
      perfectScores: completedLessons.where((l) => l.bestScore == 100).length,
    );
  }
  
  /// 计算分类统计
  CategoryStatistics _calculateCategoryStatistics(
    LearningProgressEntity progress,
    List<LessonEntity> completedLessons,
  ) {
    final categoryProgress = Map<LessonType, CategoryProgress>.from(progress.categoryProgress);
    
    // 计算每个分类的完成课程数
    final categoryCompletion = <LessonType, int>{};
    for (final lesson in completedLessons) {
      categoryCompletion[lesson.type] = (categoryCompletion[lesson.type] ?? 0) + 1;
    }
    
    // 找出最喜欢的分类（完成课程最多的）
    LessonType? favoriteCategory;
    int maxCompleted = 0;
    for (final entry in categoryCompletion.entries) {
      if (entry.value > maxCompleted) {
        maxCompleted = entry.value;
        favoriteCategory = entry.key;
      }
    }
    
    return CategoryStatistics(
      categoryProgress: categoryProgress,
      categoryCompletion: categoryCompletion,
      favoriteCategory: favoriteCategory,
      totalCategories: LessonType.values.length,
      completedCategories: categoryProgress.values
          .where((cp) => cp.completedLessons > 0)
          .length,
    );
  }
  
  /// 计算成就统计
  AchievementStatistics _calculateAchievementStatistics(
    LearningProgressEntity progress,
    List<LessonEntity> completedLessons,
  ) {
    // 这里可以实现复杂的成就系统统计
    // 目前提供基础统计
    
    final milestones = <String, bool>{
      'first_lesson': progress.completedLessons >= 1,
      'ten_lessons': progress.completedLessons >= 10,
      'fifty_lessons': progress.completedLessons >= 50,
      'hundred_lessons': progress.completedLessons >= 100,
      'level_5': progress.currentLevel >= 5,
      'level_10': progress.currentLevel >= 10,
      'week_streak': progress.currentStreak >= 7,
      'month_streak': progress.currentStreak >= 30,
    };
    
    final unlockedCount = milestones.values.where((achieved) => achieved).length;
    
    return AchievementStatistics(
      unlockedAchievements: unlockedCount,
      totalAchievements: milestones.length,
      achievementRate: unlockedCount / milestones.length,
      milestones: milestones,
      recentAchievements: [], // 可以从数据库获取最近解锁的成就
    );
  }
  
  /// 计算连续学习统计
  StreakStatistics _calculateStreakStatistics(
    LearningProgressEntity progress,
    List<DailyStudyRecord> records,
  ) {
    // 计算历史连续学习记录
    final streakHistory = <int>[];
    int currentStreak = 0;
    
    // 按日期排序
    records.sort((a, b) => a.date.compareTo(b.date));
    
    DateTime? lastDate;
    for (final record in records) {
      if (record.studyTime > 0) {
        if (lastDate == null || 
            record.date.difference(lastDate).inDays == 1) {
          currentStreak++;
        } else if (record.date.difference(lastDate).inDays > 1) {
          if (currentStreak > 0) {
            streakHistory.add(currentStreak);
          }
          currentStreak = 1;
        }
        lastDate = record.date;
      } else {
        if (currentStreak > 0) {
          streakHistory.add(currentStreak);
          currentStreak = 0;
        }
      }
    }
    
    if (currentStreak > 0) {
      streakHistory.add(currentStreak);
    }
    
    final averageStreak = streakHistory.isNotEmpty
        ? streakHistory.reduce((a, b) => a + b) / streakHistory.length
        : 0.0;
    
    return StreakStatistics(
      currentStreak: progress.currentStreak,
      longestStreak: progress.longestStreak,
      averageStreak: averageStreak,
      streakHistory: streakHistory,
      totalStreaks: streakHistory.length,
    );
  }
  
  /// 计算表现统计
  PerformanceStatistics _calculatePerformanceStatistics(
    List<LessonEntity> completedLessons,
  ) {
    if (completedLessons.isEmpty) {
      return PerformanceStatistics.empty();
    }
    
    // 计算分数分布
    final scoreDistribution = <int, int>{};
    final scores = completedLessons
        .where((l) => l.bestScore != null)
        .map((l) => l.bestScore!)
        .toList();
    
    for (final score in scores) {
      final range = (score / 10).floor() * 10;
      scoreDistribution[range] = (scoreDistribution[range] ?? 0) + 1;
    }
    
    // 计算改进趋势（最近10课 vs 之前的平均分）
    double improvementTrend = 0.0;
    if (scores.length >= 10) {
      final recent = scores.skip(scores.length - 10).toList();
      final earlier = scores.take(scores.length - 10).toList();
      
      final recentAvg = recent.reduce((a, b) => a + b) / recent.length;
      final earlierAvg = earlier.reduce((a, b) => a + b) / earlier.length;
      
      improvementTrend = recentAvg - earlierAvg;
    }
    
    return PerformanceStatistics(
      averageScore: scores.isNotEmpty ? scores.reduce((a, b) => a + b) / scores.length : 0.0,
      highestScore: scores.isNotEmpty ? scores.reduce((a, b) => a > b ? a : b) : 0,
      lowestScore: scores.isNotEmpty ? scores.reduce((a, b) => a < b ? a : b) : 0,
      scoreDistribution: scoreDistribution,
      improvementTrend: improvementTrend,
      perfectScoreCount: scores.where((s) => s == 100).length,
      totalScoredLessons: scores.length,
    );
  }
}

/// 统计时间范围
enum StatisticsTimeRange {
  week,
  month,
  threeMonths,
  year,
  all,
}

/// 学习统计数据
class LearningStatistics {
  final String userId;
  final StatisticsTimeRange timeRange;
  final DateTime generatedAt;
  final TimeStatistics timeStatistics;
  final ProgressStatistics progressStatistics;
  final CategoryStatistics categoryStatistics;
  final AchievementStatistics achievementStatistics;
  final StreakStatistics streakStatistics;
  final PerformanceStatistics performanceStatistics;
  final int totalLessonsAvailable;
  final List<DailyStudyRecord> studyRecords;
  
  const LearningStatistics({
    required this.userId,
    required this.timeRange,
    required this.generatedAt,
    required this.timeStatistics,
    required this.progressStatistics,
    required this.categoryStatistics,
    required this.achievementStatistics,
    required this.streakStatistics,
    required this.performanceStatistics,
    required this.totalLessonsAvailable,
    required this.studyRecords,
  });
}

/// 时间统计
class TimeStatistics {
  final int totalStudyTime; // 总学习时间（分钟）
  final int studyDays; // 学习天数
  final double averageDailyTime; // 平均每日学习时间
  final DailyStudyRecord? longestStudyDay; // 最长学习日
  final Map<int, int> weeklyDistribution; // 每周分布（1-7对应周一到周日）
  final Map<int, int> hourlyDistribution; // 每小时分布（0-23）
  final StatisticsTimeRange timeRange;
  
  const TimeStatistics({
    required this.totalStudyTime,
    required this.studyDays,
    required this.averageDailyTime,
    required this.longestStudyDay,
    required this.weeklyDistribution,
    required this.hourlyDistribution,
    required this.timeRange,
  });
  
  factory TimeStatistics.empty() {
    return const TimeStatistics(
      totalStudyTime: 0,
      studyDays: 0,
      averageDailyTime: 0.0,
      longestStudyDay: null,
      weeklyDistribution: {},
      hourlyDistribution: {},
      timeRange: StatisticsTimeRange.all,
    );
  }
}

/// 进度统计
class ProgressStatistics {
  final int completedLessons;
  final int totalLessons;
  final double completionRate;
  final int currentLevel;
  final int totalPoints;
  final double levelProgress;
  final Map<DifficultyLevel, int> difficultyCompletion;
  final double averageScore;
  final int perfectScores;
  
  const ProgressStatistics({
    required this.completedLessons,
    required this.totalLessons,
    required this.completionRate,
    required this.currentLevel,
    required this.totalPoints,
    required this.levelProgress,
    required this.difficultyCompletion,
    required this.averageScore,
    required this.perfectScores,
  });
}

/// 分类统计
class CategoryStatistics {
  final Map<LessonType, CategoryProgress> categoryProgress;
  final Map<LessonType, int> categoryCompletion;
  final LessonType? favoriteCategory;
  final int totalCategories;
  final int completedCategories;
  
  const CategoryStatistics({
    required this.categoryProgress,
    required this.categoryCompletion,
    required this.favoriteCategory,
    required this.totalCategories,
    required this.completedCategories,
  });
}

/// 成就统计
class AchievementStatistics {
  final int unlockedAchievements;
  final int totalAchievements;
  final double achievementRate;
  final Map<String, bool> milestones;
  final List<String> recentAchievements;
  
  const AchievementStatistics({
    required this.unlockedAchievements,
    required this.totalAchievements,
    required this.achievementRate,
    required this.milestones,
    required this.recentAchievements,
  });
}

/// 连续学习统计
class StreakStatistics {
  final int currentStreak;
  final int longestStreak;
  final double averageStreak;
  final List<int> streakHistory;
  final int totalStreaks;
  
  const StreakStatistics({
    required this.currentStreak,
    required this.longestStreak,
    required this.averageStreak,
    required this.streakHistory,
    required this.totalStreaks,
  });
}

/// 表现统计
class PerformanceStatistics {
  final double averageScore;
  final int highestScore;
  final int lowestScore;
  final Map<int, int> scoreDistribution; // 分数段分布
  final double improvementTrend; // 改进趋势
  final int perfectScoreCount;
  final int totalScoredLessons;
  
  const PerformanceStatistics({
    required this.averageScore,
    required this.highestScore,
    required this.lowestScore,
    required this.scoreDistribution,
    required this.improvementTrend,
    required this.perfectScoreCount,
    required this.totalScoredLessons,
  });
  
  factory PerformanceStatistics.empty() {
    return const PerformanceStatistics(
      averageScore: 0.0,
      highestScore: 0,
      lowestScore: 0,
      scoreDistribution: {},
      improvementTrend: 0.0,
      perfectScoreCount: 0,
      totalScoredLessons: 0,
    );
  }
}