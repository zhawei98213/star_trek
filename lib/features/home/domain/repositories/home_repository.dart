import '../entities/home_data_entity.dart';
import '../entities/user_stats_entity.dart';
import '../entities/notification_entity.dart';
import '../usecases/refresh_home_data_usecase.dart';

/// 主页数据仓库接口
abstract class HomeRepository {
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
  
  /// 刷新主页数据
  Future<RefreshHomeDataResult> refreshHomeData(String userId);
  
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
  
  /// 获取快速操作配置
  Future<List<QuickActionData>> getQuickActions(String userId);
  
  /// 更新快速操作状态
  Future<void> updateQuickActionStatus(
    String actionId,
    Map<String, dynamic> data,
  );
  
  /// 获取每日挑战列表
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
  
  /// 获取缓存的主页数据
  Future<HomeDataEntity?> getCachedHomeData(String userId);
  
  /// 缓存主页数据
  Future<void> cacheHomeData(String userId, HomeDataEntity data);
  
  /// 清除缓存
  Future<void> clearCache(String userId);
}