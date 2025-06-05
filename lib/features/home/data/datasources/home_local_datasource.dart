import '../../domain/entities/home_data_entity.dart';
import '../../domain/entities/user_stats_entity.dart';
import '../../domain/entities/notification_entity.dart';

/// 主页本地数据源抽象类
abstract class HomeLocalDataSource {
  /// 缓存主页数据
  Future<void> cacheHomeData(String userId, HomeDataEntity data);
  
  /// 获取缓存的主页数据
  Future<HomeDataEntity?> getCachedHomeData(String userId);
  
  /// 缓存用户统计数据
  Future<void> cacheUserStats(String userId, UserStatsEntity stats);
  
  /// 获取缓存的用户统计数据
  Future<UserStatsEntity?> getCachedUserStats(String userId);
  
  /// 缓存通知列表
  Future<void> cacheNotifications(String userId, List<NotificationEntity> notifications);
  
  /// 获取缓存的通知列表
  Future<List<NotificationEntity>> getCachedNotifications(String userId);
  
  /// 标记通知为已读（本地）
  Future<void> markNotificationAsRead(String notificationId);
  
  /// 标记所有通知为已读（本地）
  Future<void> markAllNotificationsAsRead(String userId);
  
  /// 删除通知（本地）
  Future<void> deleteNotification(String notificationId);
  
  /// 更新学习进度（本地）
  Future<void> updateLearningProgress(
    String userId,
    Map<String, dynamic> progressData,
  );
  
  /// 完成每日挑战（本地）
  Future<void> completeDailyChallenge(
    String userId,
    String challengeId,
    int score,
  );
  
  /// 更新快捷操作状态（本地）
  Future<void> updateQuickActionStatus(
    String actionId,
    Map<String, dynamic> data,
  );
  
  /// 清除缓存
  Future<void> clearCache(String userId);
  
  /// 检查缓存是否过期
  Future<bool> isCacheExpired(String userId);
  
  /// 获取缓存时间戳
  Future<DateTime?> getCacheTimestamp(String userId);
  
  /// 设置缓存时间戳
  Future<void> setCacheTimestamp(String userId, DateTime timestamp);
}