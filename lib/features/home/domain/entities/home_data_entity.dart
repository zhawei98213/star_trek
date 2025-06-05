/// 主页数据实体
/// 包含主页显示所需的所有数据
class HomeDataEntity {
  final String userId;
  final LearningProgressData learningProgress;
  final List<QuickActionData> quickActions;
  final List<DailyChallengeData> dailyChallenges;
  final List<AchievementData> recentAchievements;
  final WelcomeMessageData welcomeMessage;
  final DateTime lastUpdated;
  
  const HomeDataEntity({
    required this.userId,
    required this.learningProgress,
    required this.quickActions,
    required this.dailyChallenges,
    required this.recentAchievements,
    required this.welcomeMessage,
    required this.lastUpdated,
  });
  
  HomeDataEntity copyWith({
    String? userId,
    LearningProgressData? learningProgress,
    List<QuickActionData>? quickActions,
    List<DailyChallengeData>? dailyChallenges,
    List<AchievementData>? recentAchievements,
    WelcomeMessageData? welcomeMessage,
    DateTime? lastUpdated,
  }) {
    return HomeDataEntity(
      userId: userId ?? this.userId,
      learningProgress: learningProgress ?? this.learningProgress,
      quickActions: quickActions ?? this.quickActions,
      dailyChallenges: dailyChallenges ?? this.dailyChallenges,
      recentAchievements: recentAchievements ?? this.recentAchievements,
      welcomeMessage: welcomeMessage ?? this.welcomeMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'learningProgress': learningProgress.toJson(),
      'quickActions': quickActions.map((e) => e.toJson()).toList(),
      'dailyChallenges': dailyChallenges.map((e) => e.toJson()).toList(),
      'recentAchievements': recentAchievements.map((e) => e.toJson()).toList(),
      'welcomeMessage': welcomeMessage.toJson(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
  
  factory HomeDataEntity.fromJson(Map<String, dynamic> json) {
    return HomeDataEntity(
      userId: json['userId'] as String,
      learningProgress: LearningProgressData.fromJson(
        json['learningProgress'] as Map<String, dynamic>,
      ),
      quickActions: (json['quickActions'] as List<dynamic>)
          .map((e) => QuickActionData.fromJson(e as Map<String, dynamic>))
          .toList(),
      dailyChallenges: (json['dailyChallenges'] as List<dynamic>)
          .map((e) => DailyChallengeData.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentAchievements: (json['recentAchievements'] as List<dynamic>)
          .map((e) => AchievementData.fromJson(e as Map<String, dynamic>))
          .toList(),
      welcomeMessage: WelcomeMessageData.fromJson(
        json['welcomeMessage'] as Map<String, dynamic>,
      ),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }
}

/// 学习进度数据
class LearningProgressData {
  final double overallProgress;
  final int totalStudyTime;
  final int todayStudyTime;
  final int dailyGoal;
  final List<SkillProgressData> skillProgress;
  final int streak;
  final Map<String, dynamic> data;
  
  const LearningProgressData({
    required this.overallProgress,
    required this.totalStudyTime,
    required this.todayStudyTime,
    required this.dailyGoal,
    required this.skillProgress,
    required this.streak,
    this.data = const {},
  });
  
  LearningProgressData copyWith({
    double? overallProgress,
    int? totalStudyTime,
    int? todayStudyTime,
    int? dailyGoal,
    List<SkillProgressData>? skillProgress,
    int? streak,
    Map<String, dynamic>? data,
  }) {
    return LearningProgressData(
      overallProgress: overallProgress ?? this.overallProgress,
      totalStudyTime: totalStudyTime ?? this.totalStudyTime,
      todayStudyTime: todayStudyTime ?? this.todayStudyTime,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      skillProgress: skillProgress ?? this.skillProgress,
      streak: streak ?? this.streak,
      data: data ?? this.data,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'overallProgress': overallProgress,
      'totalStudyTime': totalStudyTime,
      'todayStudyTime': todayStudyTime,
      'dailyGoal': dailyGoal,
      'skillProgress': skillProgress.map((e) => e.toJson()).toList(),
      'streak': streak,
      'data': data,
    };
  }
  
  factory LearningProgressData.fromJson(Map<String, dynamic> json) {
    return LearningProgressData(
      overallProgress: (json['overallProgress'] as num).toDouble(),
      totalStudyTime: json['totalStudyTime'] as int,
      todayStudyTime: json['todayStudyTime'] as int,
      dailyGoal: json['dailyGoal'] as int,
      skillProgress: (json['skillProgress'] as List<dynamic>)
          .map((e) => SkillProgressData.fromJson(e as Map<String, dynamic>))
          .toList(),
      streak: json['streak'] as int,
      data: json['data'] as Map<String, dynamic>? ?? {},
    );
  }
}

/// 技能进度数据
class SkillProgressData {
  final String skillName;
  final String skillIcon;
  final double progress;
  final int level;
  final String color;
  
  const SkillProgressData({
    required this.skillName,
    required this.skillIcon,
    required this.progress,
    required this.level,
    required this.color,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'skillName': skillName,
      'skillIcon': skillIcon,
      'progress': progress,
      'level': level,
      'color': color,
    };
  }
  
  factory SkillProgressData.fromJson(Map<String, dynamic> json) {
    return SkillProgressData(
      skillName: json['skillName'] as String,
      skillIcon: json['skillIcon'] as String,
      progress: (json['progress'] as num).toDouble(),
      level: json['level'] as int,
      color: json['color'] as String,
    );
  }
}

/// 快速操作数据
class QuickActionData {
  final String id;
  final String title;
  final String subtitle;
  final String icon;
  final String color;
  final String route;
  final bool isEnabled;
  final Map<String, dynamic> data;
  
  const QuickActionData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.route,
    this.isEnabled = true,
    this.data = const {},
  });
  
  QuickActionData copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? icon,
    String? color,
    String? route,
    bool? isEnabled,
    Map<String, dynamic>? data,
  }) {
    return QuickActionData(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      route: route ?? this.route,
      isEnabled: isEnabled ?? this.isEnabled,
      data: data ?? this.data,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'icon': icon,
      'color': color,
      'route': route,
      'isEnabled': isEnabled,
      'data': data,
    };
  }
  
  factory QuickActionData.fromJson(Map<String, dynamic> json) {
    return QuickActionData(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      icon: json['icon'] as String,
      color: json['color'] as String,
      route: json['route'] as String,
      isEnabled: json['isEnabled'] as bool? ?? true,
      data: json['data'] as Map<String, dynamic>? ?? {},
    );
  }
}

/// 每日挑战数据
class DailyChallengeData {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String color;
  final double progress;
  final int targetValue;
  final int currentValue;
  final String reward;
  final bool isCompleted;
  final int? score;
  final DateTime? completedAt;
  
  const DailyChallengeData({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.progress,
    required this.targetValue,
    required this.currentValue,
    required this.reward,
    this.isCompleted = false,
    this.score,
    this.completedAt,
  });
  
  DailyChallengeData copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    String? color,
    double? progress,
    int? targetValue,
    int? currentValue,
    String? reward,
    bool? isCompleted,
    int? score,
    DateTime? completedAt,
  }) {
    return DailyChallengeData(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      progress: progress ?? this.progress,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      reward: reward ?? this.reward,
      isCompleted: isCompleted ?? this.isCompleted,
      score: score ?? this.score,
      completedAt: completedAt ?? this.completedAt,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'color': color,
      'progress': progress,
      'targetValue': targetValue,
      'currentValue': currentValue,
      'reward': reward,
      'isCompleted': isCompleted,
      'score': score,
      'completedAt': completedAt?.toIso8601String(),
    };
  }
  
  factory DailyChallengeData.fromJson(Map<String, dynamic> json) {
    return DailyChallengeData(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      color: json['color'] as String,
      progress: (json['progress'] as num).toDouble(),
      targetValue: json['targetValue'] as int,
      currentValue: json['currentValue'] as int,
      reward: json['reward'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      score: json['score'] as int?,
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt'] as String)
          : null,
    );
  }
}

/// 成就数据
class AchievementData {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String color;
  final DateTime earnedAt;
  final String category;
  final int points;
  final bool isNew;
  
  const AchievementData({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.earnedAt,
    required this.category,
    required this.points,
    this.isNew = false,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'color': color,
      'earnedAt': earnedAt.toIso8601String(),
      'category': category,
      'points': points,
      'isNew': isNew,
    };
  }
  
  factory AchievementData.fromJson(Map<String, dynamic> json) {
    return AchievementData(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      color: json['color'] as String,
      earnedAt: DateTime.parse(json['earnedAt'] as String),
      category: json['category'] as String,
      points: json['points'] as int,
      isNew: json['isNew'] as bool? ?? false,
    );
  }
}

/// 欢迎消息数据
class WelcomeMessageData {
  final String greeting;
  final String message;
  final String? motivationalQuote;
  final String timeOfDay;
  
  const WelcomeMessageData({
    required this.greeting,
    required this.message,
    this.motivationalQuote,
    required this.timeOfDay,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'greeting': greeting,
      'message': message,
      'motivationalQuote': motivationalQuote,
      'timeOfDay': timeOfDay,
    };
  }
  
  factory WelcomeMessageData.fromJson(Map<String, dynamic> json) {
    return WelcomeMessageData(
      greeting: json['greeting'] as String,
      message: json['message'] as String,
      motivationalQuote: json['motivationalQuote'] as String?,
      timeOfDay: json['timeOfDay'] as String,
    );
  }
}