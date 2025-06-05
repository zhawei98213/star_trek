/// 用户统计数据实体
/// 包含用户的学习统计和成就信息
class UserStatsEntity {
  final String userId;
  final String username;
  final String avatarUrl;
  final int level;
  final int totalPoints;
  final int currentLevelPoints;
  final int nextLevelPoints;
  final LearningStatsData learningStats;
  final AchievementStatsData achievementStats;
  final StreakData streakData;
  final RankingData rankingData;
  final DateTime lastUpdated;
  
  const UserStatsEntity({
    required this.userId,
    required this.username,
    required this.avatarUrl,
    required this.level,
    required this.totalPoints,
    required this.currentLevelPoints,
    required this.nextLevelPoints,
    required this.learningStats,
    required this.achievementStats,
    required this.streakData,
    required this.rankingData,
    required this.lastUpdated,
  });
  
  UserStatsEntity copyWith({
    String? userId,
    String? username,
    String? avatarUrl,
    int? level,
    int? totalPoints,
    int? currentLevelPoints,
    int? nextLevelPoints,
    LearningStatsData? learningStats,
    AchievementStatsData? achievementStats,
    StreakData? streakData,
    RankingData? rankingData,
    DateTime? lastUpdated,
  }) {
    return UserStatsEntity(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      level: level ?? this.level,
      totalPoints: totalPoints ?? this.totalPoints,
      currentLevelPoints: currentLevelPoints ?? this.currentLevelPoints,
      nextLevelPoints: nextLevelPoints ?? this.nextLevelPoints,
      learningStats: learningStats ?? this.learningStats,
      achievementStats: achievementStats ?? this.achievementStats,
      streakData: streakData ?? this.streakData,
      rankingData: rankingData ?? this.rankingData,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
  
  /// 计算当前等级进度百分比
  double get levelProgress {
    if (nextLevelPoints <= currentLevelPoints) return 1.0;
    return currentLevelPoints / nextLevelPoints;
  }
  
  /// 获取到下一等级还需要的点数
  int get pointsToNextLevel {
    return nextLevelPoints - currentLevelPoints;
  }
  
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'avatarUrl': avatarUrl,
      'level': level,
      'totalPoints': totalPoints,
      'currentLevelPoints': currentLevelPoints,
      'nextLevelPoints': nextLevelPoints,
      'learningStats': learningStats.toJson(),
      'achievementStats': achievementStats.toJson(),
      'streakData': streakData.toJson(),
      'rankingData': rankingData.toJson(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
  
  factory UserStatsEntity.fromJson(Map<String, dynamic> json) {
    return UserStatsEntity(
      userId: json['userId'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String,
      level: json['level'] as int,
      totalPoints: json['totalPoints'] as int,
      currentLevelPoints: json['currentLevelPoints'] as int,
      nextLevelPoints: json['nextLevelPoints'] as int,
      learningStats: LearningStatsData.fromJson(
        json['learningStats'] as Map<String, dynamic>,
      ),
      achievementStats: AchievementStatsData.fromJson(
        json['achievementStats'] as Map<String, dynamic>,
      ),
      streakData: StreakData.fromJson(
        json['streakData'] as Map<String, dynamic>,
      ),
      rankingData: RankingData.fromJson(
        json['rankingData'] as Map<String, dynamic>,
      ),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }
}

/// 学习统计数据
class LearningStatsData {
  final int totalStudyTime; // 总学习时间（分钟）
  final int todayStudyTime; // 今日学习时间（分钟）
  final int weekStudyTime; // 本周学习时间（分钟）
  final int monthStudyTime; // 本月学习时间（分钟）
  final int completedLessons; // 完成的课程数
  final int totalLessons; // 总课程数
  final int completedChallenges; // 完成的挑战数
  final double averageScore; // 平均分数
  final List<DailyStudyData> weeklyStudyData; // 一周的学习数据
  final Map<String, int> subjectProgress; // 各科目进度
  
  const LearningStatsData({
    required this.totalStudyTime,
    required this.todayStudyTime,
    required this.weekStudyTime,
    required this.monthStudyTime,
    required this.completedLessons,
    required this.totalLessons,
    required this.completedChallenges,
    required this.averageScore,
    required this.weeklyStudyData,
    required this.subjectProgress,
  });
  
  /// 计算学习完成率
  double get completionRate {
    if (totalLessons == 0) return 0.0;
    return completedLessons / totalLessons;
  }
  
  /// 获取今日学习目标完成率（假设目标是30分钟）
  double get todayGoalProgress {
    const dailyGoal = 30; // 30分钟目标
    return (todayStudyTime / dailyGoal).clamp(0.0, 1.0);
  }
  
  Map<String, dynamic> toJson() {
    return {
      'totalStudyTime': totalStudyTime,
      'todayStudyTime': todayStudyTime,
      'weekStudyTime': weekStudyTime,
      'monthStudyTime': monthStudyTime,
      'completedLessons': completedLessons,
      'totalLessons': totalLessons,
      'completedChallenges': completedChallenges,
      'averageScore': averageScore,
      'weeklyStudyData': weeklyStudyData.map((e) => e.toJson()).toList(),
      'subjectProgress': subjectProgress,
    };
  }
  
  factory LearningStatsData.fromJson(Map<String, dynamic> json) {
    return LearningStatsData(
      totalStudyTime: json['totalStudyTime'] as int,
      todayStudyTime: json['todayStudyTime'] as int,
      weekStudyTime: json['weekStudyTime'] as int,
      monthStudyTime: json['monthStudyTime'] as int,
      completedLessons: json['completedLessons'] as int,
      totalLessons: json['totalLessons'] as int,
      completedChallenges: json['completedChallenges'] as int,
      averageScore: (json['averageScore'] as num).toDouble(),
      weeklyStudyData: (json['weeklyStudyData'] as List<dynamic>)
          .map((e) => DailyStudyData.fromJson(e as Map<String, dynamic>))
          .toList(),
      subjectProgress: Map<String, int>.from(json['subjectProgress'] as Map),
    );
  }
}

/// 每日学习数据
class DailyStudyData {
  final DateTime date;
  final int studyTime; // 学习时间（分钟）
  final int completedLessons;
  final double averageScore;
  
  const DailyStudyData({
    required this.date,
    required this.studyTime,
    required this.completedLessons,
    required this.averageScore,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'studyTime': studyTime,
      'completedLessons': completedLessons,
      'averageScore': averageScore,
    };
  }
  
  factory DailyStudyData.fromJson(Map<String, dynamic> json) {
    return DailyStudyData(
      date: DateTime.parse(json['date'] as String),
      studyTime: json['studyTime'] as int,
      completedLessons: json['completedLessons'] as int,
      averageScore: (json['averageScore'] as num).toDouble(),
    );
  }
}

/// 成就统计数据
class AchievementStatsData {
  final int totalAchievements; // 总成就数
  final int unlockedAchievements; // 已解锁成就数
  final int recentAchievements; // 最近获得的成就数
  final List<String> featuredAchievements; // 精选成就ID列表
  final Map<String, int> categoryProgress; // 各类别成就进度
  
  const AchievementStatsData({
    required this.totalAchievements,
    required this.unlockedAchievements,
    required this.recentAchievements,
    required this.featuredAchievements,
    required this.categoryProgress,
  });
  
  /// 计算成就完成率
  double get achievementRate {
    if (totalAchievements == 0) return 0.0;
    return unlockedAchievements / totalAchievements;
  }
  
  Map<String, dynamic> toJson() {
    return {
      'totalAchievements': totalAchievements,
      'unlockedAchievements': unlockedAchievements,
      'recentAchievements': recentAchievements,
      'featuredAchievements': featuredAchievements,
      'categoryProgress': categoryProgress,
    };
  }
  
  factory AchievementStatsData.fromJson(Map<String, dynamic> json) {
    return AchievementStatsData(
      totalAchievements: json['totalAchievements'] as int,
      unlockedAchievements: json['unlockedAchievements'] as int,
      recentAchievements: json['recentAchievements'] as int,
      featuredAchievements: List<String>.from(json['featuredAchievements'] as List),
      categoryProgress: Map<String, int>.from(json['categoryProgress'] as Map),
    );
  }
}

/// 连续学习数据
class StreakData {
  final int currentStreak; // 当前连续天数
  final int longestStreak; // 最长连续天数
  final DateTime lastStudyDate; // 最后学习日期
  final bool isTodayCompleted; // 今日是否完成学习
  final int streakGoal; // 连续学习目标天数
  
  const StreakData({
    required this.currentStreak,
    required this.longestStreak,
    required this.lastStudyDate,
    required this.isTodayCompleted,
    required this.streakGoal,
  });
  
  /// 计算连续学习目标进度
  double get streakGoalProgress {
    if (streakGoal == 0) return 0.0;
    return (currentStreak / streakGoal).clamp(0.0, 1.0);
  }
  
  /// 检查是否需要提醒学习
  bool get needsStudyReminder {
    final today = DateTime.now();
    final lastStudy = DateTime(lastStudyDate.year, lastStudyDate.month, lastStudyDate.day);
    final todayDate = DateTime(today.year, today.month, today.day);
    
    return !isTodayCompleted && todayDate.isAfter(lastStudy);
  }
  
  Map<String, dynamic> toJson() {
    return {
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastStudyDate': lastStudyDate.toIso8601String(),
      'isTodayCompleted': isTodayCompleted,
      'streakGoal': streakGoal,
    };
  }
  
  factory StreakData.fromJson(Map<String, dynamic> json) {
    return StreakData(
      currentStreak: json['currentStreak'] as int,
      longestStreak: json['longestStreak'] as int,
      lastStudyDate: DateTime.parse(json['lastStudyDate'] as String),
      isTodayCompleted: json['isTodayCompleted'] as bool,
      streakGoal: json['streakGoal'] as int,
    );
  }
}

/// 排名数据
class RankingData {
  final int globalRank; // 全球排名
  final int localRank; // 本地排名（同年龄段或同地区）
  final int friendsRank; // 好友排名
  final int totalUsers; // 总用户数
  final List<RankingUserData> topUsers; // 排行榜前几名
  final RankingTrendData trend; // 排名趋势
  
  const RankingData({
    required this.globalRank,
    required this.localRank,
    required this.friendsRank,
    required this.totalUsers,
    required this.topUsers,
    required this.trend,
  });
  
  /// 计算全球排名百分比
  double get globalRankPercentile {
    if (totalUsers == 0) return 0.0;
    return ((totalUsers - globalRank) / totalUsers * 100).clamp(0.0, 100.0);
  }
  
  Map<String, dynamic> toJson() {
    return {
      'globalRank': globalRank,
      'localRank': localRank,
      'friendsRank': friendsRank,
      'totalUsers': totalUsers,
      'topUsers': topUsers.map((e) => e.toJson()).toList(),
      'trend': trend.toJson(),
    };
  }
  
  factory RankingData.fromJson(Map<String, dynamic> json) {
    return RankingData(
      globalRank: json['globalRank'] as int,
      localRank: json['localRank'] as int,
      friendsRank: json['friendsRank'] as int,
      totalUsers: json['totalUsers'] as int,
      topUsers: (json['topUsers'] as List<dynamic>)
          .map((e) => RankingUserData.fromJson(e as Map<String, dynamic>))
          .toList(),
      trend: RankingTrendData.fromJson(
        json['trend'] as Map<String, dynamic>,
      ),
    );
  }
}

/// 排名用户数据
class RankingUserData {
  final String userId;
  final String username;
  final String avatarUrl;
  final int rank;
  final int points;
  final int level;
  
  const RankingUserData({
    required this.userId,
    required this.username,
    required this.avatarUrl,
    required this.rank,
    required this.points,
    required this.level,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'avatarUrl': avatarUrl,
      'rank': rank,
      'points': points,
      'level': level,
    };
  }
  
  factory RankingUserData.fromJson(Map<String, dynamic> json) {
    return RankingUserData(
      userId: json['userId'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String,
      rank: json['rank'] as int,
      points: json['points'] as int,
      level: json['level'] as int,
    );
  }
}

/// 排名趋势数据
class RankingTrendData {
  final int previousRank;
  final int rankChange; // 正数表示上升，负数表示下降
  final TrendDirection direction;
  final DateTime lastUpdated;
  
  const RankingTrendData({
    required this.previousRank,
    required this.rankChange,
    required this.direction,
    required this.lastUpdated,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'previousRank': previousRank,
      'rankChange': rankChange,
      'direction': direction.name,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
  
  factory RankingTrendData.fromJson(Map<String, dynamic> json) {
    return RankingTrendData(
      previousRank: json['previousRank'] as int,
      rankChange: json['rankChange'] as int,
      direction: TrendDirection.values.firstWhere(
        (e) => e.name == json['direction'],
      ),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }
}

/// 趋势方向枚举
enum TrendDirection {
  up,    // 上升
  down,  // 下降
  stable // 稳定
}