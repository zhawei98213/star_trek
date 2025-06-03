import '../../domain/entities/lesson_entity.dart';

/// 课程数据模型
/// 
/// 用于数据层的课程数据传输和存储
class LessonModel extends LessonEntity {
  const LessonModel({
    required super.id,
    required super.title,
    required super.description,
    required super.type,
    required super.difficulty,
    required super.ageGroup,
    required super.contents,
    required super.estimatedDuration,
    required super.iconPath,
    required super.isUnlocked,
    required super.status,
    required super.progress,
    required super.completionCount,
    required super.createdAt,
    required super.updatedAt,
    super.coverImageUrl,
    super.bestScore,
  });
  
  /// 从JSON创建模型
  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: LessonType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => LessonType.alphabet,
      ),
      difficulty: DifficultyLevel.values.firstWhere(
        (e) => e.name == json['difficulty'],
        orElse: () => DifficultyLevel.beginner,
      ),
      ageGroup: AgeGroup.values.firstWhere(
        (e) => e.name == json['ageGroup'],
        orElse: () => AgeGroup.preschool,
      ),
      contents: (json['contents'] as List<dynamic>? ?? [])
          .map((e) => LessonContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      estimatedDuration: json['estimatedDuration'] as int? ?? 0,
      coverImageUrl: json['coverImageUrl'] as String?,
      iconPath: json['iconPath'] as String? ?? '',
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      status: LessonStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => LessonStatus.notStarted,
      ),
      progress: (json['progress'] as num? ?? 0.0).toDouble(),
      bestScore: json['bestScore'] as int?,
      completionCount: json['completionCount'] as int? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String? ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] as String? ?? DateTime.now().toIso8601String()),
    );
  }
  
  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.name,
      'difficulty': difficulty.name,
      'ageGroup': ageGroup.name,
      'contents': contents.map((e) => (e as LessonContentModel).toJson()).toList(),
      'estimatedDuration': estimatedDuration,
      'coverImageUrl': coverImageUrl,
      'iconPath': iconPath,
      'isUnlocked': isUnlocked,
      'status': status.name,
      'progress': progress,
      'bestScore': bestScore,
      'completionCount': completionCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
  
  /// 从实体创建模型
  factory LessonModel.fromEntity(LessonEntity entity) {
    return LessonModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      type: entity.type,
      difficulty: entity.difficulty,
      ageGroup: entity.ageGroup,
      contents: entity.contents.map((e) => LessonContentModel.fromEntity(e)).toList(),
      estimatedDuration: entity.estimatedDuration,
      coverImageUrl: entity.coverImageUrl,
      iconPath: entity.iconPath,
      isUnlocked: entity.isUnlocked,
      status: entity.status,
      progress: entity.progress,
      bestScore: entity.bestScore,
      completionCount: entity.completionCount,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
  
  /// 转换为实体
  LessonEntity toEntity() {
    return LessonEntity(
      id: id,
      title: title,
      description: description,
      type: type,
      difficulty: difficulty,
      ageGroup: ageGroup,
      contents: contents,
      estimatedDuration: estimatedDuration,
      coverImageUrl: coverImageUrl,
      iconPath: iconPath,
      isUnlocked: isUnlocked,
      status: status,
      progress: progress,
      bestScore: bestScore,
      completionCount: completionCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
  
  /// 复制并更新字段
  @override
  LessonModel copyWith({
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
    return LessonModel(
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
}

/// 课程内容数据模型
class LessonContentModel extends LessonContentEntity {
  const LessonContentModel({
    required super.id,
    required super.type,
    required super.title,
    required super.data,
    required super.order,
    required super.isRequired,
    required super.isCompleted,
    super.description,
  });
  
  /// 从JSON创建模型
  factory LessonContentModel.fromJson(Map<String, dynamic> json) {
    return LessonContentModel(
      id: json['id'] as String,
      type: ContentType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ContentType.text,
      ),
      title: json['title'] as String,
      description: json['description'] as String?,
      data: json['data'] as Map<String, dynamic>? ?? {},
      order: json['order'] as int? ?? 0,
      isRequired: json['isRequired'] as bool? ?? true,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
  
  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'description': description,
      'data': data,
      'order': order,
      'isRequired': isRequired,
      'isCompleted': isCompleted,
    };
  }
  
  /// 从实体创建模型
  factory LessonContentModel.fromEntity(LessonContentEntity entity) {
    return LessonContentModel(
      id: entity.id,
      type: entity.type,
      title: entity.title,
      description: entity.description,
      data: entity.data,
      order: entity.order,
      isRequired: entity.isRequired,
      isCompleted: entity.isCompleted,
    );
  }
  
  /// 转换为实体
  LessonContentEntity toEntity() {
    return LessonContentEntity(
      id: id,
      type: type,
      title: title,
      description: description,
      data: data,
      order: order,
      isRequired: isRequired,
      isCompleted: isCompleted,
    );
  }
  
  /// 复制并更新字段
  @override
  LessonContentModel copyWith({
    String? id,
    ContentType? type,
    String? title,
    String? description,
    Map<String, dynamic>? data,
    int? order,
    bool? isRequired,
    bool? isCompleted,
  }) {
    return LessonContentModel(
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
}