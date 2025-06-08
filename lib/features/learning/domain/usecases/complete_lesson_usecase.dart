import '../entities/lesson_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/learning_progress_entity.dart';
import '../repositories/learning_repository.dart';
import '../../../../core/constants/app_constants.dart';

/// 完成课程用例
/// 
/// 处理课程完成的完整业务逻辑，包括进度更新、积分奖励、等级提升等
class CompleteLessonUseCase implements UseCase<CompletionResult, CompleteLessonParams> {
  final LearningRepository _repository;
  
  const CompleteLessonUseCase(this._repository);
  
  /// 执行课程完成逻辑
  /// 
  /// [params] 完成课程的参数
  /// 返回完成结果，包含奖励信息和更新后的进度
  @override
  Future<Either<Failure, CompletionResult>> call(
    CompleteLessonParams params,
  ) async {
    try {
      // 1. 验证课程存在性
      final lessonResult = await _repository.getLessonById(params.lessonId);
      return lessonResult.fold(
        (failure) => Left(failure),
        (lesson) async {
      
      // 2. 验证课程是否已解锁
      if (!lesson.isUnlocked) {
        return Left(ValidationFailure('课程尚未解锁'));
      }
      
          // 3. 获取当前学习进度
          final progressResult = await _repository.getLearningProgress(params.userId);
          return progressResult.fold(
            (failure) => Left(failure),
            (currentProgress) async {
      
      // 4. 检查课程是否已完成（避免重复完成）
      if (lesson.status == LessonStatus.completed) {
        return Left(ValidationFailure('课程已完成'));
      }
      
      // 5. 计算完成奖励
      final rewards = await _calculateCompletionRewards(
        lesson,
        params.score,
        params.studyTime,
        currentProgress,
      );
      
      // 6. 更新课程状态为完成
      await _repository.updateLessonProgress(
        params.userId,
        params.lessonId,
        1.0, // 100%完成
        LessonStatus.completed,
        score: params.score,
      );
      
      // 7. 添加学习时长
      if (params.studyTime > 0) {
        await _repository.addStudyTime(
          params.userId,
          params.studyTime,
          lesson.type,
        );
      }
      
      // 8. 添加积分奖励
      if (rewards.pointsEarned > 0) {
        await _repository.addPoints(
          params.userId,
          rewards.pointsEarned,
          '完成课程: ${lesson.title}',
        );
      }
      
      // 9. 检查并更新等级
      final newTotalPoints = currentProgress.totalPoints + rewards.pointsEarned;
      final newLevel = await _repository.checkAndUpdateLevel(
        params.userId,
        newTotalPoints,
      );
      
      // 10. 更新连续学习天数
      final newStreak = await _repository.updateStreakDays(params.userId);
      
      // 11. 解锁下一课程（如果有）
      await _unlockNextLessons(params.userId, lesson);
      
      // 12. 检查成就解锁
      final newAchievements = await _checkAchievements(
        params.userId,
        lesson,
        currentProgress,
        newTotalPoints,
        newLevel,
      );
      
              // 13. 获取更新后的学习进度
              final updatedProgressResult = await _repository.getLearningProgress(params.userId);
              
              return updatedProgressResult.fold(
                (failure) => Left(failure),
                (updatedProgress) {
                  // 14. 构建完成结果
                  final result = CompletionResult(
                    lesson: lesson,
                    pointsEarned: rewards.pointsEarned,
                    bonusPoints: rewards.bonusPoints,
                    levelUp: newLevel > currentProgress.currentLevel,
                    previousLevel: currentProgress.currentLevel,
                    newLevel: newLevel,
                    streakUpdated: newStreak > currentProgress.currentStreak,
                    newStreak: newStreak,
                    newAchievements: newAchievements,
                    updatedProgress: updatedProgress,
                    perfectScore: params.score != null && params.score! >= 100,
                    fastCompletion: params.studyTime < lesson.estimatedDuration * 0.8,
                  );
                  
                  return Right(result);
                },
              );
            },
          );
        },
      );
    } catch (e) {
      return Left(ServerFailure('完成课程失败: ${e.toString()}'));
    }
  }
  
  /// 计算完成奖励
  Future<CompletionRewards> _calculateCompletionRewards(
    LessonEntity lesson,
    int? score,
    int studyTime,
    LearningProgressEntity currentProgress,
  ) async {
    int basePoints = 0;
    int bonusPoints = 0;
    
    // 基础积分（根据难度）
    switch (lesson.difficulty) {
      case DifficultyLevel.beginner:
        basePoints = AppConstants.pointsPerBeginnerLesson;
        break;
      case DifficultyLevel.intermediate:
        basePoints = AppConstants.pointsPerIntermediateLesson;
        break;
      case DifficultyLevel.advanced:
        basePoints = AppConstants.pointsPerAdvancedLesson;
        break;
    }
    
    // 分数奖励
    if (score != null) {
      if (score >= 100) {
        bonusPoints += (basePoints * 0.5).round(); // 满分奖励50%
      } else if (score >= 90) {
        bonusPoints += (basePoints * 0.3).round(); // 优秀奖励30%
      } else if (score >= 80) {
        bonusPoints += (basePoints * 0.1).round(); // 良好奖励10%
      }
    }
    
    // 快速完成奖励
    if (studyTime < lesson.estimatedDuration * 0.8) {
      bonusPoints += (basePoints * 0.2).round(); // 快速完成奖励20%
    }
    
    // 连续学习奖励
    if (currentProgress.currentStreak >= 7) {
      bonusPoints += (basePoints * 0.3).round(); // 连续一周奖励30%
    } else if (currentProgress.currentStreak >= 3) {
      bonusPoints += (basePoints * 0.1).round(); // 连续三天奖励10%
    }
    
    return CompletionRewards(
      pointsEarned: basePoints + bonusPoints,
      bonusPoints: bonusPoints,
    );
  }
  
  /// 解锁下一课程
  Future<void> _unlockNextLessons(
    String userId,
    LessonEntity completedLesson,
  ) async {
    // 根据课程类型和难度解锁相关课程
    // 这里可以实现复杂的解锁逻辑
    
    // 简单实现：解锁同类型的下一难度课程
    final nextDifficulty = _getNextDifficulty(completedLesson.difficulty);
    if (nextDifficulty != null) {
      await _repository.unlockLessonsByTypeAndDifficulty(
        userId,
        completedLesson.type,
        nextDifficulty,
      );
    }
  }
  
  /// 获取下一难度等级
  DifficultyLevel? _getNextDifficulty(DifficultyLevel current) {
    switch (current) {
      case DifficultyLevel.beginner:
        return DifficultyLevel.intermediate;
      case DifficultyLevel.intermediate:
        return DifficultyLevel.advanced;
      case DifficultyLevel.advanced:
        return null; // 已是最高难度
    }
  }
  
  /// 检查成就解锁
  Future<List<String>> _checkAchievements(
    String userId,
    LessonEntity lesson,
    LearningProgressEntity currentProgress,
    int newTotalPoints,
    int newLevel,
  ) async {
    final newAchievements = <String>[];
    
    // 检查各种成就条件
    // 这里可以实现复杂的成就系统
    
    // 示例成就检查
    if (currentProgress.completedLessons + 1 == 1) {
      newAchievements.add('first_lesson'); // 第一课完成
    }
    
    if (currentProgress.completedLessons + 1 == 10) {
      newAchievements.add('ten_lessons'); // 完成10课
    }
    
    if (newLevel > currentProgress.currentLevel) {
      newAchievements.add('level_up_$newLevel'); // 等级提升
    }
    
    return newAchievements;
  }
}

/// 完成课程参数
class CompleteLessonParams {
  final String userId;
  final String lessonId;
  final int? score; // 课程得分（可选）
  final int studyTime; // 学习时长（分钟）
  
  const CompleteLessonParams({
    required this.userId,
    required this.lessonId,
    this.score,
    required this.studyTime,
  });
}

/// 完成奖励
class CompletionRewards {
  final int pointsEarned;
  final int bonusPoints;
  
  const CompletionRewards({
    required this.pointsEarned,
    required this.bonusPoints,
  });
}

/// 完成结果
class CompletionResult {
  final LessonEntity lesson;
  final int pointsEarned;
  final int bonusPoints;
  final bool levelUp;
  final int previousLevel;
  final int newLevel;
  final bool streakUpdated;
  final int newStreak;
  final List<String> newAchievements;
  final LearningProgressEntity updatedProgress;
  final bool perfectScore;
  final bool fastCompletion;
  
  const CompletionResult({
    required this.lesson,
    required this.pointsEarned,
    required this.bonusPoints,
    required this.levelUp,
    required this.previousLevel,
    required this.newLevel,
    required this.streakUpdated,
    required this.newStreak,
    required this.newAchievements,
    required this.updatedProgress,
    required this.perfectScore,
    required this.fastCompletion,
  });
  
  /// 是否有特殊奖励
  bool get hasSpecialRewards => perfectScore || fastCompletion || levelUp || newAchievements.isNotEmpty;
}