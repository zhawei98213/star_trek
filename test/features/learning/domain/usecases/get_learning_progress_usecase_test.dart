import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:start_trek/core/error/failures.dart';
import 'package:start_trek/features/learning/domain/entities/learning_progress_entity.dart';
import 'package:start_trek/features/learning/domain/entities/lesson_entity.dart';
import 'package:start_trek/features/learning/domain/repositories/learning_repository.dart';
import 'package:start_trek/features/learning/domain/usecases/get_learning_progress_usecase.dart';

import 'get_learning_progress_usecase_test.mocks.dart';

@GenerateMocks([LearningRepository])
void main() {
  group('GetLearningProgressUseCase', () {
    late GetLearningProgressUseCase usecase;
    late MockLearningRepository mockRepository;
    
    setUp(() {
      mockRepository = MockLearningRepository();
      usecase = GetLearningProgressUseCase(mockRepository);
    });
    
    test('should return learning progress when repository call is successful', () async {
      // arrange
      const userId = 'test_user_id';
      final tLearningProgress = LearningProgressEntity(
        userId: userId,
        totalStudyTime: 600,
        completedLessons: 5,
        totalLessons: 10,
        currentStreak: 3,
        longestStreak: 5,
        totalPoints: 1500,
        currentLevel: 3,
        levelProgress: 0.5,
        categoryProgress: const <LessonType, CategoryProgress>{},
        dailyGoal: 60,
        todayStudyTime: 30,
        weeklyStats: const <DailyStudyRecord>[],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      when(mockRepository.getLearningProgress(userId))
          .thenAnswer((_) async => Right(tLearningProgress));
      
      // act
      final result = await usecase.call(userId);
      
      // assert
      result.fold(
        (failure) => fail('Expected success but got failure: $failure'),
        (progress) => expect(progress, tLearningProgress),
      );
      verify(mockRepository.getLearningProgress(userId));
      verifyNoMoreInteractions(mockRepository);
    });
    
    test('should return failure when repository call fails', () async {
      // arrange
      const userId = 'test_user_id';
      when(mockRepository.getLearningProgress(userId))
          .thenAnswer((_) async => Left(ServerFailure('Failed to get learning progress')));
      
      // act
      final result = await usecase.call(userId);
      
      // assert
      result.fold(
         (failure) => expect(failure, isA<ServerFailure>()),
         (progress) => fail('Expected failure but got success: $progress'),
       );
       verify(mockRepository.getLearningProgress(userId));
       verifyNoMoreInteractions(mockRepository);
     });
    
    test('should calculate progress percentage correctly', () async {
      // arrange
      const userId = 'test_user_id';
      final tLearningProgress = LearningProgressEntity(
        userId: userId,
        totalStudyTime: 1200,
        completedLessons: 15,
        totalLessons: 20,
        currentStreak: 5,
        longestStreak: 7,
        totalPoints: 2000,
        currentLevel: 4,
        levelProgress: 0.75,
        categoryProgress: const <LessonType, CategoryProgress>{},
        dailyGoal: 90,
        todayStudyTime: 60,
        weeklyStats: const <DailyStudyRecord>[],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      when(mockRepository.getLearningProgress(userId))
          .thenAnswer((_) async => Right(tLearningProgress));
      
      // act
      final result = await usecase.call(userId);
      
      // assert
      result.fold(
        (failure) => fail('Expected success but got failure: $failure'),
        (progress) => expect(progress.overallProgress, 0.75), // 15/20 = 0.75
      );
      verify(mockRepository.getLearningProgress(userId));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}