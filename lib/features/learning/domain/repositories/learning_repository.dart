import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/lesson_entity.dart';
import '../entities/learning_progress_entity.dart';

/// 学习功能数据仓库接口
/// 
/// 定义学习相关数据的访问方法
abstract class LearningRepository {
  // ==================== 课程相关方法 ====================
  
  /// 获取所有课程列表
  /// 
  /// [ageGroup] 年龄组筛选
  /// [difficulty] 难度筛选
  /// [type] 课程类型筛选
  Future<Either<Failure, List<LessonEntity>>> getLessons({
    AgeGroup? ageGroup,
    DifficultyLevel? difficulty,
    LessonType? type,
  });
  
  /// 根据ID获取课程详情
  /// 
  /// [lessonId] 课程ID
  Future<Either<Failure, LessonEntity>> getLessonById(String lessonId);
  
  /// 获取推荐课程列表
  /// 
  /// [userId] 用户ID
  /// [limit] 返回数量限制
  Future<Either<Failure, List<LessonEntity>>> getRecommendedLessons(
    String userId, {
    int limit = 5,
  });
  
  /// 获取用户最近学习的课程
  /// 
  /// [userId] 用户ID
  /// [limit] 返回数量限制
  Future<Either<Failure, List<LessonEntity>>> getRecentLessons(
    String userId, {
    int limit = 3,
  });
  
  /// 搜索课程
  /// 
  /// [query] 搜索关键词
  /// [filters] 筛选条件
  Future<Either<Failure, List<LessonEntity>>> searchLessons(
    String query, {
    Map<String, dynamic>? filters,
  });
  
  /// 更新课程进度
  /// 
  /// [userId] 用户ID
  /// [lessonId] 课程ID
  /// [progress] 进度值（0.0 - 1.0）
  /// [status] 课程状态
  /// [score] 得分（可选）
  Future<Either<Failure, Unit>> updateLessonProgress(
    String userId,
    String lessonId,
    double progress,
    LessonStatus status, {
    int? score,
  });
  
  /// 标记课程为已完成
  /// 
  /// [userId] 用户ID
  /// [lessonId] 课程ID
  /// [score] 完成得分
  /// [studyTime] 学习时长（分钟）
  Future<Either<Failure, Unit>> completeLession(
    String userId,
    String lessonId,
    int score,
    int studyTime,
  );
  
  // ==================== 学习进度相关方法 ====================
  
  /// 获取用户学习进度
  /// 
  /// [userId] 用户ID
  Future<Either<Failure, LearningProgressEntity>> getLearningProgress(String userId);
  
  /// 更新学习进度
  /// 
  /// [progress] 学习进度实体
  Future<Either<Failure, Unit>> updateLearningProgress(LearningProgressEntity progress);
  
  /// 添加学习时长
  /// 
  /// [userId] 用户ID
  /// [studyTime] 学习时长（分钟）
  /// [lessonType] 课程类型
  Future<Either<Failure, Unit>> addStudyTime(
    String userId,
    int studyTime,
    LessonType lessonType,
  );
  
  /// 更新每日目标
  /// 
  /// [userId] 用户ID
  /// [dailyGoal] 每日目标（分钟）
  Future<Either<Failure, Unit>> updateDailyGoal(String userId, int dailyGoal);
  
  /// 获取每日学习统计
  /// 
  /// [userId] 用户ID
  /// [date] 指定日期
  Future<DailyStudyRecord?> getDailyStudyRecord(
    String userId,
    DateTime date,
  );
  
  /// 获取周学习统计
  /// 
  /// [userId] 用户ID
  /// [startDate] 开始日期
  Future<List<DailyStudyRecord>> getWeeklyStudyRecords(
    String userId,
    DateTime startDate,
  );
  
  /// 获取月学习统计
  /// 
  /// [userId] 用户ID
  /// [year] 年份
  /// [month] 月份
  Future<List<DailyStudyRecord>> getMonthlyStudyRecords(
    String userId,
    int year,
    int month,
  );
  
  // ==================== 成就和等级相关方法 ====================
  
  /// 检查并更新用户等级
  /// 
  /// [userId] 用户ID
  /// [totalPoints] 总积分
  Future<int> checkAndUpdateLevel(String userId, int totalPoints);
  
  /// 添加积分
  /// 
  /// [userId] 用户ID
  /// [points] 积分数量
  /// [reason] 获得积分的原因
  Future<void> addPoints(
    String userId,
    int points,
    String reason,
  );
  
  /// 更新连续学习天数
  /// 
  /// [userId] 用户ID
  Future<int> updateStreakDays(String userId);
  
  // ==================== 数据同步相关方法 ====================
  
  /// 同步本地数据到云端
  /// 
  /// [userId] 用户ID
  Future<void> syncToCloud(String userId);
  
  /// 从云端同步数据到本地
  /// 
  /// [userId] 用户ID
  Future<void> syncFromCloud(String userId);
  
  /// 清除用户学习数据
  /// 
  /// [userId] 用户ID
  Future<void> clearUserData(String userId);
  
  /// 导出用户学习数据
  /// 
  /// [userId] 用户ID
  Future<Map<String, dynamic>> exportUserData(String userId);
  
  /// 导入用户学习数据
  /// 
  /// [userId] 用户ID
  /// [data] 导入的数据
  Future<void> importUserData(String userId, Map<String, dynamic> data);
  
  // ==================== 搜索和统计相关方法 ====================
  
  /// 获取所有课程
  Future<List<LessonEntity>> getAllLessons();
  
  /// 获取用户完成的课程列表
  /// 
  /// [userId] 用户ID
  Future<List<LessonEntity>> getCompletedLessons(String userId);
  
  /// 获取课程总数
  Future<int> getTotalLessonsCount();
  
  /// 获取用户所有学习记录
  /// 
  /// [userId] 用户ID
  Future<List<DailyStudyRecord>> getAllStudyRecords(String userId);
  
  /// 获取指定时间范围内的学习记录
  /// 
  /// [userId] 用户ID
  /// [startDate] 开始日期
  /// [endDate] 结束日期
  Future<List<DailyStudyRecord>> getStudyRecordsInRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );
  
  /// 根据类型和难度解锁课程
  /// 
  /// [userId] 用户ID
  /// [type] 课程类型
  /// [difficulty] 难度等级
  Future<void> unlockLessonsByTypeAndDifficulty(
    String userId,
    LessonType type,
    DifficultyLevel difficulty,
  );
}