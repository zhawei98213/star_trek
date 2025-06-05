import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/home_data_entity.dart';
import '../../domain/entities/user_stats_entity.dart';
import '../../domain/entities/notification_entity.dart';
import 'home_local_datasource.dart';

/// 主页本地数据源实现类
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  static const String _homeDataPrefix = 'home_data_';
  static const String _userStatsPrefix = 'user_stats_';
  static const String _notificationsPrefix = 'notifications_';
  static const String _timestampPrefix = 'timestamp_';
  static const Duration _cacheExpiration = Duration(hours: 1);
  
  @override
  Future<void> cacheHomeData(String userId, HomeDataEntity data) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_homeDataPrefix$userId';
    final timestampKey = '$_timestampPrefix$key';
    
    // 将数据转换为JSON并存储
    final jsonData = jsonEncode(data.toJson());
    await prefs.setString(key, jsonData);
    await prefs.setInt(timestampKey, DateTime.now().millisecondsSinceEpoch);
  }
  
  @override
  Future<HomeDataEntity?> getCachedHomeData(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_homeDataPrefix$userId';
    
    // 检查缓存是否过期
    if (await isCacheExpired(userId)) {
      return null;
    }
    
    final jsonData = prefs.getString(key);
    if (jsonData == null) {
      return null;
    }
    
    try {
      final data = jsonDecode(jsonData) as Map<String, dynamic>;
      return HomeDataEntity.fromJson(data);
    } catch (e) {
      // 如果解析失败，删除损坏的缓存
      await prefs.remove(key);
      return null;
    }
  }
  
  @override
  Future<void> cacheUserStats(String userId, UserStatsEntity stats) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_userStatsPrefix$userId';
    final timestampKey = '$_timestampPrefix$key';
    
    final jsonData = jsonEncode(stats.toJson());
    await prefs.setString(key, jsonData);
    await prefs.setInt(timestampKey, DateTime.now().millisecondsSinceEpoch);
  }
  
  @override
  Future<UserStatsEntity?> getCachedUserStats(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_userStatsPrefix$userId';
    
    if (await isCacheExpired(userId)) {
      return null;
    }
    
    final jsonData = prefs.getString(key);
    if (jsonData == null) {
      return null;
    }
    
    try {
      final data = jsonDecode(jsonData) as Map<String, dynamic>;
      return UserStatsEntity.fromJson(data);
    } catch (e) {
      await prefs.remove(key);
      return null;
    }
  }
  
  @override
  Future<void> cacheNotifications(
    String userId,
    List<NotificationEntity> notifications,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_notificationsPrefix$userId';
    final timestampKey = '$_timestampPrefix$key';
    
    final jsonData = jsonEncode(
      notifications.map((n) => n.toJson()).toList(),
    );
    await prefs.setString(key, jsonData);
    await prefs.setInt(timestampKey, DateTime.now().millisecondsSinceEpoch);
  }
  
  @override
  Future<List<NotificationEntity>> getCachedNotifications(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_notificationsPrefix$userId';
    
    final jsonData = prefs.getString(key);
    if (jsonData == null) {
      return [];
    }
    
    try {
      final data = jsonDecode(jsonData) as List<dynamic>;
      return data
          .map((item) => NotificationEntity.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      await prefs.remove(key);
      return [];
    }
  }
  
  @override
  Future<void> markNotificationAsRead(String notificationId) async {
    final prefs = await SharedPreferences.getInstance();
    
    // 遍历所有用户的通知缓存
    final keys = prefs.getKeys()
        .where((key) => key.startsWith(_notificationsPrefix))
        .toList();
    
    for (final key in keys) {
      final jsonData = prefs.getString(key);
      if (jsonData == null) continue;
      
      try {
        final data = jsonDecode(jsonData) as List<dynamic>;
        final notifications = data
            .map((item) => NotificationEntity.fromJson(item as Map<String, dynamic>))
            .toList();
        
        bool updated = false;
        for (int i = 0; i < notifications.length; i++) {
          if (notifications[i].id == notificationId) {
            notifications[i] = notifications[i].copyWith(
              isRead: true,
              readAt: DateTime.now(),
            );
            updated = true;
            break;
          }
        }
        
        if (updated) {
          final updatedJsonData = jsonEncode(
            notifications.map((n) => n.toJson()).toList(),
          );
          await prefs.setString(key, updatedJsonData);
          break;
        }
      } catch (e) {
        // 忽略解析错误
        continue;
      }
    }
  }
  
  @override
  Future<void> markAllNotificationsAsRead(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_notificationsPrefix$userId';
    
    final jsonData = prefs.getString(key);
    if (jsonData == null) return;
    
    try {
      final data = jsonDecode(jsonData) as List<dynamic>;
      final notifications = data
          .map((item) => NotificationEntity.fromJson(item as Map<String, dynamic>))
          .toList();
      
      final updatedNotifications = notifications.map((notification) {
        if (!notification.isRead) {
          return notification.copyWith(
            isRead: true,
            readAt: DateTime.now(),
          );
        }
        return notification;
      }).toList();
      
      final updatedJsonData = jsonEncode(
        updatedNotifications.map((n) => n.toJson()).toList(),
      );
      await prefs.setString(key, updatedJsonData);
    } catch (e) {
      // 如果解析失败，删除缓存
      await prefs.remove(key);
    }
  }
  
  @override
  Future<void> deleteNotification(String notificationId) async {
    final prefs = await SharedPreferences.getInstance();
    
    // 遍历所有用户的通知缓存
    final keys = prefs.getKeys()
        .where((key) => key.startsWith(_notificationsPrefix))
        .toList();
    
    for (final key in keys) {
      final jsonData = prefs.getString(key);
      if (jsonData == null) continue;
      
      try {
        final data = jsonDecode(jsonData) as List<dynamic>;
        final notifications = data
            .map((item) => NotificationEntity.fromJson(item as Map<String, dynamic>))
            .toList();
        
        final originalLength = notifications.length;
        notifications.removeWhere((notification) => notification.id == notificationId);
        
        if (notifications.length != originalLength) {
          final updatedJsonData = jsonEncode(
            notifications.map((n) => n.toJson()).toList(),
          );
          await prefs.setString(key, updatedJsonData);
          break;
        }
      } catch (e) {
        continue;
      }
    }
  }
  
  @override
  Future<void> updateLearningProgress(
    String userId,
    Map<String, dynamic> progressData,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_homeDataPrefix$userId';
    
    final jsonData = prefs.getString(key);
    if (jsonData == null) return;
    
    try {
      final data = jsonDecode(jsonData) as Map<String, dynamic>;
      final homeData = HomeDataEntity.fromJson(data);
      
      // 更新学习进度数据
      final updatedLearningProgress = homeData.learningProgress.copyWith(
        overallProgress: progressData['overallProgress'] as double? ?? 
            homeData.learningProgress.overallProgress,
        todayStudyTime: progressData['todayStudyTime'] as int? ?? 
            homeData.learningProgress.todayStudyTime,
        totalStudyTime: progressData['totalStudyTime'] as int? ?? 
            homeData.learningProgress.totalStudyTime,
        streak: progressData['streak'] as int? ?? 
            homeData.learningProgress.streak,
      );
      
      final updatedHomeData = homeData.copyWith(
        learningProgress: updatedLearningProgress,
        lastUpdated: DateTime.now(),
      );
      
      final updatedJsonData = jsonEncode(updatedHomeData.toJson());
      await prefs.setString(key, updatedJsonData);
    } catch (e) {
      // 如果更新失败，删除缓存
      await prefs.remove(key);
    }
  }
  
  @override
  Future<void> completeDailyChallenge(
    String userId,
    String challengeId,
    int score,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_homeDataPrefix$userId';
    
    final jsonData = prefs.getString(key);
    if (jsonData == null) return;
    
    try {
      final data = jsonDecode(jsonData) as Map<String, dynamic>;
      final homeData = HomeDataEntity.fromJson(data);
      
      // 更新挑战进度
      final updatedChallenges = homeData.dailyChallenges.map((challenge) {
        if (challenge.id == challengeId) {
          return challenge.copyWith(
            progress: 1.0,
            currentValue: challenge.targetValue,
          );
        }
        return challenge;
      }).toList();
      
      final updatedHomeData = homeData.copyWith(
        dailyChallenges: updatedChallenges,
        lastUpdated: DateTime.now(),
      );
      
      final updatedJsonData = jsonEncode(updatedHomeData.toJson());
      await prefs.setString(key, updatedJsonData);
    } catch (e) {
      await prefs.remove(key);
    }
  }
  
  @override
  Future<void> updateQuickActionStatus(
    String actionId,
    Map<String, dynamic> data,
  ) async {
    // 快捷操作状态更新的本地实现
    // 这里可以根据需要实现具体的本地状态更新逻辑
    // 本地更新快捷操作状态
  }
  
  @override
  Future<void> clearCache(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    
    final keysToRemove = [
      '$_homeDataPrefix$userId',
      '$_userStatsPrefix$userId',
      '$_notificationsPrefix$userId',
      '$_timestampPrefix$_homeDataPrefix$userId',
      '$_timestampPrefix$_userStatsPrefix$userId',
      '$_timestampPrefix$_notificationsPrefix$userId',
    ];
    
    for (final key in keysToRemove) {
      await prefs.remove(key);
    }
  }
  
  @override
  Future<bool> isCacheExpired(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final timestampKey = '$_timestampPrefix$_homeDataPrefix$userId';
    
    final timestamp = prefs.getInt(timestampKey);
    if (timestamp == null) {
      return true;
    }
    
    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    
    return now.difference(cacheTime) > _cacheExpiration;
  }
  
  @override
  Future<DateTime?> getCacheTimestamp(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final timestampKey = '$_timestampPrefix$_homeDataPrefix$userId';
    
    final timestamp = prefs.getInt(timestampKey);
    if (timestamp == null) {
      return null;
    }
    
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
  
  @override
  Future<void> setCacheTimestamp(String userId, DateTime timestamp) async {
    final prefs = await SharedPreferences.getInstance();
    final timestampKey = '$_timestampPrefix$_homeDataPrefix$userId';
    
    await prefs.setInt(timestampKey, timestamp.millisecondsSinceEpoch);
  }
}