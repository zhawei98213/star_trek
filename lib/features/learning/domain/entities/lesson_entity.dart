/// 课程实体
/// 
/// 定义课程的核心属性和行为
class LessonEntity {
  /// 课程ID
  final String id;
  
  /// 课程标题
  final String title;
  
  /// 课程描述
  final String description;
  
  /// 课程类型
  final LessonType type;
  
  /// 难度等级
  final DifficultyLevel difficulty;
  
  /// 适合年龄组
  final AgeGroup ageGroup;
  
  /// 课程内容
  final List<LessonContentEntity> contents;
  
  /// 预计完成时间（分钟）
  final int estimatedDuration;
  
  /// 课程封面图片URL
  final String? coverImageUrl;
  
  /// 课程图标
  final String iconPath;
  
  /// 是否已解锁
  final bool isUnlocked;
  
  /// 完成状态
  final LessonStatus status;
  
  /// 完成进度（0.0 - 1.0）
  final double progress;
  
  /// 最高得分
  final int? bestScore;
  
  /// 完成次数
  final int completionCount;
  
  /// 创建时间
  final DateTime createdAt;
  
  /// 最后更新时间
  final DateTime updatedAt;
  
  const LessonEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.difficulty,
    required this.ageGroup,
    required this.contents,
    required this.estimatedDuration,
    required this.iconPath,
    required this.isUnlocked,
    required this.status,
    required this.progress,
    required this.completionCount,
    required this.createdAt,
    required this.updatedAt,
    this.coverImageUrl,
    this.bestScore,
  });
  
  /// 是否已完成
  bool get isCompleted => status == LessonStatus.completed;
  
  /// 是否正在进行
  bool get isInProgress => status == LessonStatus.inProgress;
  
  /// 是否未开始
  bool get isNotStarted => status == LessonStatus.notStarted;
  
  /// 获取进度百分比
  int get progressPercentage => (progress * 100).round();
  
  /// 复制实体并更新指定字段
  LessonEntity copyWith({
    String? id,
    String? title,
    String? description,
    LessonType? type,
    DifficultyLevel? difficulty,
    AgeGroup? ageGroup,
    List<LessonContentEntity>? contents,
    int? estimatedDuration,
    String? coverImageUrl,
    String? iconPath,
    bool? isUnlocked,
    LessonStatus? status,
    double? progress,
    int? bestScore,
    int? completionCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LessonEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      difficulty: difficulty ?? this.difficulty,
      ageGroup: ageGroup ?? this.ageGroup,
      contents: contents ?? this.contents,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      iconPath: iconPath ?? this.iconPath,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      bestScore: bestScore ?? this.bestScore,
      completionCount: completionCount ?? this.completionCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LessonEntity && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
  
  @override
  String toString() {
    return 'LessonEntity(id: $id, title: $title, status: $status, progress: $progress)';
  }
}

/// 课程类型枚举
enum LessonType {
  /// 字母学习
  alphabet,
  /// 数字学习
  numbers,
  /// 形状学习
  shapes,
  /// 颜色学习
  colors,
  /// 动物学习
  animals,
  /// 交通工具
  vehicles,
  /// 食物学习
  food,
  /// 家庭成员
  family,
  /// 身体部位
  bodyParts,
  /// 日常用品
  dailyItems,
  /// 视频课程
  video,
  /// 交互式课程
  interactive,
  /// 测验课程
  quiz,
  /// 阅读课程
  reading,
  /// 游戏课程
  game,
}

/// 难度等级枚举
enum DifficultyLevel {
  /// 初级
  beginner,
  /// 中级
  intermediate,
  /// 高级
  advanced,
}

/// 年龄组枚举
enum AgeGroup {
  /// 3-5岁
  preschool,
  /// 6-8岁
  elementary,
  /// 9-12岁
  middle,
}

/// 课程状态枚举
enum LessonStatus {
  /// 未开始
  notStarted,
  /// 进行中
  inProgress,
  /// 已完成
  completed,
  /// 已锁定
  locked,
}

/// 课程内容实体
class LessonContentEntity {
  /// 内容ID
  final String id;
  
  /// 内容类型
  final ContentType type;
  
  /// 内容标题
  final String title;
  
  /// 内容描述
  final String? description;
  
  /// 内容数据（JSON格式）
  final Map<String, dynamic> data;
  
  /// 排序顺序
  final int order;
  
  /// 是否必须完成
  final bool isRequired;
  
  /// 完成状态
  final bool isCompleted;
  
  const LessonContentEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.data,
    required this.order,
    required this.isRequired,
    required this.isCompleted,
    this.description,
  });
  
  /// 复制实体并更新指定字段
  LessonContentEntity copyWith({
    String? id,
    ContentType? type,
    String? title,
    String? description,
    Map<String, dynamic>? data,
    int? order,
    bool? isRequired,
    bool? isCompleted,
  }) {
    return LessonContentEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      data: data ?? this.data,
      order: order ?? this.order,
      isRequired: isRequired ?? this.isRequired,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LessonContentEntity && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}

/// 内容类型枚举
enum ContentType {
  /// 文本内容
  text,
  /// 图片内容
  image,
  /// 音频内容
  audio,
  /// 视频内容
  video,
  /// 交互式练习
  interactive,
  /// 测验
  quiz,
  /// 游戏
  game,
}