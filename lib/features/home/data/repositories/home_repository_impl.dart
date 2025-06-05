import '../../domain/entities/home_data_entity.dart';
import '../../domain/entities/user_stats_entity.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/refresh_home_data_usecase.dart';
import '../datasources/home_local_datasource.dart';
import '../datasources/home_remote_datasource.dart';

/// 主页数据仓库实现
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;
  final HomeLocalDataSource _localDataSource;
  
  HomeRepositoryImpl({
    required HomeRemoteDataSource remoteDataSource,
    required HomeLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;
  
  @override
  Future<HomeDataEntity> getHomeData(String userId) async {
    try {
      // 首先尝试从远程获取数据
      final homeData = await _remoteDataSource.getHomeData(userId);
      
      // 缓存到本地
      await _localDataSource.cacheHomeData(userId, homeData);
      
      return homeData;
    } catch (e) {
      // 如果远程获取失败，尝试从本地缓存获取
      final cachedData = await _localDataSource.getCachedHomeData(userId);
      if (cachedData != null) {
        return cachedData;
      }
      
      // 如果本地也没有，返回默认数据
      return _getDefaultHomeData(userId);
    }
  }
  
  @override
  Future<UserStatsEntity> getUserStats(String userId) async {
    try {
      final userStats = await _remoteDataSource.getUserStats(userId);
      await _localDataSource.cacheUserStats(userId, userStats);
      return userStats;
    } catch (e) {
      final cachedStats = await _localDataSource.getCachedUserStats(userId);
      if (cachedStats != null) {
        return cachedStats;
      }
      return _getDefaultUserStats(userId);
    }
  }
  
  @override
  Future<List<NotificationEntity>> getNotifications(
    String userId, {
    int limit = 20,
    int offset = 0,
    bool unreadOnly = false,
  }) async {
    try {
      final notifications = await _remoteDataSource.getNotifications(
        userId,
        limit: limit,
        offset: offset,
        unreadOnly: unreadOnly,
      );
      
      await _localDataSource.cacheNotifications(userId, notifications);
      return notifications;
    } catch (e) {
      final cachedNotifications = await _localDataSource.getCachedNotifications(userId);
      if (cachedNotifications.isNotEmpty) {
        return cachedNotifications;
      }
      return _getDefaultNotifications(userId);
    }
  }
  
  @override
  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await _remoteDataSource.markNotificationAsRead(notificationId);
      await _localDataSource.markNotificationAsRead(notificationId);
    } catch (e) {
      // 如果远程操作失败，至少更新本地状态
      await _localDataSource.markNotificationAsRead(notificationId);
      rethrow;
    }
  }
  
  @override
  Future<void> markAllNotificationsAsRead(String userId) async {
    try {
      await _remoteDataSource.markAllNotificationsAsRead(userId);
      await _localDataSource.markAllNotificationsAsRead(userId);
    } catch (e) {
      await _localDataSource.markAllNotificationsAsRead(userId);
      rethrow;
    }
  }
  
  @override
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _remoteDataSource.deleteNotification(notificationId);
      await _localDataSource.deleteNotification(notificationId);
    } catch (e) {
      await _localDataSource.deleteNotification(notificationId);
      rethrow;
    }
  }
  
  @override
  Future<RefreshHomeDataResult> refreshHomeData(String userId) async {
    try {
      // 强制从远程获取最新数据
      final homeData = await _remoteDataSource.getHomeData(userId);
      final userStats = await _remoteDataSource.getUserStats(userId);
      final notifications = await _remoteDataSource.getNotifications(userId);
      
      // 更新本地缓存
      await _localDataSource.cacheHomeData(userId, homeData);
      await _localDataSource.cacheUserStats(userId, userStats);
      await _localDataSource.cacheNotifications(userId, notifications);
      
      return RefreshHomeDataResult(
        homeData: homeData,
        userStats: userStats,
        notifications: notifications,
      );
    } catch (e) {
      // 如果刷新失败，返回缓存数据
      final cachedHomeData = await _localDataSource.getCachedHomeData(userId);
      final cachedUserStats = await _localDataSource.getCachedUserStats(userId);
      final cachedNotifications = await _localDataSource.getCachedNotifications(userId);
      
      if (cachedHomeData != null && cachedUserStats != null) {
        return RefreshHomeDataResult(
          homeData: cachedHomeData,
          userStats: cachedUserStats,
          notifications: cachedNotifications,
        );
      }
      
      rethrow;
    }
  }
  
  @override
  Future<void> updateLearningProgress(
    String userId,
    Map<String, dynamic> progressData,
  ) async {
    try {
      await _remoteDataSource.updateLearningProgress(userId, progressData);
      await _localDataSource.updateLearningProgress(userId, progressData);
    } catch (e) {
      await _localDataSource.updateLearningProgress(userId, progressData);
      rethrow;
    }
  }
  
  @override
  Future<void> completeDailyChallenge(
    String userId,
    String challengeId,
    int score,
  ) async {
    try {
      await _remoteDataSource.completeDailyChallenge(userId, challengeId, score);
      await _localDataSource.completeDailyChallenge(userId, challengeId, score);
    } catch (e) {
      await _localDataSource.completeDailyChallenge(userId, challengeId, score);
      rethrow;
    }
  }
  
  @override
  Future<List<QuickActionData>> getQuickActions(String userId) async {
    try {
      return await _remoteDataSource.getQuickActions(userId);
    } catch (e) {
      return _getDefaultQuickActions();
    }
  }
  
  @override
  Future<void> updateQuickActionStatus(
    String actionId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _remoteDataSource.updateQuickActionStatus(actionId, data);
      await _localDataSource.updateQuickActionStatus(actionId, data);
    } catch (e) {
      await _localDataSource.updateQuickActionStatus(actionId, data);
      rethrow;
    }
  }
  
  @override
  Future<List<DailyChallengeData>> getDailyChallenges(String userId) async {
    try {
      return await _remoteDataSource.getDailyChallenges(userId);
    } catch (e) {
      return _getDefaultDailyChallenges();
    }
  }
  
  @override
  Future<List<AchievementData>> getRecentAchievements(
    String userId, {
    int limit = 5,
  }) async {
    try {
      return await _remoteDataSource.getRecentAchievements(userId, limit: limit);
    } catch (e) {
      return _getDefaultAchievements();
    }
  }
  
  @override
  Future<void> syncToCloud(String userId) async {
    await _remoteDataSource.syncToCloud(userId);
  }
  
  @override
  Future<void> syncFromCloud(String userId) async {
    await _remoteDataSource.syncFromCloud(userId);
  }
  
  @override
  Future<HomeDataEntity?> getCachedHomeData(String userId) async {
    return await _localDataSource.getCachedHomeData(userId);
  }
  
  @override
  Future<void> cacheHomeData(String userId, HomeDataEntity data) async {
    await _localDataSource.cacheHomeData(userId, data);
  }
  
  @override
  Future<void> clearCache(String userId) async {
    await _localDataSource.clearCache(userId);
  }
  
  // 默认数据生成方法
  
  HomeDataEntity _getDefaultHomeData(String userId) {
    return HomeDataEntity(
      userId: userId,
      learningProgress: _getDefaultLearningProgress(),
      quickActions: _getDefaultQuickActions(),
      dailyChallenges: _getDefaultDailyChallenges(),
      recentAchievements: _getDefaultAchievements(),
      welcomeMessage: _getDefaultWelcomeMessage(),
      lastUpdated: DateTime.now(),
    );
  }
  
  LearningProgressData _getDefaultLearningProgress() {
    return LearningProgressData(
      overallProgress: 0.65,
      totalStudyTime: 1250,
      todayStudyTime: 25,
      dailyGoal: 30,
      skillProgress: [
        const SkillProgressData(
          skillName: '词汇',
          skillIcon: 'book',
          progress: 0.8,
          level: 5,
          color: '#4CAF50',
        ),
        const SkillProgressData(
          skillName: '语法',
          skillIcon: 'edit',
          progress: 0.6,
          level: 3,
          color: '#2196F3',
        ),
        const SkillProgressData(
          skillName: '听力',
          skillIcon: 'headphones',
          progress: 0.4,
          level: 2,
          color: '#FF9800',
        ),
        const SkillProgressData(
          skillName: '口语',
          skillIcon: 'mic',
          progress: 0.3,
          level: 1,
          color: '#E91E63',
        ),
      ],
      streak: 7,
    );
  }
  
  List<QuickActionData> _getDefaultQuickActions() {
    return [
      const QuickActionData(
        id: 'start_learning',
        title: '开始学习',
        subtitle: '继续你的学习之旅',
        icon: 'play_circle_filled',
        color: '#4CAF50',
        route: '/learning',
      ),
      const QuickActionData(
        id: 'daily_challenge',
        title: '每日挑战',
        subtitle: '完成今日挑战',
        icon: 'emoji_events',
        color: '#FF9800',
        route: '/challenge',
      ),
      const QuickActionData(
        id: 'review_mode',
        title: '复习模式',
        subtitle: '巩固已学知识',
        icon: 'refresh',
        color: '#2196F3',
        route: '/review',
      ),
      const QuickActionData(
        id: 'virtual_shop',
        title: '虚拟商店',
        subtitle: '兑换学习奖励',
        icon: 'store',
        color: '#9C27B0',
        route: '/shop',
      ),
    ];
  }
  
  List<DailyChallengeData> _getDefaultDailyChallenges() {
    return [
      const DailyChallengeData(
        id: 'word_master',
        title: '单词大师',
        description: '学习20个新单词',
        icon: 'book',
        color: '#4CAF50',
        progress: 0.6,
        targetValue: 20,
        currentValue: 12,
        reward: '50金币',
      ),
      const DailyChallengeData(
        id: 'reading_expert',
        title: '阅读达人',
        description: '完成3篇阅读理解',
        icon: 'article',
        color: '#2196F3',
        progress: 0.33,
        targetValue: 3,
        currentValue: 1,
        reward: '30金币',
      ),
      const DailyChallengeData(
        id: 'listening_training',
        title: '听力训练',
        description: '完成15分钟听力练习',
        icon: 'headphones',
        color: '#FF9800',
        progress: 0.8,
        targetValue: 15,
        currentValue: 12,
        reward: '40金币',
      ),
    ];
  }
  
  List<AchievementData> _getDefaultAchievements() {
    return [
      AchievementData(
        id: 'streak_7',
        title: '连续学习7天',
        description: '坚持连续学习7天',
        icon: 'local_fire_department',
        color: '#F44336',
        earnedAt: DateTime.now().subtract(const Duration(hours: 2)),
        category: '坚持',
        points: 100,
        isNew: true,
      ),
      AchievementData(
        id: 'word_100',
        title: '词汇达人',
        description: '学会100个单词',
        icon: 'book',
        color: '#4CAF50',
        earnedAt: DateTime.now().subtract(const Duration(days: 1)),
        category: '学习',
        points: 50,
      ),
      AchievementData(
        id: 'perfect_score',
        title: '完美分数',
        description: '获得满分成绩',
        icon: 'star',
        color: '#FFD700',
        earnedAt: DateTime.now().subtract(const Duration(days: 3)),
        category: '成绩',
        points: 75,
      ),
    ];
  }
  
  WelcomeMessageData _getDefaultWelcomeMessage() {
    final hour = DateTime.now().hour;
    String greeting;
    String timeOfDay;
    
    if (hour < 12) {
      greeting = '早上好';
      timeOfDay = 'morning';
    } else if (hour < 18) {
      greeting = '下午好';
      timeOfDay = 'afternoon';
    } else {
      greeting = '晚上好';
      timeOfDay = 'evening';
    }
    
    return WelcomeMessageData(
      greeting: greeting,
      message: '继续你的学习之旅',
      motivationalQuote: '每一次学习都是向目标迈进的一步',
      timeOfDay: timeOfDay,
    );
  }
  
  UserStatsEntity _getDefaultUserStats(String userId) {
    return UserStatsEntity(
      userId: userId,
      username: '学习者',
      avatarUrl: '',
      level: 5,
      totalPoints: 1250,
      currentLevelPoints: 250,
      nextLevelPoints: 500,
      learningStats: LearningStatsData(
        totalStudyTime: 1250,
        todayStudyTime: 25,
        weekStudyTime: 180,
        monthStudyTime: 720,
        completedLessons: 12,
        totalLessons: 20,
        completedChallenges: 8,
        averageScore: 85.5,
        weeklyStudyData: _getDefaultWeeklyStudyData(),
        subjectProgress: {
          '词汇': 80,
          '语法': 60,
          '听力': 40,
          '口语': 30,
        },
      ),
      achievementStats: const AchievementStatsData(
        totalAchievements: 20,
        unlockedAchievements: 8,
        recentAchievements: 3,
        featuredAchievements: ['streak_7', 'word_100', 'perfect_score'],
        categoryProgress: {
          '坚持': 3,
          '学习': 3,
          '成绩': 2,
        },
      ),
      streakData: StreakData(
        currentStreak: 7,
        longestStreak: 15,
        lastStudyDate: DateTime.now(),
        isTodayCompleted: true,
        streakGoal: 30,
      ),
      rankingData: RankingData(
        globalRank: 1250,
        localRank: 45,
        friendsRank: 3,
        totalUsers: 10000,
        topUsers: _getDefaultTopUsers(),
        trend: RankingTrendData(
          previousRank: 1280,
          rankChange: 30,
          direction: TrendDirection.up,
          lastUpdated: DateTime.now(),
        ),
      ),
      lastUpdated: DateTime.now(),
    );
  }
  
  List<DailyStudyData> _getDefaultWeeklyStudyData() {
    final now = DateTime.now();
    return List.generate(7, (index) {
      final date = now.subtract(Duration(days: 6 - index));
      return DailyStudyData(
        date: date,
        studyTime: 20 + (index * 5),
        completedLessons: index + 1,
        averageScore: 80.0 + (index * 2),
      );
    });
  }
  
  List<RankingUserData> _getDefaultTopUsers() {
    return [
      const RankingUserData(
        userId: 'user1',
        username: '学霸小明',
        avatarUrl: '',
        rank: 1,
        points: 5000,
        level: 15,
      ),
      const RankingUserData(
        userId: 'user2',
        username: '努力小红',
        avatarUrl: '',
        rank: 2,
        points: 4500,
        level: 14,
      ),
      const RankingUserData(
        userId: 'user3',
        username: '坚持小刚',
        avatarUrl: '',
        rank: 3,
        points: 4000,
        level: 13,
      ),
    ];
  }
  
  List<NotificationEntity> _getDefaultNotifications(String userId) {
    return [
      NotificationEntity(
        id: 'notif1',
        userId: userId,
        title: '学习提醒',
        message: '该开始今天的学习了！',
        type: NotificationType.studyReminder,
        priority: NotificationPriority.normal,
        isRead: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        iconName: 'schedule',
      ),
      NotificationEntity(
        id: 'notif2',
        userId: userId,
        title: '新成就解锁',
        message: '恭喜获得"连续学习7天"成就！',
        type: NotificationType.achievement,
        priority: NotificationPriority.high,
        isRead: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        iconName: 'emoji_events',
      ),
      NotificationEntity(
        id: 'notif3',
        userId: userId,
        title: '挑战完成',
        message: '你已完成今日单词挑战！',
        type: NotificationType.challengeComplete,
        priority: NotificationPriority.normal,
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        readAt: DateTime.now().subtract(const Duration(hours: 12)),
        iconName: 'check_circle',
      ),
    ];
  }
}