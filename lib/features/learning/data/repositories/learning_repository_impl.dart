import '../../domain/entities/lesson_entity.dart';
import '../../domain/entities/learning_progress_entity.dart';
import '../../domain/repositories/learning_repository.dart';

import '../datasources/learning_local_datasource.dart';
import '../datasources/learning_remote_datasource.dart';
import '../models/lesson_model.dart';
import '../models/learning_progress_model.dart';
import '../../../../core/constants/app_constants.dart';

/// 学习仓库实现
/// 
/// 整合本地和远程数据源，提供统一的数据访问接口
class LearningRepositoryImpl implements LearningRepository {
  final LearningLocalDataSource _localDataSource;
  final LearningRemoteDataSource _remoteDataSource;
  
  const LearningRepositoryImpl({
    required LearningLocalDataSource localDataSource,
    required LearningRemoteDataSource remoteDataSource,
  }) : _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource;
  
  // ==================== 课程相关方法实现 ====================
  
  @override
  Future<List<LessonEntity>> getRecommendedLessons(
    String userId, {
    int limit = 5,
  }) async {
    try {
      final lessons = await _remoteDataSource.getRecommendedLessons(
        userId,
        limit,
      );
      return lessons.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get recommended lessons: $e');
    }
  }
  
  @override
  Future<List<LessonEntity>> getRecentLessons(
    String userId, {
    int limit = 3,
  }) async {
    try {
      final lessons = await _localDataSource.getRecentLessons(
        userId,
        limit: limit,
      );
      return lessons.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get recent lessons: $e');
    }
  }
  

  
  @override
  Future<int> updateStreakDays(String userId) async {
    try {
      final streakDays = await _localDataSource.calculateStreakDays(userId);
      await _localDataSource.updateStreakDays(userId, streakDays);
      return streakDays;
    } catch (e) {
      throw Exception('Failed to update streak days: $e');
    }
  }
  
  @override
  Future<int> checkAndUpdateLevel(String userId, int totalPoints) async {
    try {
      // 根据积分计算等级
      int newLevel = (totalPoints / 1000).floor() + 1;
      
      // 获取当前等级
      final currentProgress = await _localDataSource.getLearningProgress(userId);
      int currentLevel = currentProgress?.currentLevel ?? 1;
      
      if (newLevel > currentLevel) {
        // 更新等级
        double levelProgress = (totalPoints % 1000) / 1000.0;
        await _localDataSource.updateLevel(userId, newLevel, levelProgress);
      }
      
      return newLevel;
    } catch (e) {
      throw Exception('Failed to check and update level: $e');
    }
  }
  
  @override
  Future<DailyStudyRecord?> getDailyStudyRecord(
    String userId,
    DateTime date,
  ) async {
    try {
      final record = await _localDataSource.getDailyStudyRecord(userId, date);
      return record?.toEntity();
    } catch (e) {
      throw Exception('Failed to get daily study record: $e');
    }
  }
  
  @override
  Future<List<LessonEntity>> getLessons({
    AgeGroup? ageGroup,
    DifficultyLevel? difficulty,
    LessonType? type,
  }) async {
    try {
      // 首先尝试从缓存获取
      final cachedLessons = await _localDataSource.getCachedLessons();
      
      List<LessonModel> lessons;
      
      if (cachedLessons.isNotEmpty) {
        // 使用缓存数据
        lessons = cachedLessons;
      } else {
        // 从远程获取并缓存
        lessons = await _remoteDataSource.getLessons(
          ageGroup: ageGroup,
          difficulty: difficulty,
          type: type,
        );
        
        // 缓存到本地
        await _localDataSource.cacheLessons(lessons);
      }
      
      // 应用过滤条件
      var filteredLessons = lessons.where((lesson) {
        if (ageGroup != null && lesson.ageGroup != ageGroup) return false;
        if (difficulty != null && lesson.difficulty != difficulty) return false;
        if (type != null && lesson.type != type) return false;
        return true;
      }).toList();
      
      return filteredLessons.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get lessons: $e');
    }
  }
  
  @override
  Future<LessonEntity?> getLessonById(String lessonId) async {
    try {
      // 首先尝试从缓存获取
      final cachedLesson = await _localDataSource.getCachedLesson(lessonId);
      
      if (cachedLesson != null) {
        return cachedLesson.toEntity();
      }
      
      // 从远程获取
      final lesson = await _remoteDataSource.getLessonById(lessonId);
      
      // 缓存到本地
      await _localDataSource.cacheLesson(lesson);
      
      return lesson.toEntity();
    } catch (e) {
      throw Exception('Failed to get lesson by id: $e');
    }
  }
  
  @override
  Future<List<LessonEntity>> searchLessons(
    String query, {
    Map<String, dynamic>? filters,
  }) async {
    try {
      // 从filters中提取参数
      final ageGroup = filters?['ageGroup'] as AgeGroup?;
      final difficulty = filters?['difficulty'] as DifficultyLevel?;
      final type = filters?['type'] as LessonType?;
      final page = filters?['page'] as int? ?? 1;
      final limit = filters?['limit'] as int? ?? 20;
      
      // 从远程搜索
      final lessons = await _remoteDataSource.searchLessons(
        query,
        ageGroup: ageGroup,
        difficulty: difficulty,
        type: type,
        page: page,
        limit: limit,
      );
      
      return lessons.map((model) => model.toEntity()).toList();
    } catch (e) {
      // 如果远程搜索失败，尝试本地搜索
      final ageGroup = filters?['ageGroup'] as AgeGroup?;
      final difficulty = filters?['difficulty'] as DifficultyLevel?;
      final type = filters?['type'] as LessonType?;
      
      return getLessons(
        ageGroup: ageGroup,
        difficulty: difficulty,
        type: type,
      );
    }
  }
  
  @override
  Future<void> updateLessonProgress(
    String userId,
    String lessonId,
    double progress,
    LessonStatus status, {
    int? score,
  }) async {
    try {
      // 更新本地进度
      await _localDataSource.updateLessonProgress(
        userId,
        lessonId,
        progress,
        status,
        null, // score参数
      );
      
      // 尝试同步到远程
      try {
        await _remoteDataSource.uploadLessonProgress(
          userId,
          lessonId,
          progress,
          status,
        );
      } catch (e) {
        // 远程同步失败，记录错误但不影响本地更新
        // Failed to sync lesson progress to remote: $e
      }
    } catch (e) {
      throw Exception('Failed to update lesson progress: $e');
    }
  }
  
  @override
  Future<void> completeLession(
    String userId,
    String lessonId,
    int score,
    int studyTime,
  ) async {
    try {
      // 更新课程进度为完成
      await _localDataSource.updateLessonProgress(
        userId,
        lessonId,
        100.0, // 完成进度为100%
        LessonStatus.completed, // 课程状态为已完成
        score, // score参数
      );
      
      // 添加学习时间
      await _localDataSource.updateStudyTime(
        userId,
        studyTime,
        LessonType.interactive, // 默认类型
      );
      
      // 添加积分
      await _localDataSource.updatePoints(userId, score);
      
      // 检查并更新等级
      final currentProgress = await _localDataSource.getLearningProgress(userId);
      if (currentProgress != null) {
        await checkAndUpdateLevel(userId, currentProgress.totalPoints + score);
      }
    } catch (e) {
      throw Exception('Failed to complete lesson: $e');
    }
  }
  
  // ==================== 学习进度相关方法实现 ====================
  
  @override
  Future<LearningProgressEntity> getLearningProgress(String userId) async {
    try {
      // 首先尝试从本地获取
      final localProgress = await _localDataSource.getLearningProgress(userId);
      
      if (localProgress != null) {
        // 尝试从远程获取最新数据进行同步
        try {
          final remoteProgress = await _remoteDataSource.getUserProgress(userId);
          
          // 比较时间戳，使用最新的数据
          if (remoteProgress.updatedAt.isAfter(localProgress.updatedAt)) {
            await _localDataSource.saveLearningProgress(remoteProgress);
            return remoteProgress.toEntity();
          }
        } catch (e) {
          // 远程获取失败，使用本地数据
          // Failed to sync progress from remote: $e
        }
        
        return localProgress.toEntity();
      }
      
      // 本地没有数据，尝试从远程获取
      try {
        final remoteProgress = await _remoteDataSource.getUserProgress(userId);
        await _localDataSource.saveLearningProgress(remoteProgress);
        return remoteProgress.toEntity();
      } catch (e) {
        // 远程也没有数据，创建默认进度
        final defaultProgress = _createDefaultProgress(userId);
        await _localDataSource.saveLearningProgress(defaultProgress);
        return defaultProgress.toEntity();
      }
    } catch (e) {
      throw Exception('Failed to get learning progress: $e');
    }
  }
  
  @override
  Future<void> updateLearningProgress(LearningProgressEntity progress) async {
    try {
      final progressModel = LearningProgressModel.fromEntity(progress);
      
      // 更新本地进度
      await _localDataSource.saveLearningProgress(progressModel);
      
      // 尝试同步到远程
      try {
        await _remoteDataSource.syncProgressToServer(progress.userId, progressModel);
      } catch (e) {
        // 远程同步失败，记录错误但不影响本地更新
        // Failed to sync progress to remote: $e
      }
    } catch (e) {
      throw Exception('Failed to update learning progress: $e');
    }
  }
  
  @override
  Future<void> addStudyTime(
    String userId,
    int studyTime,
    LessonType lessonType,
  ) async {
    try {
      // 更新本地学习时长
      await _localDataSource.updateStudyTime(userId, studyTime, lessonType);
      
      // 尝试上传到远程
      try {
        await _remoteDataSource.uploadStudyTime(
          userId,
          studyTime,
          lessonType,
          DateTime.now(),
        );
      } catch (e) {
        // 远程上传失败，记录错误但不影响本地更新
        // Failed to upload study time to remote: $e
      }
    } catch (e) {
      throw Exception('Failed to add study time: $e');
    }
  }
  
  @override
  Future<void> updateDailyGoal(String userId, int goalMinutes) async {
    try {
      final progress = await _localDataSource.getLearningProgress(userId);
      if (progress == null) return;
      
      final updatedProgress = progress.copyWith(
        dailyGoal: goalMinutes,
        updatedAt: DateTime.now(),
      );
      
      await _localDataSource.saveLearningProgress(updatedProgress);
      
      // 尝试同步到远程
      try {
        await _remoteDataSource.syncProgressToServer(userId, updatedProgress);
      } catch (e) {
        // Failed to sync daily goal to remote: $e
      }
    } catch (e) {
      throw Exception('Failed to update daily goal: $e');
    }
  }
  
  Future<List<DailyStudyRecord>> getDailyStudyRecords(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final records = <DailyStudyRecord>[];
      
      // 获取本地记录
      for (var date = startDate;
           date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
           date = date.add(const Duration(days: 1))) {
        final record = await _localDataSource.getDailyStudyRecord(userId, date);
        if (record != null) {
          records.add(record.toEntity());
        }
      }
      
      return records;
    } catch (e) {
      throw Exception('Failed to get daily study records: $e');
    }
  }
  
  @override
  Future<List<DailyStudyRecord>> getWeeklyStudyRecords(
    String userId,
    DateTime startDate,
  ) async {
    try {
      final records = await _localDataSource.getWeeklyStudyRecords(
        userId,
        startDate,
      );
      
      return records.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get weekly study records: $e');
    }
  }
  
  @override
  Future<List<DailyStudyRecord>> getMonthlyStudyRecords(
    String userId,
    int year,
    int month,
  ) async {
    try {
      final startDate = DateTime(year, month, 1);
      final endDate = DateTime(year, month + 1, 0);
      
      return getDailyStudyRecords(userId, startDate, endDate);
    } catch (e) {
      throw Exception('Failed to get monthly study records: $e');
    }
  }
  
  // ==================== 成就和等级相关方法实现 ====================
  
  Future<Map<String, dynamic>> checkUserLevel(String userId) async {
    try {
      // 尝试从远程检查等级
      try {
        return await _remoteDataSource.checkUserLevel(userId);
      } catch (e) {
        // 远程检查失败，使用本地计算
        final progress = await _localDataSource.getLearningProgress(userId);
        if (progress == null) {
          return {
            'current_level': 1,
            'level_progress': 0.0,
            'points_to_next_level': AppConstants.pointsPerLevel,
            'level_up': false,
          };
        }
        
        final currentLevel = progress.currentLevel;
        final totalPoints = progress.totalPoints;
        final pointsForNextLevel = (currentLevel + 1) * AppConstants.pointsPerLevel;
        
        return {
          'current_level': currentLevel,
          'level_progress': progress.levelProgress,
          'points_to_next_level': pointsForNextLevel - totalPoints,
          'level_up': false,
        };
      }
    } catch (e) {
      throw Exception('Failed to check user level: $e');
    }
  }
  
  @override
  Future<void> addPoints(String userId, int points, String reason) async {
    try {
      // 更新本地积分
      await _localDataSource.updatePoints(userId, points);
      
      // 检查是否升级
      final levelInfo = await checkUserLevel(userId);
      if (levelInfo['level_up'] == true) {
        await _localDataSource.updateLevel(
          userId,
          levelInfo['current_level'] as int,
          levelInfo['level_progress'] as double,
        );
      }
    } catch (e) {
      throw Exception('Failed to add points: $e');
    }
  }
  

  
  Future<void> updateStreak(String userId, int streakDays) async {
    try {
      await _localDataSource.updateStreakDays(userId, streakDays);
    } catch (e) {
      throw Exception('Failed to update streak: $e');
    }
  }
  
  // ==================== 数据同步方法实现 ====================
  
  @override
  Future<void> syncToCloud(String userId) async {
    try {
      // 获取本地数据
      final progress = await _localDataSource.getLearningProgress(userId);
      if (progress == null) return;
      
      // 同步到云端
      await _remoteDataSource.syncProgressToServer(userId, progress);
    } catch (e) {
      throw Exception('Failed to sync to cloud: $e');
    }
  }
  
  @override
  Future<void> syncFromCloud(String userId) async {
    try {
      // 从云端获取数据
      final remoteProgress = await _remoteDataSource.fetchLatestProgress(userId);
      
      // 保存到本地
      await _localDataSource.saveLearningProgress(remoteProgress);
    } catch (e) {
      throw Exception('Failed to sync from cloud: $e');
    }
  }
  
  @override
  Future<void> clearUserData(String userId) async {
    try {
      await _localDataSource.clearUserData(userId);
    } catch (e) {
      throw Exception('Failed to clear user data: $e');
    }
  }
  
  @override
  Future<Map<String, dynamic>> exportUserData(String userId) async {
    try {
      final progress = await _localDataSource.getLearningProgress(userId);
      if (progress == null) {
        return {'error': 'No user data found'};
      }
      
      return {
        'user_id': userId,
        'progress': progress.toJson(),
        'export_date': DateTime.now().toIso8601String(),
        'version': '1.0.0',
      };
    } catch (e) {
      throw Exception('Failed to export user data: $e');
    }
  }
  
  @override
  Future<void> importUserData(
    String userId,
    Map<String, dynamic> userData,
  ) async {
    try {
      final progressData = userData['progress'] as Map<String, dynamic>;
      final progress = LearningProgressModel.fromJson(progressData);
      
      await _localDataSource.saveLearningProgress(progress);
      
      // 尝试同步到远程
      try {
        await _remoteDataSource.syncProgressToServer(userId, progress);
      } catch (e) {
        // Failed to sync imported data to remote: $e
      }
    } catch (e) {
      throw Exception('Failed to import user data: $e');
    }
  }
  
  // ==================== 私有辅助方法 ====================
  

  

  
  /// 创建默认学习进度
  LearningProgressModel _createDefaultProgress(String userId) {
    return LearningProgressModel(
      userId: userId,
      totalStudyTime: 0,
      completedLessons: 0,
      totalLessons: 0,
      totalPoints: 0,
      currentLevel: 1,
      levelProgress: 0.0,
      currentStreak: 0,
      longestStreak: 0,
      todayStudyTime: 0,
      dailyGoal: AppConstants.defaultDailyGoalMinutes,
      weeklyStats: [],
      lastStudyTime: null,
      categoryProgress: {},
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}