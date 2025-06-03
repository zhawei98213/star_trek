import 'lesson_entity.dart';

/// 学习进度实体
/// 
/// 跟踪用户的整体学习进度和统计数据
class LearningProgressEntity {
  /// 用户ID
  final String userId;
  
  /// 总学习时长（分钟）
  final int totalStudyTime;
  
  /// 已完成课程数量
  final int completedLessons;
  
  /// 总课程数量
  final int totalLessons;
  
  /// 当前连续学习天数
  final int currentStreak;
  
  /// 最长连续学习天数
  final int longestStreak;
  
  /// 总积分
  final int totalPoints;
  
  /// 当前等级
  final int currentLevel;
  
  /// 当前等级进度（0.0 - 1.0）
  final double levelProgress;
  
  /// 各课程类型的进度
  final Map<LessonType, CategoryProgress> categoryProgress;
  
  /// 每日学习目标（分钟）
  final int dailyGoal;
  
  /// 今日已学习时长（分钟）
  final int todayStudyTime;
  
  /// 本周学习统计
  final List<DailyStudyRecord> weeklyStats;
  
  /// 最后学习时间
  final DateTime? lastStudyTime;
  
  /// 创建时间
  final DateTime createdAt;
  
  /// 最后更新时间
  final DateTime updatedAt;
  
  const LearningProgressEntity({
    required this.userId,
    required this.totalStudyTime,
    required this.completedLessons,
    required this.totalLessons,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalPoints,
    required this.currentLevel,
    required this.levelProgress,
    required this.categoryProgress,
    required this.dailyGoal,
    required this.todayStudyTime,
    required this.weeklyStats,
    required this.createdAt,
    required this.updatedAt,
    this.lastStudyTime,
  });
  
  /// 获取总体完成进度（0.0 - 1.0）
  double get overallProgress {
    if (totalLessons == 0) return 0.0;
    return completedLessons / totalLessons;
  }
  
  /// 获取总体完成百分比
  int get overallProgressPercentage => (overallProgress * 100).round();
  
  /// 是否完成今日目标
  bool get isDailyGoalCompleted => todayStudyTime >= dailyGoal;
  
  /// 今日目标完成进度（0.0 - 1.0）
  double get dailyGoalProgress {
    if (dailyGoal == 0) return 1.0;
    return (todayStudyTime / dailyGoal).clamp(0.0, 1.0);
  }
  
  /// 距离下一等级所需积分
  int get pointsToNextLevel {
    final nextLevelPoints = _getPointsForLevel(currentLevel + 1);
    // ignore: unused_local_variable
    final currentLevelPoints = _getPointsForLevel(currentLevel);
    return nextLevelPoints - totalPoints;
  }
  
  /// 获取指定等级所需的总积分
  int _getPointsForLevel(int level) {
    // 等级积分计算公式：level * 1000 + (level - 1) * 500
    if (level <= 1) return 0;
    return level * 1000 + (level - 1) * 500;
  }
  
  /// 复制实体并更新指定字段
  LearningProgressEntity copyWith({
    String? userId,
    int? totalStudyTime,
    int? completedLessons,
    int? totalLessons,
    int? currentStreak,
    int? longestStreak,
    int? totalPoints,
    int? currentLevel,
    double? levelProgress,
    Map<LessonType, CategoryProgress>? categoryProgress,
    int? dailyGoal,
    int? todayStudyTime,
    List<DailyStudyRecord>? weeklyStats,
    DateTime? lastStudyTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LearningProgressEntity(
      userId: userId ?? this.userId,
      totalStudyTime: totalStudyTime ?? this.totalStudyTime,
      completedLessons: completedLessons ?? this.completedLessons,
      totalLessons: totalLessons ?? this.totalLessons,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalPoints: totalPoints ?? this.totalPoints,
      currentLevel: currentLevel ?? this.currentLevel,
      levelProgress: levelProgress ?? this.levelProgress,
      categoryProgress: categoryProgress ?? this.categoryProgress,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      todayStudyTime: todayStudyTime ?? this.todayStudyTime,
      weeklyStats: weeklyStats ?? this.weeklyStats,
      lastStudyTime: lastStudyTime ?? this.lastStudyTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LearningProgressEntity && other.userId == userId;
  }
  
  @override
  int get hashCode => userId.hashCode;
  
  @override
  String toString() {
    return 'LearningProgressEntity(userId: $userId, level: $currentLevel, progress: $overallProgressPercentage%)';
  }
}

/// 分类进度
class CategoryProgress {
  /// 课程类型
  final LessonType type;
  
  /// 已完成课程数
  final int completedLessons;
  
  /// 总课程数
  final int totalLessons;
  
  /// 总学习时长（分钟）
  final int studyTime;
  
  /// 平均得分
  final double averageScore;
  
  /// 最后学习时间
  final DateTime? lastStudyTime;
  
  const CategoryProgress({
    required this.type,
    required this.completedLessons,
    required this.totalLessons,
    required this.studyTime,
    required this.averageScore,
    this.lastStudyTime,
  });
  
  /// 获取完成进度（0.0 - 1.0）
  double get progress {
    if (totalLessons == 0) return 0.0;
    return completedLessons / totalLessons;
  }
  
  /// 获取完成百分比
  int get progressPercentage => (progress * 100).round();
  
  /// 是否已完成所有课程
  bool get isCompleted => completedLessons >= totalLessons;
  
  /// 复制并更新字段
  CategoryProgress copyWith({
    LessonType? type,
    int? completedLessons,
    int? totalLessons,
    int? studyTime,
    double? averageScore,
    DateTime? lastStudyTime,
  }) {
    return CategoryProgress(
      type: type ?? this.type,
      completedLessons: completedLessons ?? this.completedLessons,
      totalLessons: totalLessons ?? this.totalLessons,
      studyTime: studyTime ?? this.studyTime,
      averageScore: averageScore ?? this.averageScore,
      lastStudyTime: lastStudyTime ?? this.lastStudyTime,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryProgress && other.type == type;
  }
  
  @override
  int get hashCode => type.hashCode;
}

/// 每日学习记录
class DailyStudyRecord {
  /// 日期
  final DateTime date;
  
  /// 学习时长（分钟）
  final int studyTime;
  
  /// 完成课程数
  final int completedLessons;
  
  /// 获得积分
  final int earnedPoints;
  
  /// 是否完成每日目标
  final bool goalCompleted;
  
  const DailyStudyRecord({
    required this.date,
    required this.studyTime,
    required this.completedLessons,
    required this.earnedPoints,
    required this.goalCompleted,
  });
  
  /// 获取日期字符串（YYYY-MM-DD）
  String get dateString {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
  
  /// 复制并更新字段
  DailyStudyRecord copyWith({
    DateTime? date,
    int? studyTime,
    int? completedLessons,
    int? earnedPoints,
    bool? goalCompleted,
  }) {
    return DailyStudyRecord(
      date: date ?? this.date,
      studyTime: studyTime ?? this.studyTime,
      completedLessons: completedLessons ?? this.completedLessons,
      earnedPoints: earnedPoints ?? this.earnedPoints,
      goalCompleted: goalCompleted ?? this.goalCompleted,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DailyStudyRecord && other.dateString == dateString;
  }
  
  @override
  int get hashCode => dateString.hashCode;
  
  @override
  String toString() {
    return 'DailyStudyRecord(date: $dateString, studyTime: ${studyTime}min, lessons: $completedLessons)';
  }
}