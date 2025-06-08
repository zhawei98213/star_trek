// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learning_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LearningEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LearningEventCopyWith<$Res> {
  factory $LearningEventCopyWith(
          LearningEvent value, $Res Function(LearningEvent) then) =
      _$LearningEventCopyWithImpl<$Res, LearningEvent>;
}

/// @nodoc
class _$LearningEventCopyWithImpl<$Res, $Val extends LearningEvent>
    implements $LearningEventCopyWith<$Res> {
  _$LearningEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadLearningProgressImplCopyWith<$Res> {
  factory _$$LoadLearningProgressImplCopyWith(_$LoadLearningProgressImpl value,
          $Res Function(_$LoadLearningProgressImpl) then) =
      __$$LoadLearningProgressImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$LoadLearningProgressImplCopyWithImpl<$Res>
    extends _$LearningEventCopyWithImpl<$Res, _$LoadLearningProgressImpl>
    implements _$$LoadLearningProgressImplCopyWith<$Res> {
  __$$LoadLearningProgressImplCopyWithImpl(_$LoadLearningProgressImpl _value,
      $Res Function(_$LoadLearningProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$LoadLearningProgressImpl(
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadLearningProgressImpl implements _LoadLearningProgress {
  const _$LoadLearningProgressImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'LearningEvent.loadLearningProgress(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadLearningProgressImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadLearningProgressImplCopyWith<_$LoadLearningProgressImpl>
      get copyWith =>
          __$$LoadLearningProgressImplCopyWithImpl<_$LoadLearningProgressImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) {
    return loadLearningProgress(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) {
    return loadLearningProgress?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) {
    if (loadLearningProgress != null) {
      return loadLearningProgress(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) {
    return loadLearningProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) {
    return loadLearningProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) {
    if (loadLearningProgress != null) {
      return loadLearningProgress(this);
    }
    return orElse();
  }
}

abstract class _LoadLearningProgress implements LearningEvent {
  const factory _LoadLearningProgress(final String userId) =
      _$LoadLearningProgressImpl;

  String get userId;

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadLearningProgressImplCopyWith<_$LoadLearningProgressImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadLessonsImplCopyWith<$Res> {
  factory _$$LoadLessonsImplCopyWith(
          _$LoadLessonsImpl value, $Res Function(_$LoadLessonsImpl) then) =
      __$$LoadLessonsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GetLessonsParams params});
}

/// @nodoc
class __$$LoadLessonsImplCopyWithImpl<$Res>
    extends _$LearningEventCopyWithImpl<$Res, _$LoadLessonsImpl>
    implements _$$LoadLessonsImplCopyWith<$Res> {
  __$$LoadLessonsImplCopyWithImpl(
      _$LoadLessonsImpl _value, $Res Function(_$LoadLessonsImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? params = null,
  }) {
    return _then(_$LoadLessonsImpl(
      null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as GetLessonsParams,
    ));
  }
}

/// @nodoc

class _$LoadLessonsImpl implements _LoadLessons {
  const _$LoadLessonsImpl(this.params);

  @override
  final GetLessonsParams params;

  @override
  String toString() {
    return 'LearningEvent.loadLessons(params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadLessonsImpl &&
            (identical(other.params, params) || other.params == params));
  }

  @override
  int get hashCode => Object.hash(runtimeType, params);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadLessonsImplCopyWith<_$LoadLessonsImpl> get copyWith =>
      __$$LoadLessonsImplCopyWithImpl<_$LoadLessonsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) {
    return loadLessons(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) {
    return loadLessons?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) {
    if (loadLessons != null) {
      return loadLessons(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) {
    return loadLessons(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) {
    return loadLessons?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) {
    if (loadLessons != null) {
      return loadLessons(this);
    }
    return orElse();
  }
}

abstract class _LoadLessons implements LearningEvent {
  const factory _LoadLessons(final GetLessonsParams params) = _$LoadLessonsImpl;

  GetLessonsParams get params;

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadLessonsImplCopyWith<_$LoadLessonsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchLessonsImplCopyWith<$Res> {
  factory _$$SearchLessonsImplCopyWith(
          _$SearchLessonsImpl value, $Res Function(_$SearchLessonsImpl) then) =
      __$$SearchLessonsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String query,
      AgeGroup? ageGroup,
      DifficultyLevel? difficulty,
      LessonType? type});
}

/// @nodoc
class __$$SearchLessonsImplCopyWithImpl<$Res>
    extends _$LearningEventCopyWithImpl<$Res, _$SearchLessonsImpl>
    implements _$$SearchLessonsImplCopyWith<$Res> {
  __$$SearchLessonsImplCopyWithImpl(
      _$SearchLessonsImpl _value, $Res Function(_$SearchLessonsImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? ageGroup = freezed,
    Object? difficulty = freezed,
    Object? type = freezed,
  }) {
    return _then(_$SearchLessonsImpl(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as AgeGroup?,
      difficulty: freezed == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LessonType?,
    ));
  }
}

/// @nodoc

class _$SearchLessonsImpl implements _SearchLessons {
  const _$SearchLessonsImpl(
      {required this.query, this.ageGroup, this.difficulty, this.type});

  @override
  final String query;
  @override
  final AgeGroup? ageGroup;
  @override
  final DifficultyLevel? difficulty;
  @override
  final LessonType? type;

  @override
  String toString() {
    return 'LearningEvent.searchLessons(query: $query, ageGroup: $ageGroup, difficulty: $difficulty, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchLessonsImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, query, ageGroup, difficulty, type);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchLessonsImplCopyWith<_$SearchLessonsImpl> get copyWith =>
      __$$SearchLessonsImplCopyWithImpl<_$SearchLessonsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) {
    return searchLessons(query, ageGroup, difficulty, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) {
    return searchLessons?.call(query, ageGroup, difficulty, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) {
    if (searchLessons != null) {
      return searchLessons(query, ageGroup, difficulty, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) {
    return searchLessons(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) {
    return searchLessons?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) {
    if (searchLessons != null) {
      return searchLessons(this);
    }
    return orElse();
  }
}

abstract class _SearchLessons implements LearningEvent {
  const factory _SearchLessons(
      {required final String query,
      final AgeGroup? ageGroup,
      final DifficultyLevel? difficulty,
      final LessonType? type}) = _$SearchLessonsImpl;

  String get query;
  AgeGroup? get ageGroup;
  DifficultyLevel? get difficulty;
  LessonType? get type;

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchLessonsImplCopyWith<_$SearchLessonsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateLessonProgressImplCopyWith<$Res> {
  factory _$$UpdateLessonProgressImplCopyWith(_$UpdateLessonProgressImpl value,
          $Res Function(_$UpdateLessonProgressImpl) then) =
      __$$UpdateLessonProgressImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UpdateProgressParams params});
}

/// @nodoc
class __$$UpdateLessonProgressImplCopyWithImpl<$Res>
    extends _$LearningEventCopyWithImpl<$Res, _$UpdateLessonProgressImpl>
    implements _$$UpdateLessonProgressImplCopyWith<$Res> {
  __$$UpdateLessonProgressImplCopyWithImpl(_$UpdateLessonProgressImpl _value,
      $Res Function(_$UpdateLessonProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? params = null,
  }) {
    return _then(_$UpdateLessonProgressImpl(
      null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as UpdateProgressParams,
    ));
  }
}

/// @nodoc

class _$UpdateLessonProgressImpl implements _UpdateLessonProgress {
  const _$UpdateLessonProgressImpl(this.params);

  @override
  final UpdateProgressParams params;

  @override
  String toString() {
    return 'LearningEvent.updateLessonProgress(params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateLessonProgressImpl &&
            (identical(other.params, params) || other.params == params));
  }

  @override
  int get hashCode => Object.hash(runtimeType, params);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateLessonProgressImplCopyWith<_$UpdateLessonProgressImpl>
      get copyWith =>
          __$$UpdateLessonProgressImplCopyWithImpl<_$UpdateLessonProgressImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) {
    return updateLessonProgress(params);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) {
    return updateLessonProgress?.call(params);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) {
    if (updateLessonProgress != null) {
      return updateLessonProgress(params);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) {
    return updateLessonProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) {
    return updateLessonProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) {
    if (updateLessonProgress != null) {
      return updateLessonProgress(this);
    }
    return orElse();
  }
}

abstract class _UpdateLessonProgress implements LearningEvent {
  const factory _UpdateLessonProgress(final UpdateProgressParams params) =
      _$UpdateLessonProgressImpl;

  UpdateProgressParams get params;

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateLessonProgressImplCopyWith<_$UpdateLessonProgressImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CompleteLessonImplCopyWith<$Res> {
  factory _$$CompleteLessonImplCopyWith(_$CompleteLessonImpl value,
          $Res Function(_$CompleteLessonImpl) then) =
      __$$CompleteLessonImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId, String lessonId, int score, int studyTime});
}

/// @nodoc
class __$$CompleteLessonImplCopyWithImpl<$Res>
    extends _$LearningEventCopyWithImpl<$Res, _$CompleteLessonImpl>
    implements _$$CompleteLessonImplCopyWith<$Res> {
  __$$CompleteLessonImplCopyWithImpl(
      _$CompleteLessonImpl _value, $Res Function(_$CompleteLessonImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? lessonId = null,
    Object? score = null,
    Object? studyTime = null,
  }) {
    return _then(_$CompleteLessonImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      lessonId: null == lessonId
          ? _value.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      studyTime: null == studyTime
          ? _value.studyTime
          : studyTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CompleteLessonImpl implements _CompleteLesson {
  const _$CompleteLessonImpl(
      {required this.userId,
      required this.lessonId,
      required this.score,
      required this.studyTime});

  @override
  final String userId;
  @override
  final String lessonId;
  @override
  final int score;
  @override
  final int studyTime;

  @override
  String toString() {
    return 'LearningEvent.completeLesson(userId: $userId, lessonId: $lessonId, score: $score, studyTime: $studyTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompleteLessonImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.studyTime, studyTime) ||
                other.studyTime == studyTime));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, lessonId, score, studyTime);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompleteLessonImplCopyWith<_$CompleteLessonImpl> get copyWith =>
      __$$CompleteLessonImplCopyWithImpl<_$CompleteLessonImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) {
    return completeLesson(userId, lessonId, score, studyTime);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) {
    return completeLesson?.call(userId, lessonId, score, studyTime);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) {
    if (completeLesson != null) {
      return completeLesson(userId, lessonId, score, studyTime);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) {
    return completeLesson(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) {
    return completeLesson?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) {
    if (completeLesson != null) {
      return completeLesson(this);
    }
    return orElse();
  }
}

abstract class _CompleteLesson implements LearningEvent {
  const factory _CompleteLesson(
      {required final String userId,
      required final String lessonId,
      required final int score,
      required final int studyTime}) = _$CompleteLessonImpl;

  String get userId;
  String get lessonId;
  int get score;
  int get studyTime;

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompleteLessonImplCopyWith<_$CompleteLessonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddStudyTimeImplCopyWith<$Res> {
  factory _$$AddStudyTimeImplCopyWith(
          _$AddStudyTimeImpl value, $Res Function(_$AddStudyTimeImpl) then) =
      __$$AddStudyTimeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId, int studyTime, LessonType lessonType});
}

/// @nodoc
class __$$AddStudyTimeImplCopyWithImpl<$Res>
    extends _$LearningEventCopyWithImpl<$Res, _$AddStudyTimeImpl>
    implements _$$AddStudyTimeImplCopyWith<$Res> {
  __$$AddStudyTimeImplCopyWithImpl(
      _$AddStudyTimeImpl _value, $Res Function(_$AddStudyTimeImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? studyTime = null,
    Object? lessonType = null,
  }) {
    return _then(_$AddStudyTimeImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      studyTime: null == studyTime
          ? _value.studyTime
          : studyTime // ignore: cast_nullable_to_non_nullable
              as int,
      lessonType: null == lessonType
          ? _value.lessonType
          : lessonType // ignore: cast_nullable_to_non_nullable
              as LessonType,
    ));
  }
}

/// @nodoc

class _$AddStudyTimeImpl implements _AddStudyTime {
  const _$AddStudyTimeImpl(
      {required this.userId,
      required this.studyTime,
      required this.lessonType});

  @override
  final String userId;
  @override
  final int studyTime;
  @override
  final LessonType lessonType;

  @override
  String toString() {
    return 'LearningEvent.addStudyTime(userId: $userId, studyTime: $studyTime, lessonType: $lessonType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddStudyTimeImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.studyTime, studyTime) ||
                other.studyTime == studyTime) &&
            (identical(other.lessonType, lessonType) ||
                other.lessonType == lessonType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, studyTime, lessonType);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddStudyTimeImplCopyWith<_$AddStudyTimeImpl> get copyWith =>
      __$$AddStudyTimeImplCopyWithImpl<_$AddStudyTimeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) {
    return addStudyTime(userId, studyTime, lessonType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) {
    return addStudyTime?.call(userId, studyTime, lessonType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) {
    if (addStudyTime != null) {
      return addStudyTime(userId, studyTime, lessonType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) {
    return addStudyTime(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) {
    return addStudyTime?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) {
    if (addStudyTime != null) {
      return addStudyTime(this);
    }
    return orElse();
  }
}

abstract class _AddStudyTime implements LearningEvent {
  const factory _AddStudyTime(
      {required final String userId,
      required final int studyTime,
      required final LessonType lessonType}) = _$AddStudyTimeImpl;

  String get userId;
  int get studyTime;
  LessonType get lessonType;

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddStudyTimeImplCopyWith<_$AddStudyTimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateDailyGoalImplCopyWith<$Res> {
  factory _$$UpdateDailyGoalImplCopyWith(_$UpdateDailyGoalImpl value,
          $Res Function(_$UpdateDailyGoalImpl) then) =
      __$$UpdateDailyGoalImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId, int goalMinutes});
}

/// @nodoc
class __$$UpdateDailyGoalImplCopyWithImpl<$Res>
    extends _$LearningEventCopyWithImpl<$Res, _$UpdateDailyGoalImpl>
    implements _$$UpdateDailyGoalImplCopyWith<$Res> {
  __$$UpdateDailyGoalImplCopyWithImpl(
      _$UpdateDailyGoalImpl _value, $Res Function(_$UpdateDailyGoalImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? goalMinutes = null,
  }) {
    return _then(_$UpdateDailyGoalImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      goalMinutes: null == goalMinutes
          ? _value.goalMinutes
          : goalMinutes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$UpdateDailyGoalImpl implements _UpdateDailyGoal {
  const _$UpdateDailyGoalImpl(
      {required this.userId, required this.goalMinutes});

  @override
  final String userId;
  @override
  final int goalMinutes;

  @override
  String toString() {
    return 'LearningEvent.updateDailyGoal(userId: $userId, goalMinutes: $goalMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateDailyGoalImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.goalMinutes, goalMinutes) ||
                other.goalMinutes == goalMinutes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, goalMinutes);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateDailyGoalImplCopyWith<_$UpdateDailyGoalImpl> get copyWith =>
      __$$UpdateDailyGoalImplCopyWithImpl<_$UpdateDailyGoalImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) {
    return updateDailyGoal(userId, goalMinutes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) {
    return updateDailyGoal?.call(userId, goalMinutes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) {
    if (updateDailyGoal != null) {
      return updateDailyGoal(userId, goalMinutes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) {
    return updateDailyGoal(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) {
    return updateDailyGoal?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) {
    if (updateDailyGoal != null) {
      return updateDailyGoal(this);
    }
    return orElse();
  }
}

abstract class _UpdateDailyGoal implements LearningEvent {
  const factory _UpdateDailyGoal(
      {required final String userId,
      required final int goalMinutes}) = _$UpdateDailyGoalImpl;

  String get userId;
  int get goalMinutes;

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateDailyGoalImplCopyWith<_$UpdateDailyGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshLearningDataImplCopyWith<$Res> {
  factory _$$RefreshLearningDataImplCopyWith(_$RefreshLearningDataImpl value,
          $Res Function(_$RefreshLearningDataImpl) then) =
      __$$RefreshLearningDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$RefreshLearningDataImplCopyWithImpl<$Res>
    extends _$LearningEventCopyWithImpl<$Res, _$RefreshLearningDataImpl>
    implements _$$RefreshLearningDataImplCopyWith<$Res> {
  __$$RefreshLearningDataImplCopyWithImpl(_$RefreshLearningDataImpl _value,
      $Res Function(_$RefreshLearningDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$RefreshLearningDataImpl(
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RefreshLearningDataImpl implements _RefreshLearningData {
  const _$RefreshLearningDataImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'LearningEvent.refreshLearningData(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshLearningDataImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshLearningDataImplCopyWith<_$RefreshLearningDataImpl> get copyWith =>
      __$$RefreshLearningDataImplCopyWithImpl<_$RefreshLearningDataImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) {
    return refreshLearningData(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) {
    return refreshLearningData?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) {
    if (refreshLearningData != null) {
      return refreshLearningData(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) {
    return refreshLearningData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) {
    return refreshLearningData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) {
    if (refreshLearningData != null) {
      return refreshLearningData(this);
    }
    return orElse();
  }
}

abstract class _RefreshLearningData implements LearningEvent {
  const factory _RefreshLearningData(final String userId) =
      _$RefreshLearningDataImpl;

  String get userId;

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshLearningDataImplCopyWith<_$RefreshLearningDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SyncToCloudImplCopyWith<$Res> {
  factory _$$SyncToCloudImplCopyWith(
          _$SyncToCloudImpl value, $Res Function(_$SyncToCloudImpl) then) =
      __$$SyncToCloudImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$SyncToCloudImplCopyWithImpl<$Res>
    extends _$LearningEventCopyWithImpl<$Res, _$SyncToCloudImpl>
    implements _$$SyncToCloudImplCopyWith<$Res> {
  __$$SyncToCloudImplCopyWithImpl(
      _$SyncToCloudImpl _value, $Res Function(_$SyncToCloudImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
  }) {
    return _then(_$SyncToCloudImpl(
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SyncToCloudImpl implements _SyncToCloud {
  const _$SyncToCloudImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'LearningEvent.syncToCloud(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncToCloudImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncToCloudImplCopyWith<_$SyncToCloudImpl> get copyWith =>
      __$$SyncToCloudImplCopyWithImpl<_$SyncToCloudImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) {
    return syncToCloud(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) {
    return syncToCloud?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) {
    if (syncToCloud != null) {
      return syncToCloud(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) {
    return syncToCloud(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) {
    return syncToCloud?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) {
    if (syncToCloud != null) {
      return syncToCloud(this);
    }
    return orElse();
  }
}

abstract class _SyncToCloud implements LearningEvent {
  const factory _SyncToCloud(final String userId) = _$SyncToCloudImpl;

  String get userId;

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncToCloudImplCopyWith<_$SyncToCloudImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadLessonDetailImplCopyWith<$Res> {
  factory _$$LoadLessonDetailImplCopyWith(_$LoadLessonDetailImpl value,
          $Res Function(_$LoadLessonDetailImpl) then) =
      __$$LoadLessonDetailImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String lessonId});
}

/// @nodoc
class __$$LoadLessonDetailImplCopyWithImpl<$Res>
    extends _$LearningEventCopyWithImpl<$Res, _$LoadLessonDetailImpl>
    implements _$$LoadLessonDetailImplCopyWith<$Res> {
  __$$LoadLessonDetailImplCopyWithImpl(_$LoadLessonDetailImpl _value,
      $Res Function(_$LoadLessonDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lessonId = null,
  }) {
    return _then(_$LoadLessonDetailImpl(
      null == lessonId
          ? _value.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadLessonDetailImpl implements _LoadLessonDetail {
  const _$LoadLessonDetailImpl(this.lessonId);

  @override
  final String lessonId;

  @override
  String toString() {
    return 'LearningEvent.loadLessonDetail(lessonId: $lessonId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadLessonDetailImpl &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lessonId);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadLessonDetailImplCopyWith<_$LoadLessonDetailImpl> get copyWith =>
      __$$LoadLessonDetailImplCopyWithImpl<_$LoadLessonDetailImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) {
    return loadLessonDetail(lessonId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) {
    return loadLessonDetail?.call(lessonId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) {
    if (loadLessonDetail != null) {
      return loadLessonDetail(lessonId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) {
    return loadLessonDetail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) {
    return loadLessonDetail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) {
    if (loadLessonDetail != null) {
      return loadLessonDetail(this);
    }
    return orElse();
  }
}

abstract class _LoadLessonDetail implements LearningEvent {
  const factory _LoadLessonDetail(final String lessonId) =
      _$LoadLessonDetailImpl;

  String get lessonId;

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadLessonDetailImplCopyWith<_$LoadLessonDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleLessonBookmarkImplCopyWith<$Res> {
  factory _$$ToggleLessonBookmarkImplCopyWith(_$ToggleLessonBookmarkImpl value,
          $Res Function(_$ToggleLessonBookmarkImpl) then) =
      __$$ToggleLessonBookmarkImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String lessonId});
}

/// @nodoc
class __$$ToggleLessonBookmarkImplCopyWithImpl<$Res>
    extends _$LearningEventCopyWithImpl<$Res, _$ToggleLessonBookmarkImpl>
    implements _$$ToggleLessonBookmarkImplCopyWith<$Res> {
  __$$ToggleLessonBookmarkImplCopyWithImpl(_$ToggleLessonBookmarkImpl _value,
      $Res Function(_$ToggleLessonBookmarkImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lessonId = null,
  }) {
    return _then(_$ToggleLessonBookmarkImpl(
      null == lessonId
          ? _value.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ToggleLessonBookmarkImpl implements _ToggleLessonBookmark {
  const _$ToggleLessonBookmarkImpl(this.lessonId);

  @override
  final String lessonId;

  @override
  String toString() {
    return 'LearningEvent.toggleLessonBookmark(lessonId: $lessonId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleLessonBookmarkImpl &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lessonId);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleLessonBookmarkImplCopyWith<_$ToggleLessonBookmarkImpl>
      get copyWith =>
          __$$ToggleLessonBookmarkImplCopyWithImpl<_$ToggleLessonBookmarkImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) {
    return toggleLessonBookmark(lessonId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) {
    return toggleLessonBookmark?.call(lessonId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) {
    if (toggleLessonBookmark != null) {
      return toggleLessonBookmark(lessonId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) {
    return toggleLessonBookmark(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) {
    return toggleLessonBookmark?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) {
    if (toggleLessonBookmark != null) {
      return toggleLessonBookmark(this);
    }
    return orElse();
  }
}

abstract class _ToggleLessonBookmark implements LearningEvent {
  const factory _ToggleLessonBookmark(final String lessonId) =
      _$ToggleLessonBookmarkImpl;

  String get lessonId;

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleLessonBookmarkImplCopyWith<_$ToggleLessonBookmarkImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetStateImplCopyWith<$Res> {
  factory _$$ResetStateImplCopyWith(
          _$ResetStateImpl value, $Res Function(_$ResetStateImpl) then) =
      __$$ResetStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetStateImplCopyWithImpl<$Res>
    extends _$LearningEventCopyWithImpl<$Res, _$ResetStateImpl>
    implements _$$ResetStateImplCopyWith<$Res> {
  __$$ResetStateImplCopyWithImpl(
      _$ResetStateImpl _value, $Res Function(_$ResetStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetStateImpl implements _ResetState {
  const _$ResetStateImpl();

  @override
  String toString() {
    return 'LearningEvent.resetState()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) {
    return resetState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) {
    return resetState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) {
    if (resetState != null) {
      return resetState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) {
    return resetState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) {
    return resetState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) {
    if (resetState != null) {
      return resetState(this);
    }
    return orElse();
  }
}

abstract class _ResetState implements LearningEvent {
  const factory _ResetState() = _$ResetStateImpl;
}

/// @nodoc
abstract class _$$ClearSearchResultsImplCopyWith<$Res> {
  factory _$$ClearSearchResultsImplCopyWith(_$ClearSearchResultsImpl value,
          $Res Function(_$ClearSearchResultsImpl) then) =
      __$$ClearSearchResultsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSearchResultsImplCopyWithImpl<$Res>
    extends _$LearningEventCopyWithImpl<$Res, _$ClearSearchResultsImpl>
    implements _$$ClearSearchResultsImplCopyWith<$Res> {
  __$$ClearSearchResultsImplCopyWithImpl(_$ClearSearchResultsImpl _value,
      $Res Function(_$ClearSearchResultsImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSearchResultsImpl implements _ClearSearchResults {
  const _$ClearSearchResultsImpl();

  @override
  String toString() {
    return 'LearningEvent.clearSearchResults()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearSearchResultsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) {
    return clearSearchResults();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) {
    return clearSearchResults?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) {
    if (clearSearchResults != null) {
      return clearSearchResults();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) {
    return clearSearchResults(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) {
    return clearSearchResults?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) {
    if (clearSearchResults != null) {
      return clearSearchResults(this);
    }
    return orElse();
  }
}

abstract class _ClearSearchResults implements LearningEvent {
  const factory _ClearSearchResults() = _$ClearSearchResultsImpl;
}

/// @nodoc
abstract class _$$LoadMoreLessonsImplCopyWith<$Res> {
  factory _$$LoadMoreLessonsImplCopyWith(_$LoadMoreLessonsImpl value,
          $Res Function(_$LoadMoreLessonsImpl) then) =
      __$$LoadMoreLessonsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int page,
      int limit,
      AgeGroup? ageGroup,
      DifficultyLevel? difficulty,
      LessonType? type});
}

/// @nodoc
class __$$LoadMoreLessonsImplCopyWithImpl<$Res>
    extends _$LearningEventCopyWithImpl<$Res, _$LoadMoreLessonsImpl>
    implements _$$LoadMoreLessonsImplCopyWith<$Res> {
  __$$LoadMoreLessonsImplCopyWithImpl(
      _$LoadMoreLessonsImpl _value, $Res Function(_$LoadMoreLessonsImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limit = null,
    Object? ageGroup = freezed,
    Object? difficulty = freezed,
    Object? type = freezed,
  }) {
    return _then(_$LoadMoreLessonsImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as AgeGroup?,
      difficulty: freezed == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LessonType?,
    ));
  }
}

/// @nodoc

class _$LoadMoreLessonsImpl implements _LoadMoreLessons {
  const _$LoadMoreLessonsImpl(
      {required this.page,
      required this.limit,
      this.ageGroup,
      this.difficulty,
      this.type});

  @override
  final int page;
  @override
  final int limit;
  @override
  final AgeGroup? ageGroup;
  @override
  final DifficultyLevel? difficulty;
  @override
  final LessonType? type;

  @override
  String toString() {
    return 'LearningEvent.loadMoreLessons(page: $page, limit: $limit, ageGroup: $ageGroup, difficulty: $difficulty, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMoreLessonsImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, page, limit, ageGroup, difficulty, type);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadMoreLessonsImplCopyWith<_$LoadMoreLessonsImpl> get copyWith =>
      __$$LoadMoreLessonsImplCopyWithImpl<_$LoadMoreLessonsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) {
    return loadMoreLessons(page, limit, ageGroup, difficulty, type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) {
    return loadMoreLessons?.call(page, limit, ageGroup, difficulty, type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) {
    if (loadMoreLessons != null) {
      return loadMoreLessons(page, limit, ageGroup, difficulty, type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) {
    return loadMoreLessons(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) {
    return loadMoreLessons?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) {
    if (loadMoreLessons != null) {
      return loadMoreLessons(this);
    }
    return orElse();
  }
}

abstract class _LoadMoreLessons implements LearningEvent {
  const factory _LoadMoreLessons(
      {required final int page,
      required final int limit,
      final AgeGroup? ageGroup,
      final DifficultyLevel? difficulty,
      final LessonType? type}) = _$LoadMoreLessonsImpl;

  int get page;
  int get limit;
  AgeGroup? get ageGroup;
  DifficultyLevel? get difficulty;
  LessonType? get type;

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadMoreLessonsImplCopyWith<_$LoadMoreLessonsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FilterLessonsImplCopyWith<$Res> {
  factory _$$FilterLessonsImplCopyWith(
          _$FilterLessonsImpl value, $Res Function(_$FilterLessonsImpl) then) =
      __$$FilterLessonsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {AgeGroup? ageGroup,
      DifficultyLevel? difficulty,
      LessonType? type,
      bool? isCompleted,
      bool? isBookmarked});
}

/// @nodoc
class __$$FilterLessonsImplCopyWithImpl<$Res>
    extends _$LearningEventCopyWithImpl<$Res, _$FilterLessonsImpl>
    implements _$$FilterLessonsImplCopyWith<$Res> {
  __$$FilterLessonsImplCopyWithImpl(
      _$FilterLessonsImpl _value, $Res Function(_$FilterLessonsImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ageGroup = freezed,
    Object? difficulty = freezed,
    Object? type = freezed,
    Object? isCompleted = freezed,
    Object? isBookmarked = freezed,
  }) {
    return _then(_$FilterLessonsImpl(
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as AgeGroup?,
      difficulty: freezed == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LessonType?,
      isCompleted: freezed == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      isBookmarked: freezed == isBookmarked
          ? _value.isBookmarked
          : isBookmarked // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$FilterLessonsImpl implements _FilterLessons {
  const _$FilterLessonsImpl(
      {this.ageGroup,
      this.difficulty,
      this.type,
      this.isCompleted,
      this.isBookmarked});

  @override
  final AgeGroup? ageGroup;
  @override
  final DifficultyLevel? difficulty;
  @override
  final LessonType? type;
  @override
  final bool? isCompleted;
  @override
  final bool? isBookmarked;

  @override
  String toString() {
    return 'LearningEvent.filterLessons(ageGroup: $ageGroup, difficulty: $difficulty, type: $type, isCompleted: $isCompleted, isBookmarked: $isBookmarked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterLessonsImpl &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, ageGroup, difficulty, type, isCompleted, isBookmarked);

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterLessonsImplCopyWith<_$FilterLessonsImpl> get copyWith =>
      __$$FilterLessonsImplCopyWithImpl<_$FilterLessonsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadLearningProgress,
    required TResult Function(GetLessonsParams params) loadLessons,
    required TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        searchLessons,
    required TResult Function(UpdateProgressParams params) updateLessonProgress,
    required TResult Function(
            String userId, String lessonId, int score, int studyTime)
        completeLesson,
    required TResult Function(
            String userId, int studyTime, LessonType lessonType)
        addStudyTime,
    required TResult Function(String userId, int goalMinutes) updateDailyGoal,
    required TResult Function(String userId) refreshLearningData,
    required TResult Function(String userId) syncToCloud,
    required TResult Function(String lessonId) loadLessonDetail,
    required TResult Function(String lessonId) toggleLessonBookmark,
    required TResult Function() resetState,
    required TResult Function() clearSearchResults,
    required TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)
        loadMoreLessons,
    required TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)
        filterLessons,
  }) {
    return filterLessons(ageGroup, difficulty, type, isCompleted, isBookmarked);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadLearningProgress,
    TResult? Function(GetLessonsParams params)? loadLessons,
    TResult? Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult? Function(UpdateProgressParams params)? updateLessonProgress,
    TResult? Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult? Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult? Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult? Function(String userId)? refreshLearningData,
    TResult? Function(String userId)? syncToCloud,
    TResult? Function(String lessonId)? loadLessonDetail,
    TResult? Function(String lessonId)? toggleLessonBookmark,
    TResult? Function()? resetState,
    TResult? Function()? clearSearchResults,
    TResult? Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult? Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
  }) {
    return filterLessons?.call(
        ageGroup, difficulty, type, isCompleted, isBookmarked);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadLearningProgress,
    TResult Function(GetLessonsParams params)? loadLessons,
    TResult Function(String query, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        searchLessons,
    TResult Function(UpdateProgressParams params)? updateLessonProgress,
    TResult Function(String userId, String lessonId, int score, int studyTime)?
        completeLesson,
    TResult Function(String userId, int studyTime, LessonType lessonType)?
        addStudyTime,
    TResult Function(String userId, int goalMinutes)? updateDailyGoal,
    TResult Function(String userId)? refreshLearningData,
    TResult Function(String userId)? syncToCloud,
    TResult Function(String lessonId)? loadLessonDetail,
    TResult Function(String lessonId)? toggleLessonBookmark,
    TResult Function()? resetState,
    TResult Function()? clearSearchResults,
    TResult Function(int page, int limit, AgeGroup? ageGroup,
            DifficultyLevel? difficulty, LessonType? type)?
        loadMoreLessons,
    TResult Function(AgeGroup? ageGroup, DifficultyLevel? difficulty,
            LessonType? type, bool? isCompleted, bool? isBookmarked)?
        filterLessons,
    required TResult orElse(),
  }) {
    if (filterLessons != null) {
      return filterLessons(
          ageGroup, difficulty, type, isCompleted, isBookmarked);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadLearningProgress value) loadLearningProgress,
    required TResult Function(_LoadLessons value) loadLessons,
    required TResult Function(_SearchLessons value) searchLessons,
    required TResult Function(_UpdateLessonProgress value) updateLessonProgress,
    required TResult Function(_CompleteLesson value) completeLesson,
    required TResult Function(_AddStudyTime value) addStudyTime,
    required TResult Function(_UpdateDailyGoal value) updateDailyGoal,
    required TResult Function(_RefreshLearningData value) refreshLearningData,
    required TResult Function(_SyncToCloud value) syncToCloud,
    required TResult Function(_LoadLessonDetail value) loadLessonDetail,
    required TResult Function(_ToggleLessonBookmark value) toggleLessonBookmark,
    required TResult Function(_ResetState value) resetState,
    required TResult Function(_ClearSearchResults value) clearSearchResults,
    required TResult Function(_LoadMoreLessons value) loadMoreLessons,
    required TResult Function(_FilterLessons value) filterLessons,
  }) {
    return filterLessons(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult? Function(_LoadLessons value)? loadLessons,
    TResult? Function(_SearchLessons value)? searchLessons,
    TResult? Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult? Function(_CompleteLesson value)? completeLesson,
    TResult? Function(_AddStudyTime value)? addStudyTime,
    TResult? Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult? Function(_RefreshLearningData value)? refreshLearningData,
    TResult? Function(_SyncToCloud value)? syncToCloud,
    TResult? Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult? Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult? Function(_ResetState value)? resetState,
    TResult? Function(_ClearSearchResults value)? clearSearchResults,
    TResult? Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult? Function(_FilterLessons value)? filterLessons,
  }) {
    return filterLessons?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadLearningProgress value)? loadLearningProgress,
    TResult Function(_LoadLessons value)? loadLessons,
    TResult Function(_SearchLessons value)? searchLessons,
    TResult Function(_UpdateLessonProgress value)? updateLessonProgress,
    TResult Function(_CompleteLesson value)? completeLesson,
    TResult Function(_AddStudyTime value)? addStudyTime,
    TResult Function(_UpdateDailyGoal value)? updateDailyGoal,
    TResult Function(_RefreshLearningData value)? refreshLearningData,
    TResult Function(_SyncToCloud value)? syncToCloud,
    TResult Function(_LoadLessonDetail value)? loadLessonDetail,
    TResult Function(_ToggleLessonBookmark value)? toggleLessonBookmark,
    TResult Function(_ResetState value)? resetState,
    TResult Function(_ClearSearchResults value)? clearSearchResults,
    TResult Function(_LoadMoreLessons value)? loadMoreLessons,
    TResult Function(_FilterLessons value)? filterLessons,
    required TResult orElse(),
  }) {
    if (filterLessons != null) {
      return filterLessons(this);
    }
    return orElse();
  }
}

abstract class _FilterLessons implements LearningEvent {
  const factory _FilterLessons(
      {final AgeGroup? ageGroup,
      final DifficultyLevel? difficulty,
      final LessonType? type,
      final bool? isCompleted,
      final bool? isBookmarked}) = _$FilterLessonsImpl;

  AgeGroup? get ageGroup;
  DifficultyLevel? get difficulty;
  LessonType? get type;
  bool? get isCompleted;
  bool? get isBookmarked;

  /// Create a copy of LearningEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterLessonsImplCopyWith<_$FilterLessonsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
