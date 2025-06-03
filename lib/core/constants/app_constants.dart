/// 应用核心常量配置
/// 定义应用中使用的各种常量值
class AppConstants {
  // 应用信息
  static const String appName = 'Start Trek';
  static const String appVersion = '1.0.0';
  
  // 数据库配置
  static const String databaseName = 'start_trek.db';
  static const int databaseVersion = 1;
  
  // 本地存储键值
  static const String keyFirstLaunch = 'first_launch';
  static const String keyUserProfile = 'user_profile';
  static const String keyUserProgress = 'user_progress';
  static const String keyUserPoints = 'user_points';
  static const String keyUserAchievements = 'user_achievements';
  static const String keyAppSettings = 'app_settings';
  
  // 远端服务器配置
  static const String apiBaseUrl = 'URL_ADDRESS.starttrek.com';

  // 认证配置
  static const String authTokenKey = 'auth_token';
  static const String authRefreshTokenKey = 'auth_refresh_token';
  // 游戏配置
  static const int pointsPerCorrectAnswer = 10;
  static const int pointsPerCompletedLesson = 50;
  static const int pointsPerAchievement = 100;
  
  // 音频配置
  static const double defaultVolume = 0.8;
  static const double defaultSpeechRate = 0.5;
  
  // 动画配置
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration pageTransitionDuration = Duration(milliseconds: 250);
  
  // 网络配置
  static const Duration networkTimeout = Duration(seconds: 30);
  
  // 学习配置
  static const int maxDailyLessons = 5;
  static const int minCorrectAnswersToPass = 3;
  static const int pointsPerLevel = 100;
  static const int defaultDailyGoalMinutes = 30;
  
  // 年龄分组
  static const List<String> ageGroups = [
    '3-5岁',
    '6-8岁',
    '9-12岁',
  ];
  
  // 学习难度等级
  static const List<String> difficultyLevels = [
    'beginner',
    'intermediate',
    'advanced',
  ];
}