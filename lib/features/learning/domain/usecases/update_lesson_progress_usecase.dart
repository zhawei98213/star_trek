import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/lesson_entity.dart';
import '../entities/learning_progress_entity.dart';
import '../repositories/learning_repository.dart';
import '../../../../core/constants/app_constants.dart';

/// 更新课程进度用例
/// 
/// 负责处理课程进度更新的业务逻辑
class UpdateLessonProgressUseCase implements UseCase<UpdateProgressResult, UpdateProgressParams> {
  final LearningRepository _repository;
  
  const UpdateLessonProgressUseCase(this._repository);
  
  /// 执行更新课程进度
  /// 
  /// [params] 更新参数
  @override
  Future<Either<Failure, UpdateProgressResult>> call(UpdateProgressParams params) async {
    try {
      // 获取当前课程信息
      final lessonResult = await _repository.getLessonById(params.lessonId);
      return await lessonResult.fold(
        (failure) async => Left(failure),
        (lesson) async {
          // 获取当前学习进度
          final progressResult = await _repository.getLearningProgress(params.userId);
          return await progressResult.fold(
            (failure) async => Left(failure),
            (currentProgress) async {
              // 更新课程进度
              await _repository.updateLessonProgress(
                params.userId,
                params.lessonId,
                params.progress,
                params.status,
                score: params.score,
              );
              
              // 计算积分奖励
              final pointsEarned = _calculatePointsEarned(
                lesson,
                params.progress,
                params.status,
                params.score,
              );
              
              // 更新学习时长
              if (params.studyTime > 0) {
                await _repository.addStudyTime(
                  params.userId,
                  params.studyTime,
                  lesson.type,
                );
              }
              
              // 添加积分
              if (pointsEarned > 0) {
                await _repository.addPoints(
                  params.userId,
                  pointsEarned,
                  _getPointsReason(params.status, lesson.title),
                );
              }
              
              // 如果课程完成，处理完成逻辑
              if (params.status == LessonStatus.completed) {
                await _handleLessonCompletion(
                  params.userId,
                  lesson,
                  params.score ?? 0,
                  params.studyTime,
                );
              }
              
              // 检查并更新等级
              final newTotalPoints = currentProgress.totalPoints + pointsEarned;
              final newLevel = await _repository.checkAndUpdateLevel(
                params.userId,
                newTotalPoints,
              );
              
              // 更新连续学习天数
              final newStreak = await _repository.updateStreakDays(params.userId);
              
              // 获取更新后的学习进度
              final updatedProgressResult = await _repository.getLearningProgress(params.userId);
              
              return updatedProgressResult.fold(
                (failure) => Left(failure),
                (updatedProgress) => Right(UpdateProgressResult.success(
                  pointsEarned: pointsEarned,
                  levelUp: newLevel > currentProgress.currentLevel,
                  newLevel: newLevel,
                  newStreak: newStreak,
                  updatedProgress: updatedProgress,
                )),
              );
            },
          );
        },
      );
    } catch (e) {
      return Left(ServerFailure('更新进度失败: ${e.toString()}'));
    }
  }
  
  /// 计算获得的积分
  /// 
  /// [lesson] 课程信息
  /// [progress] 进度
  /// [status] 状态
  /// [score] 得分
  int _calculatePointsEarned(
    LessonEntity lesson,
    double progress,
    LessonStatus status,
    int? score,
  ) {
    int points = 0;
    
    // 根据课程状态给予基础积分
    switch (status) {
      case LessonStatus.completed:
        points += AppConstants.pointsPerCompletedLesson;
        break;
      case LessonStatus.inProgress:
        // 进行中的课程根据进度给予部分积分
        points += (AppConstants.pointsPerCompletedLesson * progress * 0.5).round();
        break;
      default:
        break;
    }
    
    // 根据得分给予额外积分
    if (score != null && score > 0) {
      points += (score * 0.1).round(); // 每分给0.1积分
    }
    
    // 根据难度给予难度奖励
    switch (lesson.difficulty) {
      case DifficultyLevel.beginner:
        points = (points * 1.0).round();
        break;
      case DifficultyLevel.intermediate:
        points = (points * 1.2).round();
        break;
      case DifficultyLevel.advanced:
        points = (points * 1.5).round();
        break;
    }
    
    return points;
  }
  
  /// 获取积分获得原因
  /// 
  /// [status] 课程状态
  /// [lessonTitle] 课程标题
  String _getPointsReason(LessonStatus status, String lessonTitle) {
    switch (status) {
      case LessonStatus.completed:
        return '完成课程：$lessonTitle';
      case LessonStatus.inProgress:
        return '学习课程：$lessonTitle';
      default:
        return '课程进度更新：$lessonTitle';
    }
  }
  
  /// 处理课程完成逻辑
  /// 
  /// [userId] 用户ID
  /// [lesson] 课程信息
  /// [score] 得分
  /// [studyTime] 学习时长
  Future<void> _handleLessonCompletion(
    String userId,
    LessonEntity lesson,
    int score,
    int studyTime,
  ) async {
    // 调用仓库的完成课程方法
    await _repository.completeLession(
      userId,
      lesson.id,
      score,
      studyTime,
    );
    
    // TODO: 检查是否解锁新课程
    // TODO: 检查是否获得新成就
    // TODO: 发送完成通知
  }
}

/// 更新进度参数
class UpdateProgressParams {
  /// 用户ID
  final String userId;
  
  /// 课程ID
  final String lessonId;
  
  /// 进度值（0.0 - 1.0）
  final double progress;
  
  /// 课程状态
  final LessonStatus status;
  
  /// 得分（可选）
  final int? score;
  
  /// 学习时长（分钟）
  final int studyTime;
  
  const UpdateProgressParams({
    required this.userId,
    required this.lessonId,
    required this.progress,
    required this.status,
    required this.studyTime,
    this.score,
  });
  
  @override
  String toString() {
    return 'UpdateProgressParams(userId: $userId, lessonId: $lessonId, progress: $progress, status: $status)';
  }
}

/// 更新进度结果
class UpdateProgressResult {
  /// 是否成功
  final bool isSuccess;
  
  /// 错误信息（失败时）
  final String? errorMessage;
  
  /// 获得的积分
  final int pointsEarned;
  
  /// 是否升级
  final bool levelUp;
  
  /// 新等级
  final int newLevel;
  
  /// 新的连续学习天数
  final int newStreak;
  
  /// 更新后的学习进度
  final LearningProgressEntity? updatedProgress;
  
  const UpdateProgressResult._(
    this.isSuccess,
    this.errorMessage,
    this.pointsEarned,
    this.levelUp,
    this.newLevel,
    this.newStreak,
    this.updatedProgress,
  );
  
  /// 创建成功结果
  factory UpdateProgressResult.success({
    required int pointsEarned,
    required bool levelUp,
    required int newLevel,
    required int newStreak,
    LearningProgressEntity? updatedProgress,
  }) {
    return UpdateProgressResult._(
      true,
      null,
      pointsEarned,
      levelUp,
      newLevel,
      newStreak,
      updatedProgress,
    );
  }
  
  /// 创建失败结果
  factory UpdateProgressResult.failure(String errorMessage) {
    return UpdateProgressResult._(
      false,
      errorMessage,
      0,
      false,
      0,
      0,
      null,
    );
  }
  
  @override
  String toString() {
    if (isSuccess) {
      return 'UpdateProgressResult.success(points: $pointsEarned, levelUp: $levelUp, level: $newLevel)';
    } else {
      return 'UpdateProgressResult.failure(${errorMessage ?? "Unknown error"})';
    }
  }
}