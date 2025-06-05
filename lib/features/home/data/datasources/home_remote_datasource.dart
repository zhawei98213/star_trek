import '../../domain/entities/home_data_entity.dart';
import '../../domain/entities/user_stats_entity.dart';
import '../../domain/entities/notification_entity.dart';

/// 主页远程数据源抽象类
abstract class HomeRemoteDataSource {
  /// 获取主页数据
  Future<HomeDataEntity> getHomeData(String userId);
  
  /// 获取用户统计数据
  Future<UserStatsEntity> getUserStats(String userId);
  
  /// 获取通知列表
  Future<List<NotificationEntity>> getNotifications(
    String userId, {
    int limit = 20,
    int offset = 0,
    bool unreadOnly = false,
  });
  
  /// 标记通知为已读
  Future<void> markNotificationAsRead(String notificationId);
  
  /// 标记所有通知为已读
  Future<void> markAllNotificationsAsRead(String userId);
  
  /// 删除通知
  Future<void> deleteNotification(String notificationId);
  
  /// 更新学习进度
  Future<void> updateLearningProgress(
    String userId,
    Map<String, dynamic> progressData,
  );
  
  /// 完成每日挑战
  Future<void> completeDailyChallenge(
    String userId,
    String challengeId,
    int score,
  );
  
  /// 获取快捷操作
  Future<List<QuickActionData>> getQuickActions(String userId);
  
  /// 更新快捷操作状态
  Future<void> updateQuickActionStatus(
    String actionId,
    Map<String, dynamic> data,
  );
  
  /// 获取每日挑战
  Future<List<DailyChallengeData>> getDailyChallenges(String userId);
  
  /// 获取最近成就
  Future<List<AchievementData>> getRecentAchievements(
    String userId, {
    int limit = 5,
  });
  
  /// 同步数据到云端
  Future<void> syncToCloud(String userId);
  
  /// 从云端同步数据
  Future<void> syncFromCloud(String userId);
}