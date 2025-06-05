import 'dart:math';
import '../../domain/entities/home_data_entity.dart';
import '../../domain/entities/user_stats_entity.dart';
import '../../domain/entities/notification_entity.dart';
import 'home_remote_datasource.dart';

/// 主页远程数据源实现类（模拟网络请求）
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  // 模拟网络延迟
  static const Duration _networkDelay = Duration(milliseconds: 500);
  
  @override
  Future<HomeDataEntity> getHomeData(String userId) async {
    await Future.delayed(_networkDelay);
    
    // 模拟网络请求可能失败
    if (Random().nextDouble() < 0.1) {
      throw Exception('网络请求失败');
    }
    
    return HomeDataEntity(
      userId: userId,
      learningProgress: _generateLearningProgress(),
      quickActions: _generateQuickActions(),
      dailyChallenges: _generateDailyChallenges(),
      recentAchievements: _generateRecentAchievements(),
      welcomeMessage: _generateWelcomeMessage(),
      lastUpdated: DateTime.now(),
    );
  }
  
  @override
  Future<UserStatsEntity> getUserStats(String userId) async {
    await Future.delayed(_networkDelay);
    
    if (Random().nextDouble() < 0.1) {
      throw Exception('获取用户统计失败');
    }
    
    return UserStatsEntity(
      userId: userId,
      username: '学习者${userId.substring(0, 4)}',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=$userId',
      level: Random().nextInt(20) + 1,
      totalPoints: Random().nextInt(5000) + 500,
      currentLevelPoints: Random().nextInt(400) + 100,
      nextLevelPoints: 500,
      learningStats: _generateLearningStats(),
      achievementStats: _generateAchievementStats(),
      streakData: _generateStreakData(),
      rankingData: _generateRankingData(),
      lastUpdated: DateTime.now(),
    );
  }
  
  @override
  Future<List<NotificationEntity>> getNotifications(
    String userId, {
    int limit = 20,
    int offset = 0,
    bool unreadOnly = false,
  }) async {
    await Future.delayed(_networkDelay);
    
    if (Random().nextDouble() < 0.1) {
      throw Exception('获取通知失败');
    }
    
    final allNotifications = _generateNotifications(userId);
    
    var filteredNotifications = allNotifications;
    if (unreadOnly) {
      filteredNotifications = allNotifications.where((n) => !n.isRead).toList();
    }
    
    final startIndex = offset;
    final endIndex = (offset + limit).clamp(0, filteredNotifications.length);
    
    if (startIndex >= filteredNotifications.length) {
      return [];
    }
    
    return filteredNotifications.sublist(startIndex, endIndex);
  }
  
  @override
  Future<void> markNotificationAsRead(String notificationId) async {
    await Future.delayed(_networkDelay);
    
    if (Random().nextDouble() < 0.05) {
      throw Exception('标记通知失败');
    }
    
    // 模拟API调用成功
    // 通知已标记为已读
  }
  
  @override
  Future<void> markAllNotificationsAsRead(String userId) async {
    await Future.delayed(_networkDelay);
    
    if (Random().nextDouble() < 0.05) {
      throw Exception('标记所有通知失败');
    }
    
    // 所有通知已标记为已读
  }
  
  @override
  Future<void> deleteNotification(String notificationId) async {
    await Future.delayed(_networkDelay);
    
    if (Random().nextDouble() < 0.05) {
      throw Exception('删除通知失败');
    }
    
    // 通知已删除
  }
  
  @override
  Future<void> updateLearningProgress(
    String userId,
    Map<String, dynamic> progressData,
  ) async {
    await Future.delayed(_networkDelay);
    
    if (Random().nextDouble() < 0.05) {
      throw Exception('更新学习进度失败');
    }
    
    // 用户学习进度已更新
  }
  
  @override
  Future<void> completeDailyChallenge(
    String userId,
    String challengeId,
    int score,
  ) async {
    await Future.delayed(_networkDelay);
    
    if (Random().nextDouble() < 0.05) {
      throw Exception('完成挑战失败');
    }
    
    // 用户完成挑战
  }
  
  @override
  Future<List<QuickActionData>> getQuickActions(String userId) async {
    await Future.delayed(_networkDelay);
    
    if (Random().nextDouble() < 0.1) {
      throw Exception('获取快捷操作失败');
    }
    
    return _generateQuickActions();
  }
  
  @override
  Future<void> updateQuickActionStatus(
    String actionId,
    Map<String, dynamic> data,
  ) async {
    await Future.delayed(_networkDelay);
    
    if (Random().nextDouble() < 0.05) {
      throw Exception('更新快捷操作失败');
    }
    
    // 快捷操作状态已更新
  }
  
  @override
  Future<List<DailyChallengeData>> getDailyChallenges(String userId) async {
    await Future.delayed(_networkDelay);
    
    if (Random().nextDouble() < 0.1) {
      throw Exception('获取每日挑战失败');
    }
    
    return _generateDailyChallenges();
  }
  
  @override
  Future<List<AchievementData>> getRecentAchievements(
    String userId, {
    int limit = 5,
  }) async {
    await Future.delayed(_networkDelay);
    
    if (Random().nextDouble() < 0.1) {
      throw Exception('获取成就失败');
    }
    
    final achievements = _generateRecentAchievements();
    return achievements.take(limit).toList();
  }
  
  @override
  Future<void> syncToCloud(String userId) async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (Random().nextDouble() < 0.1) {
      throw Exception('同步到云端失败');
    }
    
    // 用户数据已同步到云端
  }
  
  @override
  Future<void> syncFromCloud(String userId) async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (Random().nextDouble() < 0.1) {
      throw Exception('从云端同步失败');
    }
    
    // 用户数据已从云端同步
  }
  
  // 数据生成方法
  
  LearningProgressData _generateLearningProgress() {
    final random = Random();
    return LearningProgressData(
      overallProgress: 0.3 + random.nextDouble() * 0.6,
      totalStudyTime: random.nextInt(2000) + 500,
      todayStudyTime: random.nextInt(60),
      dailyGoal: 30 + random.nextInt(60),
      skillProgress: [
        SkillProgressData(
          skillName: '词汇',
          skillIcon: 'book',
          progress: 0.5 + random.nextDouble() * 0.4,
          level: random.nextInt(10) + 1,
          color: '#4CAF50',
        ),
        SkillProgressData(
          skillName: '语法',
          skillIcon: 'edit',
          progress: 0.3 + random.nextDouble() * 0.5,
          level: random.nextInt(8) + 1,
          color: '#2196F3',
        ),
        SkillProgressData(
          skillName: '听力',
          skillIcon: 'headphones',
          progress: 0.2 + random.nextDouble() * 0.6,
          level: random.nextInt(6) + 1,
          color: '#FF9800',
        ),
        SkillProgressData(
          skillName: '口语',
          skillIcon: 'mic',
          progress: 0.1 + random.nextDouble() * 0.5,
          level: random.nextInt(5) + 1,
          color: '#E91E63',
        ),
      ],
      streak: random.nextInt(30),
    );
  }
  
  List<QuickActionData> _generateQuickActions() {
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
  
  List<DailyChallengeData> _generateDailyChallenges() {
    final random = Random();
    final challenges = [
      '单词大师',
      '阅读达人',
      '听力训练',
      '语法专家',
      '口语练习',
    ];
    
    return List.generate(3, (index) {
      final progress = random.nextDouble();
      final targetValue = 10 + random.nextInt(20);
      final currentValue = (targetValue * progress).round();
      
      return DailyChallengeData(
        id: 'challenge_${index + 1}',
        title: challenges[index % challenges.length],
        description: '完成$targetValue个任务',
        icon: ['book', 'article', 'headphones', 'edit', 'mic'][index % 5],
        color: ['#4CAF50', '#2196F3', '#FF9800', '#9C27B0', '#E91E63'][index % 5],
        progress: progress,
        targetValue: targetValue,
        currentValue: currentValue,
        reward: '${20 + random.nextInt(50)}金币',
      );
    });
  }
  
  List<AchievementData> _generateRecentAchievements() {
    final random = Random();
    final achievements = [
      ('连续学习', 'local_fire_department', '#F44336', '坚持'),
      ('词汇达人', 'book', '#4CAF50', '学习'),
      ('完美分数', 'star', '#FFD700', '成绩'),
      ('听力专家', 'headphones', '#FF9800', '技能'),
      ('语法大师', 'edit', '#2196F3', '技能'),
    ];
    
    return List.generate(3, (index) {
      final achievement = achievements[index % achievements.length];
      return AchievementData(
        id: 'achievement_${index + 1}',
        title: achievement.$1,
        description: '获得${achievement.$1}成就',
        icon: achievement.$2,
        color: achievement.$3,
        earnedAt: DateTime.now().subtract(Duration(hours: index + 1)),
        category: achievement.$4,
        points: 50 + random.nextInt(100),
        isNew: index == 0,
      );
    });
  }
  
  WelcomeMessageData _generateWelcomeMessage() {
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
    
    final quotes = [
      '每一次学习都是向目标迈进的一步',
      '坚持就是胜利，加油！',
      '知识改变命运，学习成就未来',
      '今天的努力，明天的收获',
      '学而时习之，不亦说乎',
    ];
    
    return WelcomeMessageData(
      greeting: greeting,
      message: '继续你的学习之旅',
      motivationalQuote: quotes[Random().nextInt(quotes.length)],
      timeOfDay: timeOfDay,
    );
  }
  
  LearningStatsData _generateLearningStats() {
    final random = Random();
    return LearningStatsData(
      totalStudyTime: random.nextInt(2000) + 500,
      todayStudyTime: random.nextInt(60),
      weekStudyTime: random.nextInt(300) + 100,
      monthStudyTime: random.nextInt(1000) + 400,
      completedLessons: random.nextInt(50) + 10,
      totalLessons: random.nextInt(100) + 50,
      completedChallenges: random.nextInt(20) + 5,
      averageScore: 70.0 + random.nextDouble() * 25,
      weeklyStudyData: _generateWeeklyStudyData(),
      subjectProgress: {
        '词汇': random.nextInt(100),
        '语法': random.nextInt(100),
        '听力': random.nextInt(100),
        '口语': random.nextInt(100),
      },
    );
  }
  
  List<DailyStudyData> _generateWeeklyStudyData() {
    final random = Random();
    final now = DateTime.now();
    return List.generate(7, (index) {
      final date = now.subtract(Duration(days: 6 - index));
      return DailyStudyData(
        date: date,
        studyTime: random.nextInt(60),
        completedLessons: random.nextInt(5),
        averageScore: 70.0 + random.nextDouble() * 25,
      );
    });
  }
  
  AchievementStatsData _generateAchievementStats() {
    final random = Random();
    return AchievementStatsData(
      totalAchievements: random.nextInt(50) + 20,
      unlockedAchievements: random.nextInt(20) + 5,
      recentAchievements: random.nextInt(5) + 1,
      featuredAchievements: ['streak_7', 'word_100', 'perfect_score'],
      categoryProgress: {
        '坚持': random.nextInt(10),
        '学习': random.nextInt(10),
        '成绩': random.nextInt(10),
        '技能': random.nextInt(10),
      },
    );
  }
  
  StreakData _generateStreakData() {
    final random = Random();
    return StreakData(
      currentStreak: random.nextInt(30),
      longestStreak: random.nextInt(100) + 10,
      lastStudyDate: DateTime.now().subtract(Duration(hours: random.nextInt(24))),
      isTodayCompleted: random.nextBool(),
      streakGoal: 30 + random.nextInt(60),
    );
  }
  
  RankingData _generateRankingData() {
    final random = Random();
    final globalRank = random.nextInt(10000) + 100;
    return RankingData(
      globalRank: globalRank,
      localRank: random.nextInt(100) + 10,
      friendsRank: random.nextInt(20) + 1,
      totalUsers: 10000 + random.nextInt(50000),
      topUsers: _generateTopUsers(),
      trend: RankingTrendData(
        previousRank: globalRank + random.nextInt(100) - 50,
        rankChange: random.nextInt(100) - 50,
        direction: random.nextBool() ? TrendDirection.up : TrendDirection.down,
        lastUpdated: DateTime.now(),
      ),
    );
  }
  
  List<RankingUserData> _generateTopUsers() {
    final random = Random();
    final usernames = ['学霸小明', '努力小红', '坚持小刚', '勤奋小美', '专注小强'];
    
    return List.generate(3, (index) {
      return RankingUserData(
        userId: 'top_user_${index + 1}',
        username: usernames[index % usernames.length],
        avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=top${index + 1}',
        rank: index + 1,
        points: 5000 - (index * 500) + random.nextInt(200),
        level: 15 - index + random.nextInt(3),
      );
    });
  }
  
  List<NotificationEntity> _generateNotifications(String userId) {
    final random = Random();
    final notifications = <NotificationEntity>[];
    
    final notificationTemplates = [
      ('学习提醒', '该开始今天的学习了！', NotificationType.studyReminder, 'schedule'),
      ('新成就解锁', '恭喜获得新成就！', NotificationType.achievement, 'emoji_events'),
      ('挑战完成', '你已完成今日挑战！', NotificationType.challengeComplete, 'check_circle'),
      ('系统更新', '应用已更新到最新版本', NotificationType.system, 'system_update'),
      ('好友动态', '你的好友完成了新挑战', NotificationType.social, 'people'),
    ];
    
    for (int i = 0; i < 10; i++) {
      final template = notificationTemplates[i % notificationTemplates.length];
      notifications.add(
        NotificationEntity(
          id: 'notif_${i + 1}',
          userId: userId,
          title: template.$1,
          message: template.$2,
          type: template.$3,
          priority: random.nextBool() 
              ? NotificationPriority.normal 
              : NotificationPriority.high,
          isRead: random.nextBool(),
          createdAt: DateTime.now().subtract(Duration(hours: i + 1)),
          readAt: random.nextBool() 
              ? DateTime.now().subtract(Duration(minutes: random.nextInt(60)))
              : null,
          iconName: template.$4,
        ),
      );
    }
    
    return notifications;
  }
}