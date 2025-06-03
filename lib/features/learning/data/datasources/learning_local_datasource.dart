import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lesson_model.dart';
import '../models/learning_progress_model.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../domain/entities/learning_progress_entity.dart';

/// 学习功能本地数据源
/// 
/// 负责处理学习相关数据的本地存储和访问
abstract class LearningLocalDataSource {
  // ==================== 课程相关方法 ====================
  
  /// 获取缓存的课程列表
  Future<List<LessonModel>> getCachedLessons();
  
  /// 缓存课程列表
  Future<void> cacheLessons(List<LessonModel> lessons);
  
  /// 获取单个课程
  Future<LessonModel?> getCachedLesson(String lessonId);
  
  /// 缓存单个课程
  Future<void> cacheLesson(LessonModel lesson);
  
  /// 更新课程进度
  Future<void> updateLessonProgress(
    String userId,
    String lessonId,
    double progress,
    LessonStatus status,
    int? score,
  );
  
  /// 获取用户课程进度
  Future<Map<String, dynamic>?> getUserLessonProgress(
    String userId,
    String lessonId,
  );
  
  // ==================== 学习进度相关方法 ====================
  
  /// 获取学习进度
  Future<LearningProgressModel?> getLearningProgress(String userId);
  
  /// 保存学习进度
  Future<void> saveLearningProgress(LearningProgressModel progress);
  
  /// 更新学习时长
  Future<void> updateStudyTime(
    String userId,
    int additionalTime,
    LessonType lessonType,
  );
  
  /// 更新积分
  Future<void> updatePoints(String userId, int additionalPoints);
  
  /// 更新等级
  Future<void> updateLevel(String userId, int newLevel, double levelProgress);
  
  /// 更新连续学习天数
  Future<void> updateStreakDays(String userId, int streakDays);
  
  /// 保存每日学习记录
  Future<void> saveDailyStudyRecord(
    String userId,
    DailyStudyRecordModel record,
  );
  
  /// 获取每日学习记录
  Future<DailyStudyRecordModel?> getDailyStudyRecord(
    String userId,
    DateTime date,
  );
  
  /// 获取周学习记录
  Future<List<DailyStudyRecordModel>> getWeeklyStudyRecords(
    String userId,
    DateTime startDate,
  );
  
  /// 获取最近学习的课程
  Future<List<LessonModel>> getRecentLessons(
    String userId, {
    int limit = 3,
  });
  
  /// 计算连续学习天数
  Future<int> calculateStreakDays(String userId);
  
  // ==================== 数据管理方法 ====================
  
  /// 清除用户数据
  Future<void> clearUserData(String userId);
  
  /// 清除所有缓存
  Future<void> clearAllCache();
  
  /// 获取缓存大小
  Future<int> getCacheSize();
}

/// 学习功能本地数据源实现
class LearningLocalDataSourceImpl implements LearningLocalDataSource {
  final SharedPreferences _prefs;
  
  // 缓存键常量
  static const String _keyLessonsCache = 'lessons_cache';
  static const String _keyLessonsCacheTime = 'lessons_cache_time';
  static const String _keyLearningProgress = 'learning_progress_';
  static const String _keyUserLessonProgress = 'user_lesson_progress_';
  static const String _keyDailyStudyRecord = 'daily_study_record_';
  
  // 缓存过期时间（24小时）
  static const Duration _cacheExpiration = Duration(hours: 24);
  
  const LearningLocalDataSourceImpl(this._prefs);
  
  // ==================== 课程相关方法实现 ====================
  
  @override
  Future<List<LessonModel>> getCachedLessons() async {
    try {
      // 检查缓存是否过期
      final cacheTimeStr = _prefs.getString(_keyLessonsCacheTime);
      if (cacheTimeStr != null) {
        final cacheTime = DateTime.parse(cacheTimeStr);
        if (DateTime.now().difference(cacheTime) > _cacheExpiration) {
          // 缓存已过期，返回空列表
          return [];
        }
      }
      
      final lessonsJson = _prefs.getString(_keyLessonsCache);
      if (lessonsJson == null) return [];
      
      final lessonsList = json.decode(lessonsJson) as List<dynamic>;
      return lessonsList
          .map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }
  
  @override
  Future<void> cacheLessons(List<LessonModel> lessons) async {
    try {
      final lessonsJson = json.encode(
        lessons.map((e) => e.toJson()).toList(),
      );
      
      await _prefs.setString(_keyLessonsCache, lessonsJson);
      await _prefs.setString(
        _keyLessonsCacheTime,
        DateTime.now().toIso8601String(),
      );
    } catch (e) {
      // 缓存失败，忽略错误
    }
  }
  
  @override
  Future<LessonModel?> getCachedLesson(String lessonId) async {
    try {
      final lessons = await getCachedLessons();
      return lessons.firstWhere(
        (lesson) => lesson.id == lessonId,
        orElse: () => throw StateError('Lesson not found'),
      );
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<void> cacheLesson(LessonModel lesson) async {
    try {
      final lessons = await getCachedLessons();
      final index = lessons.indexWhere((l) => l.id == lesson.id);
      
      if (index >= 0) {
        lessons[index] = lesson;
      } else {
        lessons.add(lesson);
      }
      
      await cacheLessons(lessons);
    } catch (e) {
      // 缓存失败，忽略错误
    }
  }
  
  @override
  Future<void> updateLessonProgress(
    String userId,
    String lessonId,
    double progress,
    LessonStatus status,
    int? score,
  ) async {
    try {
      final key = '$_keyUserLessonProgress$userId$lessonId';
      final progressData = {
        'progress': progress,
        'status': status.name,
        'score': score,
        'updatedAt': DateTime.now().toIso8601String(),
      };
      
      await _prefs.setString(key, json.encode(progressData));
      
      // 同时更新缓存中的课程数据
      final lesson = await getCachedLesson(lessonId);
      if (lesson != null) {
        final updatedLesson = lesson.copyWith(
          progress: progress,
          status: status,
          bestScore: score != null && (lesson.bestScore == null || score > lesson.bestScore!)
              ? score
              : lesson.bestScore,
          updatedAt: DateTime.now(),
        );
        await cacheLesson(updatedLesson);
      }
    } catch (e) {
      // 更新失败，抛出异常
      throw Exception('Failed to update lesson progress: $e');
    }
  }
  
  @override
  Future<Map<String, dynamic>?> getUserLessonProgress(
    String userId,
    String lessonId,
  ) async {
    try {
      final key = '$_keyUserLessonProgress$userId$lessonId';
      final progressJson = _prefs.getString(key);
      
      if (progressJson == null) return null;
      
      return json.decode(progressJson) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }
  
  // ==================== 学习进度相关方法实现 ====================
  
  @override
  Future<LearningProgressModel?> getLearningProgress(String userId) async {
    try {
      final key = '$_keyLearningProgress$userId';
      final progressJson = _prefs.getString(key);
      
      if (progressJson == null) return null;
      
      final progressData = json.decode(progressJson) as Map<String, dynamic>;
      return LearningProgressModel.fromJson(progressData);
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<void> saveLearningProgress(LearningProgressModel progress) async {
    try {
      final key = '$_keyLearningProgress${progress.userId}';
      final progressJson = json.encode(progress.toJson());
      
      await _prefs.setString(key, progressJson);
    } catch (e) {
      throw Exception('Failed to save learning progress: $e');
    }
  }
  
  @override
  Future<void> updateStudyTime(
    String userId,
    int additionalTime,
    LessonType lessonType,
  ) async {
    try {
      final progress = await getLearningProgress(userId);
      if (progress == null) return;
      
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      
      // 更新总学习时长和今日学习时长
      final updatedProgress = progress.copyWith(
        totalStudyTime: progress.totalStudyTime + additionalTime,
        todayStudyTime: progress.todayStudyTime + additionalTime,
        lastStudyTime: now,
        updatedAt: now,
      );
      
      // 更新分类进度
      final categoryProgress = Map<LessonType, CategoryProgress>.from(
        updatedProgress.categoryProgress,
      );
      
      if (categoryProgress.containsKey(lessonType)) {
        final current = categoryProgress[lessonType]!;
        categoryProgress[lessonType] = CategoryProgressModel.fromEntity(current).copyWith(
          studyTime: current.studyTime + additionalTime,
          lastStudyTime: now,
        );
      }
      
      final finalProgress = updatedProgress.copyWith(
        categoryProgress: categoryProgress,
      );
      
      await saveLearningProgress(finalProgress);
      
      // 保存今日学习记录
      await _updateDailyStudyRecord(userId, today, additionalTime, 0, 0);
    } catch (e) {
      throw Exception('Failed to update study time: $e');
    }
  }
  
  @override
  Future<void> updatePoints(String userId, int additionalPoints) async {
    try {
      final progress = await getLearningProgress(userId);
      if (progress == null) return;
      
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      
      final updatedProgress = progress.copyWith(
        totalPoints: progress.totalPoints + additionalPoints,
        updatedAt: now,
      );
      
      await saveLearningProgress(updatedProgress);
      
      // 更新今日学习记录
      await _updateDailyStudyRecord(userId, today, 0, 0, additionalPoints);
    } catch (e) {
      throw Exception('Failed to update points: $e');
    }
  }
  
  @override
  Future<void> updateLevel(String userId, int newLevel, double levelProgress) async {
    try {
      final progress = await getLearningProgress(userId);
      if (progress == null) return;
      
      final updatedProgress = progress.copyWith(
        currentLevel: newLevel,
        levelProgress: levelProgress,
        updatedAt: DateTime.now(),
      );
      
      await saveLearningProgress(updatedProgress);
    } catch (e) {
      throw Exception('Failed to update level: $e');
    }
  }
  
  @override
  Future<void> updateStreakDays(String userId, int streakDays) async {
    try {
      final progress = await getLearningProgress(userId);
      if (progress == null) return;
      
      final updatedProgress = progress.copyWith(
        currentStreak: streakDays,
        longestStreak: streakDays > progress.longestStreak
            ? streakDays
            : progress.longestStreak,
        updatedAt: DateTime.now(),
      );
      
      await saveLearningProgress(updatedProgress);
    } catch (e) {
      throw Exception('Failed to update streak days: $e');
    }
  }
  
  @override
  Future<void> saveDailyStudyRecord(
    String userId,
    DailyStudyRecordModel record,
  ) async {
    try {
      final key = '$_keyDailyStudyRecord$userId${record.dateString}';
      final recordJson = json.encode(record.toJson());
      
      await _prefs.setString(key, recordJson);
    } catch (e) {
      throw Exception('Failed to save daily study record: $e');
    }
  }
  
  @override
  Future<DailyStudyRecordModel?> getDailyStudyRecord(
    String userId,
    DateTime date,
  ) async {
    try {
      final dateString = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      final key = '$_keyDailyStudyRecord$userId$dateString';
      final recordJson = _prefs.getString(key);
      
      if (recordJson == null) return null;
      
      final recordData = json.decode(recordJson) as Map<String, dynamic>;
      return DailyStudyRecordModel.fromJson(recordData);
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<List<DailyStudyRecordModel>> getWeeklyStudyRecords(
    String userId,
    DateTime startDate,
  ) async {
    try {
      final records = <DailyStudyRecordModel>[];
      
      for (int i = 0; i < 7; i++) {
        final date = startDate.add(Duration(days: i));
        final record = await getDailyStudyRecord(userId, date);
        
        if (record != null) {
          records.add(record);
        } else {
          // 如果没有记录，创建一个空记录
          records.add(DailyStudyRecordModel(
            date: DateTime(date.year, date.month, date.day),
            studyTime: 0,
            completedLessons: 0,
            earnedPoints: 0,
            goalCompleted: false,
          ));
        }
      }
      
      return records;
    } catch (e) {
      return [];
    }
  }
  
  // ==================== 数据管理方法实现 ====================
  
  @override
  Future<void> clearUserData(String userId) async {
    try {
      final keys = _prefs.getKeys();
      final userKeys = keys.where((key) => key.contains(userId)).toList();
      
      for (final key in userKeys) {
        await _prefs.remove(key);
      }
    } catch (e) {
      throw Exception('Failed to clear user data: $e');
    }
  }
  
  @override
  Future<void> clearAllCache() async {
    try {
      await _prefs.remove(_keyLessonsCache);
      await _prefs.remove(_keyLessonsCacheTime);
    } catch (e) {
      throw Exception('Failed to clear cache: $e');
    }
  }
  
  @override
  Future<int> getCacheSize() async {
    try {
      final keys = _prefs.getKeys();
      int totalSize = 0;
      
      for (final key in keys) {
        final value = _prefs.getString(key);
        if (value != null) {
          totalSize += value.length;
        }
      }
      
      return totalSize;
    } catch (e) {
      return 0;
    }
  }
  
  // ==================== 私有辅助方法 ====================
  
  /// 更新每日学习记录
  Future<void> _updateDailyStudyRecord(
    String userId,
    DateTime date,
    int additionalStudyTime,
    int additionalLessons,
    int additionalPoints,
  ) async {
    try {
      final existingRecord = await getDailyStudyRecord(userId, date);
      
      final updatedRecord = existingRecord?.copyWith(
        studyTime: existingRecord.studyTime + additionalStudyTime,
        completedLessons: existingRecord.completedLessons + additionalLessons,
        earnedPoints: existingRecord.earnedPoints + additionalPoints,
      ) ?? DailyStudyRecordModel(
        date: DateTime(date.year, date.month, date.day),
        studyTime: additionalStudyTime,
        completedLessons: additionalLessons,
        earnedPoints: additionalPoints,
        goalCompleted: false,
      );
      
      await saveDailyStudyRecord(userId, updatedRecord);
    } catch (e) {
      // 更新失败，忽略错误
    }
  }
  
  @override
  Future<List<LessonModel>> getRecentLessons(
    String userId, {
    int limit = 3,
  }) async {
    try {
      // 从本地存储获取用户最近学习的课程
      final recentLessonsJson = _prefs.getString('recent_lessons_$userId');
      if (recentLessonsJson == null) {
        return [];
      }
      
      final List<dynamic> lessonsList = json.decode(recentLessonsJson);
      final lessons = lessonsList
          .map((json) => LessonModel.fromJson(json))
          .take(limit)
          .toList();
      
      return lessons;
    } catch (e) {
      return [];
    }
  }
  
  @override
  Future<int> calculateStreakDays(String userId) async {
    try {
      final now = DateTime.now();
      int streakDays = 0;
      
      // 从今天开始往前检查连续学习天数
      for (int i = 0; i < 365; i++) {
        final checkDate = now.subtract(Duration(days: i));
        final record = await getDailyStudyRecord(userId, checkDate);
        
        if (record != null && record.studyTime > 0) {
          streakDays++;
        } else {
          break;
        }
      }
      
      return streakDays;
    } catch (e) {
      return 0;
    }
  }
}