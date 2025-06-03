import '../../domain/entities/learning_progress_entity.dart';
import '../../domain/entities/lesson_entity.dart';

/// 学习进度数据模型
/// 用于数据层的学习进度数据传输和存储
class LearningProgressModel extends LearningProgressEntity {
  const LearningProgressModel({
    required super.userId,
    required super.totalStudyTime,
    required super.completedLessons,
    required super.totalLessons,
    required super.currentStreak,
    required super.longestStreak,
    required super.totalPoints,
    required super.currentLevel,
    required super.levelProgress,
    required super.categoryProgress,
    required super.dailyGoal,
    required super.todayStudyTime,
    required super.weeklyStats,
    required super.createdAt,
    required super.updatedAt,
    super.lastStudyTime,
  });
  
  /// 从JSON创建模型
  factory LearningProgressModel.fromJson(Map<String, dynamic> json) {
    // 解析分类进度
    final categoryProgressMap = <LessonType, CategoryProgress>{};
    final categoryProgressJson = json['categoryProgress'] as Map<String, dynamic>? ?? {};
    
    for (final entry in categoryProgressJson.entries) {
      final type = LessonType.values.firstWhere(
        (e) => e.name == entry.key,
        orElse: () => LessonType.alphabet,
      );
      categoryProgressMap[type] = CategoryProgressModel.fromJson(
        entry.value as Map<String, dynamic>,
      );
    }
    
    // 解析周统计数据
    final weeklyStats = (json['weeklyStats'] as List<dynamic>? ?? [])
        .map((e) => DailyStudyRecordModel.fromJson(e as Map<String, dynamic>))
        .toList();
    
    return LearningProgressModel(
      userId: json['userId'] as String,
      totalStudyTime: json['totalStudyTime'] as int? ?? 0,
      completedLessons: json['completedLessons'] as int? ?? 0,
      totalLessons: json['totalLessons'] as int? ?? 0,
      currentStreak: json['currentStreak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
      totalPoints: json['totalPoints'] as int? ?? 0,
      currentLevel: json['currentLevel'] as int? ?? 1,
      levelProgress: (json['levelProgress'] as num? ?? 0.0).toDouble(),
      categoryProgress: categoryProgressMap,
      dailyGoal: json['dailyGoal'] as int? ?? 30,
      todayStudyTime: json['todayStudyTime'] as int? ?? 0,
      weeklyStats: weeklyStats,
      lastStudyTime: json['lastStudyTime'] != null
          ? DateTime.parse(json['lastStudyTime'] as String)
          : null,
      createdAt: DateTime.parse(
        json['createdAt'] as String? ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] as String? ?? DateTime.now().toIso8601String(),
      ),
    );
  }
  
  /// 转换为JSON
  Map<String, dynamic> toJson() {
    // 转换分类进度
    final categoryProgressJson = <String, dynamic>{};
    for (final entry in categoryProgress.entries) {
      categoryProgressJson[entry.key.name] = 
          (entry.value as CategoryProgressModel).toJson();
    }
    
    return {
      'userId': userId,
      'totalStudyTime': totalStudyTime,
      'completedLessons': completedLessons,
      'totalLessons': totalLessons,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'totalPoints': totalPoints,
      'currentLevel': currentLevel,
      'levelProgress': levelProgress,
      'categoryProgress': categoryProgressJson,
      'dailyGoal': dailyGoal,
      'todayStudyTime': todayStudyTime,
      'weeklyStats': weeklyStats
          .map((e) => (e as DailyStudyRecordModel).toJson())
          .toList(),
      'lastStudyTime': lastStudyTime?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
  
  /// 从实体创建模型
  factory LearningProgressModel.fromEntity(LearningProgressEntity entity) {
    // 转换分类进度
    final categoryProgressMap = <LessonType, CategoryProgress>{};
    for (final entry in entity.categoryProgress.entries) {
      categoryProgressMap[entry.key] = CategoryProgressModel.fromEntity(entry.value);
    }
    
    return LearningProgressModel(
      userId: entity.userId,
      totalStudyTime: entity.totalStudyTime,
      completedLessons: entity.completedLessons,
      totalLessons: entity.totalLessons,
      currentStreak: entity.currentStreak,
      longestStreak: entity.longestStreak,
      totalPoints: entity.totalPoints,
      currentLevel: entity.currentLevel,
      levelProgress: entity.levelProgress,
      categoryProgress: categoryProgressMap,
      dailyGoal: entity.dailyGoal,
      todayStudyTime: entity.todayStudyTime,
      weeklyStats: entity.weeklyStats
          .map((e) => DailyStudyRecordModel.fromEntity(e))
          .toList(),
      lastStudyTime: entity.lastStudyTime,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
  
  /// 转换为实体
  LearningProgressEntity toEntity() {
    return LearningProgressEntity(
      userId: userId,
      totalStudyTime: totalStudyTime,
      completedLessons: completedLessons,
      totalLessons: totalLessons,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      totalPoints: totalPoints,
      currentLevel: currentLevel,
      levelProgress: levelProgress,
      categoryProgress: categoryProgress,
      dailyGoal: dailyGoal,
      todayStudyTime: todayStudyTime,
      weeklyStats: weeklyStats,
      lastStudyTime: lastStudyTime,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
  
  /// 复制并更新字段
  @override
  LearningProgressModel copyWith({
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
    return LearningProgressModel(
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
}

/// 分类进度数据模型
class CategoryProgressModel extends CategoryProgress {
  const CategoryProgressModel({
    required super.type,
    required super.completedLessons,
    required super.totalLessons,
    required super.studyTime,
    required super.averageScore,
    super.lastStudyTime,
  });
  
  /// 从JSON创建模型
  factory CategoryProgressModel.fromJson(Map<String, dynamic> json) {
    return CategoryProgressModel(
      type: LessonType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => LessonType.alphabet,
      ),
      completedLessons: json['completedLessons'] as int? ?? 0,
      totalLessons: json['totalLessons'] as int? ?? 0,
      studyTime: json['studyTime'] as int? ?? 0,
      averageScore: (json['averageScore'] as num? ?? 0.0).toDouble(),
      lastStudyTime: json['lastStudyTime'] != null
          ? DateTime.parse(json['lastStudyTime'] as String)
          : null,
    );
  }
  
  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'completedLessons': completedLessons,
      'totalLessons': totalLessons,
      'studyTime': studyTime,
      'averageScore': averageScore,
      'lastStudyTime': lastStudyTime?.toIso8601String(),
    };
  }
  
  /// 从实体创建模型
  factory CategoryProgressModel.fromEntity(CategoryProgress entity) {
    return CategoryProgressModel(
      type: entity.type,
      completedLessons: entity.completedLessons,
      totalLessons: entity.totalLessons,
      studyTime: entity.studyTime,
      averageScore: entity.averageScore,
      lastStudyTime: entity.lastStudyTime,
    );
  }
  
  /// 转换为实体
  CategoryProgress toEntity() {
    return CategoryProgress(
      type: type,
      completedLessons: completedLessons,
      totalLessons: totalLessons,
      studyTime: studyTime,
      averageScore: averageScore,
      lastStudyTime: lastStudyTime,
    );
  }
  
  /// 复制并更新字段
  @override
  CategoryProgressModel copyWith({
    LessonType? type,
    int? completedLessons,
    int? totalLessons,
    int? studyTime,
    double? averageScore,
    DateTime? lastStudyTime,
  }) {
    return CategoryProgressModel(
      type: type ?? this.type,
      completedLessons: completedLessons ?? this.completedLessons,
      totalLessons: totalLessons ?? this.totalLessons,
      studyTime: studyTime ?? this.studyTime,
      averageScore: averageScore ?? this.averageScore,
      lastStudyTime: lastStudyTime ?? this.lastStudyTime,
    );
  }
}

/// 每日学习记录数据模型
class DailyStudyRecordModel extends DailyStudyRecord {
  const DailyStudyRecordModel({
    required super.date,
    required super.studyTime,
    required super.completedLessons,
    required super.earnedPoints,
    required super.goalCompleted,
  });
  
  /// 从JSON创建模型
  factory DailyStudyRecordModel.fromJson(Map<String, dynamic> json) {
    return DailyStudyRecordModel(
      date: DateTime.parse(json['date'] as String),
      studyTime: json['studyTime'] as int? ?? 0,
      completedLessons: json['completedLessons'] as int? ?? 0,
      earnedPoints: json['earnedPoints'] as int? ?? 0,
      goalCompleted: json['goalCompleted'] as bool? ?? false,
    );
  }
  
  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'studyTime': studyTime,
      'completedLessons': completedLessons,
      'earnedPoints': earnedPoints,
      'goalCompleted': goalCompleted,
    };
  }
  
  /// 从实体创建模型
  factory DailyStudyRecordModel.fromEntity(DailyStudyRecord entity) {
    return DailyStudyRecordModel(
      date: entity.date,
      studyTime: entity.studyTime,
      completedLessons: entity.completedLessons,
      earnedPoints: entity.earnedPoints,
      goalCompleted: entity.goalCompleted,
    );
  }
  
  /// 转换为实体
  DailyStudyRecord toEntity() {
    return DailyStudyRecord(
      date: date,
      studyTime: studyTime,
      completedLessons: completedLessons,
      earnedPoints: earnedPoints,
      goalCompleted: goalCompleted,
    );
  }
  
  /// 复制并更新字段
  @override
  DailyStudyRecordModel copyWith({
    DateTime? date,
    int? studyTime,
    int? completedLessons,
    int? earnedPoints,
    bool? goalCompleted,
  }) {
    return DailyStudyRecordModel(
      date: date ?? this.date,
      studyTime: studyTime ?? this.studyTime,
      completedLessons: completedLessons ?? this.completedLessons,
      earnedPoints: earnedPoints ?? this.earnedPoints,
      goalCompleted: goalCompleted ?? this.goalCompleted,
    );
  }
}