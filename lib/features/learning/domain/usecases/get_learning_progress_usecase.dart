import '../entities/learning_progress_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/lesson_entity.dart';
import '../repositories/learning_repository.dart';

/// 获取学习进度用例
/// 
/// 负责获取和计算用户的学习进度信息
class GetLearningProgressUseCase implements UseCase<LearningProgressEntity, String> {
  final LearningRepository _repository;
  
  const GetLearningProgressUseCase(this._repository);
  
  /// 执行获取学习进度
  /// 
  /// [userId] 用户ID
  /// 返回学习进度实体，如果用户没有学习记录则返回默认进度
  @override
  Future<Either<Failure, LearningProgressEntity>> call(String userId) async {
    try {
      // 尝试从仓库获取学习进度
      final progressResult = await _repository.getLearningProgress(userId);
      
      return progressResult.fold(
        (failure) async {
          // 如果获取失败，尝试创建默认进度
          final defaultProgress = await _createDefaultProgress(userId);
          return Right(defaultProgress);
        },
        (progress) async {
          // 如果存在进度记录，检查是否需要更新今日数据
          final updatedProgress = await _updateTodayProgress(progress);
          return Right(updatedProgress);
        },
      );
    } catch (e) {
      // 发生未预期错误时返回默认进度
      try {
        final defaultProgress = await _createDefaultProgress(userId);
        return Right(defaultProgress);
      } catch (createError) {
        return Left(UnknownFailure('无法获取或创建学习进度: ${createError.toString()}'));
      }
    }
  }
  
  /// 更新今日学习进度
  /// 
  /// [progress] 当前学习进度
  Future<LearningProgressEntity> _updateTodayProgress(
    LearningProgressEntity progress,
  ) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    // 检查最后学习时间是否是今天
    final lastStudyDate = progress.lastStudyTime != null
        ? DateTime(
            progress.lastStudyTime!.year,
            progress.lastStudyTime!.month,
            progress.lastStudyTime!.day,
          )
        : null;
    
    // 如果最后学习时间不是今天，重置今日学习时长
    if (lastStudyDate == null || !lastStudyDate.isAtSameMomentAs(today)) {
      final updatedProgress = progress.copyWith(
        todayStudyTime: 0,
        updatedAt: now,
      );
      
      // 更新到仓库
      await _repository.updateLearningProgress(updatedProgress);
      return updatedProgress;
    }
    
    return progress;
  }
  
  /// 创建默认学习进度
  /// 
  /// [userId] 用户ID
  Future<LearningProgressEntity> _createDefaultProgress(String userId) async {
    final now = DateTime.now();
    
    // 获取所有课程以计算总数
    final lessonsResult = await _repository.getLessons();
    final allLessons = lessonsResult.fold(
      (failure) => <LessonEntity>[], // 如果失败，返回空列表
      (lessons) => lessons,
    );
    
    // 创建各分类的默认进度
    final categoryProgress = <LessonType, CategoryProgress>{};
    for (final type in LessonType.values) {
      final typeLessons = allLessons.where((lesson) => lesson.type == type).length;
      categoryProgress[type] = CategoryProgress(
        type: type,
        completedLessons: 0,
        totalLessons: typeLessons,
        studyTime: 0,
        averageScore: 0.0,
      );
    }
    
    // 创建默认的周统计数据
    final weeklyStats = <DailyStudyRecord>[];
    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      weeklyStats.add(DailyStudyRecord(
        date: DateTime(date.year, date.month, date.day),
        studyTime: 0,
        completedLessons: 0,
        earnedPoints: 0,
        goalCompleted: false,
      ));
    }
    
    final defaultProgress = LearningProgressEntity(
      userId: userId,
      totalStudyTime: 0,
      completedLessons: 0,
      totalLessons: allLessons.length,
      currentStreak: 0,
      longestStreak: 0,
      totalPoints: 0,
      currentLevel: 1,
      levelProgress: 0.0,
      categoryProgress: categoryProgress,
      dailyGoal: 30, // 默认每日目标30分钟
      todayStudyTime: 0,
      weeklyStats: weeklyStats,
      createdAt: now,
      updatedAt: now,
    );
    
    // 保存到仓库
    await _repository.updateLearningProgress(defaultProgress);
    
    return defaultProgress;
  }
}