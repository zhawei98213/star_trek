/// 通知实体
/// 表示应用内的通知消息
class NotificationEntity {
  final String id;
  final String userId;
  final String title;
  final String message;
  final NotificationType type;
  final NotificationPriority priority;
  final bool isRead;
  final DateTime createdAt;
  final DateTime? readAt;
  final Map<String, dynamic>? data;
  final String? actionUrl;
  final String? imageUrl;
  final String? iconName;
  
  const NotificationEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.type,
    required this.priority,
    required this.isRead,
    required this.createdAt,
    this.readAt,
    this.data,
    this.actionUrl,
    this.imageUrl,
    this.iconName,
  });
  
  NotificationEntity copyWith({
    String? id,
    String? userId,
    String? title,
    String? message,
    NotificationType? type,
    NotificationPriority? priority,
    bool? isRead,
    DateTime? createdAt,
    DateTime? readAt,
    Map<String, dynamic>? data,
    String? actionUrl,
    String? imageUrl,
    String? iconName,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
      data: data ?? this.data,
      actionUrl: actionUrl ?? this.actionUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      iconName: iconName ?? this.iconName,
    );
  }
  
  /// 获取通知的相对时间描述
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }
  
  /// 检查通知是否为新通知（24小时内）
  bool get isNew {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    return difference.inHours < 24;
  }
  
  /// 检查通知是否过期（7天前）
  bool get isExpired {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    return difference.inDays > 7;
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'message': message,
      'type': type.name,
      'priority': priority.name,
      'isRead': isRead,
      'createdAt': createdAt.toIso8601String(),
      'readAt': readAt?.toIso8601String(),
      'data': data,
      'actionUrl': actionUrl,
      'imageUrl': imageUrl,
      'iconName': iconName,
    };
  }
  
  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      type: NotificationType.values.firstWhere(
        (e) => e.name == json['type'],
      ),
      priority: NotificationPriority.values.firstWhere(
        (e) => e.name == json['priority'],
      ),
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      readAt: json['readAt'] != null 
          ? DateTime.parse(json['readAt'] as String)
          : null,
      data: json['data'] as Map<String, dynamic>?,
      actionUrl: json['actionUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      iconName: json['iconName'] as String?,
    );
  }
}

/// 通知类型枚举
enum NotificationType {
  /// 学习提醒
  studyReminder,
  
  /// 成就解锁
  achievement,
  
  /// 挑战完成
  challengeComplete,
  
  /// 等级提升
  levelUp,
  
  /// 连续学习
  streak,
  
  /// 系统消息
  system,
  
  /// 社交互动
  social,
  
  /// 课程更新
  courseUpdate,
  
  /// 活动通知
  event,
  
  /// 其他
  other,
}

/// 通知优先级枚举
enum NotificationPriority {
  /// 低优先级
  low,
  
  /// 普通优先级
  normal,
  
  /// 高优先级
  high,
  
  /// 紧急
  urgent,
}

/// 通知类型扩展
extension NotificationTypeExtension on NotificationType {
  /// 获取通知类型的显示名称
  String get displayName {
    switch (this) {
      case NotificationType.studyReminder:
        return '学习提醒';
      case NotificationType.achievement:
        return '成就解锁';
      case NotificationType.challengeComplete:
        return '挑战完成';
      case NotificationType.levelUp:
        return '等级提升';
      case NotificationType.streak:
        return '连续学习';
      case NotificationType.system:
        return '系统消息';
      case NotificationType.social:
        return '社交互动';
      case NotificationType.courseUpdate:
        return '课程更新';
      case NotificationType.event:
        return '活动通知';
      case NotificationType.other:
        return '其他';
    }
  }
  
  /// 获取通知类型的图标名称
  String get iconName {
    switch (this) {
      case NotificationType.studyReminder:
        return 'schedule';
      case NotificationType.achievement:
        return 'emoji_events';
      case NotificationType.challengeComplete:
        return 'check_circle';
      case NotificationType.levelUp:
        return 'trending_up';
      case NotificationType.streak:
        return 'local_fire_department';
      case NotificationType.system:
        return 'info';
      case NotificationType.social:
        return 'people';
      case NotificationType.courseUpdate:
        return 'school';
      case NotificationType.event:
        return 'event';
      case NotificationType.other:
        return 'notifications';
    }
  }
  
  /// 获取通知类型的颜色
  String get colorHex {
    switch (this) {
      case NotificationType.studyReminder:
        return '#2196F3'; // 蓝色
      case NotificationType.achievement:
        return '#FFD700'; // 金色
      case NotificationType.challengeComplete:
        return '#4CAF50'; // 绿色
      case NotificationType.levelUp:
        return '#FF9800'; // 橙色
      case NotificationType.streak:
        return '#F44336'; // 红色
      case NotificationType.system:
        return '#9E9E9E'; // 灰色
      case NotificationType.social:
        return '#E91E63'; // 粉色
      case NotificationType.courseUpdate:
        return '#3F51B5'; // 靛蓝
      case NotificationType.event:
        return '#9C27B0'; // 紫色
      case NotificationType.other:
        return '#607D8B'; // 蓝灰色
    }
  }
}

/// 通知优先级扩展
extension NotificationPriorityExtension on NotificationPriority {
  /// 获取优先级的显示名称
  String get displayName {
    switch (this) {
      case NotificationPriority.low:
        return '低';
      case NotificationPriority.normal:
        return '普通';
      case NotificationPriority.high:
        return '高';
      case NotificationPriority.urgent:
        return '紧急';
    }
  }
  
  /// 获取优先级的数值（用于排序）
  int get value {
    switch (this) {
      case NotificationPriority.low:
        return 1;
      case NotificationPriority.normal:
        return 2;
      case NotificationPriority.high:
        return 3;
      case NotificationPriority.urgent:
        return 4;
    }
  }
}