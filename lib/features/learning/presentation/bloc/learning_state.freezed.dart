// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learning_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LearningState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)
        loaded,
    required TResult Function(Failure failure) error,
    required TResult Function(String message, Map<String, dynamic>? data)
        operationSuccess,
    required TResult Function(
            List<LessonEntity> searchResults, String searchQuery)
        searchSuccess,
    required TResult Function(String lessonId) lessonDetailLoading,
    required TResult Function(LessonEntity lesson, bool isBookmarked)
        lessonDetailLoaded,
    required TResult Function(LearningProgressEntity progress, String message)
        progressUpdated,
    required TResult Function() syncing,
    required TResult Function(String message) syncCompleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult? Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult? Function(String lessonId)? lessonDetailLoading,
    TResult? Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult? Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult? Function()? syncing,
    TResult? Function(String message)? syncCompleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult Function(Failure failure)? error,
    TResult Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult Function(String lessonId)? lessonDetailLoading,
    TResult Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult Function()? syncing,
    TResult Function(String message)? syncCompleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OperationSuccess value) operationSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_LessonDetailLoading value) lessonDetailLoading,
    required TResult Function(_LessonDetailLoaded value) lessonDetailLoaded,
    required TResult Function(_ProgressUpdated value) progressUpdated,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_SyncCompleted value) syncCompleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OperationSuccess value)? operationSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult? Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult? Function(_ProgressUpdated value)? progressUpdated,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_SyncCompleted value)? syncCompleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OperationSuccess value)? operationSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult Function(_ProgressUpdated value)? progressUpdated,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_SyncCompleted value)? syncCompleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LearningStateCopyWith<$Res> {
  factory $LearningStateCopyWith(
          LearningState value, $Res Function(LearningState) then) =
      _$LearningStateCopyWithImpl<$Res, LearningState>;
}

/// @nodoc
class _$LearningStateCopyWithImpl<$Res, $Val extends LearningState>
    implements $LearningStateCopyWith<$Res> {
  _$LearningStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$LearningStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'LearningState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)
        loaded,
    required TResult Function(Failure failure) error,
    required TResult Function(String message, Map<String, dynamic>? data)
        operationSuccess,
    required TResult Function(
            List<LessonEntity> searchResults, String searchQuery)
        searchSuccess,
    required TResult Function(String lessonId) lessonDetailLoading,
    required TResult Function(LessonEntity lesson, bool isBookmarked)
        lessonDetailLoaded,
    required TResult Function(LearningProgressEntity progress, String message)
        progressUpdated,
    required TResult Function() syncing,
    required TResult Function(String message) syncCompleted,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult? Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult? Function(String lessonId)? lessonDetailLoading,
    TResult? Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult? Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult? Function()? syncing,
    TResult? Function(String message)? syncCompleted,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult Function(Failure failure)? error,
    TResult Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult Function(String lessonId)? lessonDetailLoading,
    TResult Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult Function()? syncing,
    TResult Function(String message)? syncCompleted,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OperationSuccess value) operationSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_LessonDetailLoading value) lessonDetailLoading,
    required TResult Function(_LessonDetailLoaded value) lessonDetailLoaded,
    required TResult Function(_ProgressUpdated value) progressUpdated,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_SyncCompleted value) syncCompleted,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OperationSuccess value)? operationSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult? Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult? Function(_ProgressUpdated value)? progressUpdated,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_SyncCompleted value)? syncCompleted,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OperationSuccess value)? operationSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult Function(_ProgressUpdated value)? progressUpdated,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_SyncCompleted value)? syncCompleted,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements LearningState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$LearningStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$LoadingImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'LearningState.loading(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)
        loaded,
    required TResult Function(Failure failure) error,
    required TResult Function(String message, Map<String, dynamic>? data)
        operationSuccess,
    required TResult Function(
            List<LessonEntity> searchResults, String searchQuery)
        searchSuccess,
    required TResult Function(String lessonId) lessonDetailLoading,
    required TResult Function(LessonEntity lesson, bool isBookmarked)
        lessonDetailLoaded,
    required TResult Function(LearningProgressEntity progress, String message)
        progressUpdated,
    required TResult Function() syncing,
    required TResult Function(String message) syncCompleted,
  }) {
    return loading(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult? Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult? Function(String lessonId)? lessonDetailLoading,
    TResult? Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult? Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult? Function()? syncing,
    TResult? Function(String message)? syncCompleted,
  }) {
    return loading?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult Function(Failure failure)? error,
    TResult Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult Function(String lessonId)? lessonDetailLoading,
    TResult Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult Function()? syncing,
    TResult Function(String message)? syncCompleted,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OperationSuccess value) operationSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_LessonDetailLoading value) lessonDetailLoading,
    required TResult Function(_LessonDetailLoaded value) lessonDetailLoaded,
    required TResult Function(_ProgressUpdated value) progressUpdated,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_SyncCompleted value) syncCompleted,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OperationSuccess value)? operationSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult? Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult? Function(_ProgressUpdated value)? progressUpdated,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_SyncCompleted value)? syncCompleted,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OperationSuccess value)? operationSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult Function(_ProgressUpdated value)? progressUpdated,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_SyncCompleted value)? syncCompleted,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements LearningState {
  const factory _Loading({final String? message}) = _$LoadingImpl;

  String? get message;

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {LearningProgressEntity progress,
      List<LessonEntity> lessons,
      List<LessonEntity> searchResults,
      bool isSearching,
      String? searchQuery,
      Map<String, dynamic>? completionResult});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$LearningStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? lessons = null,
    Object? searchResults = null,
    Object? isSearching = null,
    Object? searchQuery = freezed,
    Object? completionResult = freezed,
  }) {
    return _then(_$LoadedImpl(
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as LearningProgressEntity,
      lessons: null == lessons
          ? _value._lessons
          : lessons // ignore: cast_nullable_to_non_nullable
              as List<LessonEntity>,
      searchResults: null == searchResults
          ? _value._searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as List<LessonEntity>,
      isSearching: null == isSearching
          ? _value.isSearching
          : isSearching // ignore: cast_nullable_to_non_nullable
              as bool,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      completionResult: freezed == completionResult
          ? _value._completionResult
          : completionResult // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required this.progress,
      required final List<LessonEntity> lessons,
      final List<LessonEntity> searchResults = const [],
      this.isSearching = false,
      this.searchQuery,
      final Map<String, dynamic>? completionResult})
      : _lessons = lessons,
        _searchResults = searchResults,
        _completionResult = completionResult;

  @override
  final LearningProgressEntity progress;
  final List<LessonEntity> _lessons;
  @override
  List<LessonEntity> get lessons {
    if (_lessons is EqualUnmodifiableListView) return _lessons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lessons);
  }

  final List<LessonEntity> _searchResults;
  @override
  @JsonKey()
  List<LessonEntity> get searchResults {
    if (_searchResults is EqualUnmodifiableListView) return _searchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchResults);
  }

  @override
  @JsonKey()
  final bool isSearching;
  @override
  final String? searchQuery;
  final Map<String, dynamic>? _completionResult;
  @override
  Map<String, dynamic>? get completionResult {
    final value = _completionResult;
    if (value == null) return null;
    if (_completionResult is EqualUnmodifiableMapView) return _completionResult;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'LearningState.loaded(progress: $progress, lessons: $lessons, searchResults: $searchResults, isSearching: $isSearching, searchQuery: $searchQuery, completionResult: $completionResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            const DeepCollectionEquality().equals(other._lessons, _lessons) &&
            const DeepCollectionEquality()
                .equals(other._searchResults, _searchResults) &&
            (identical(other.isSearching, isSearching) ||
                other.isSearching == isSearching) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            const DeepCollectionEquality()
                .equals(other._completionResult, _completionResult));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      progress,
      const DeepCollectionEquality().hash(_lessons),
      const DeepCollectionEquality().hash(_searchResults),
      isSearching,
      searchQuery,
      const DeepCollectionEquality().hash(_completionResult));

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)
        loaded,
    required TResult Function(Failure failure) error,
    required TResult Function(String message, Map<String, dynamic>? data)
        operationSuccess,
    required TResult Function(
            List<LessonEntity> searchResults, String searchQuery)
        searchSuccess,
    required TResult Function(String lessonId) lessonDetailLoading,
    required TResult Function(LessonEntity lesson, bool isBookmarked)
        lessonDetailLoaded,
    required TResult Function(LearningProgressEntity progress, String message)
        progressUpdated,
    required TResult Function() syncing,
    required TResult Function(String message) syncCompleted,
  }) {
    return loaded(progress, lessons, searchResults, isSearching, searchQuery,
        completionResult);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult? Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult? Function(String lessonId)? lessonDetailLoading,
    TResult? Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult? Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult? Function()? syncing,
    TResult? Function(String message)? syncCompleted,
  }) {
    return loaded?.call(progress, lessons, searchResults, isSearching,
        searchQuery, completionResult);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult Function(Failure failure)? error,
    TResult Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult Function(String lessonId)? lessonDetailLoading,
    TResult Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult Function()? syncing,
    TResult Function(String message)? syncCompleted,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(progress, lessons, searchResults, isSearching, searchQuery,
          completionResult);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OperationSuccess value) operationSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_LessonDetailLoading value) lessonDetailLoading,
    required TResult Function(_LessonDetailLoaded value) lessonDetailLoaded,
    required TResult Function(_ProgressUpdated value) progressUpdated,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_SyncCompleted value) syncCompleted,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OperationSuccess value)? operationSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult? Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult? Function(_ProgressUpdated value)? progressUpdated,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_SyncCompleted value)? syncCompleted,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OperationSuccess value)? operationSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult Function(_ProgressUpdated value)? progressUpdated,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_SyncCompleted value)? syncCompleted,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements LearningState {
  const factory _Loaded(
      {required final LearningProgressEntity progress,
      required final List<LessonEntity> lessons,
      final List<LessonEntity> searchResults,
      final bool isSearching,
      final String? searchQuery,
      final Map<String, dynamic>? completionResult}) = _$LoadedImpl;

  LearningProgressEntity get progress;
  List<LessonEntity> get lessons;
  List<LessonEntity> get searchResults;
  bool get isSearching;
  String? get searchQuery;
  Map<String, dynamic>? get completionResult;

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$LearningStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$ErrorImpl(
      null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.failure);

  @override
  final Failure failure;

  @override
  String toString() {
    return 'LearningState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)
        loaded,
    required TResult Function(Failure failure) error,
    required TResult Function(String message, Map<String, dynamic>? data)
        operationSuccess,
    required TResult Function(
            List<LessonEntity> searchResults, String searchQuery)
        searchSuccess,
    required TResult Function(String lessonId) lessonDetailLoading,
    required TResult Function(LessonEntity lesson, bool isBookmarked)
        lessonDetailLoaded,
    required TResult Function(LearningProgressEntity progress, String message)
        progressUpdated,
    required TResult Function() syncing,
    required TResult Function(String message) syncCompleted,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult? Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult? Function(String lessonId)? lessonDetailLoading,
    TResult? Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult? Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult? Function()? syncing,
    TResult? Function(String message)? syncCompleted,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult Function(Failure failure)? error,
    TResult Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult Function(String lessonId)? lessonDetailLoading,
    TResult Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult Function()? syncing,
    TResult Function(String message)? syncCompleted,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OperationSuccess value) operationSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_LessonDetailLoading value) lessonDetailLoading,
    required TResult Function(_LessonDetailLoaded value) lessonDetailLoaded,
    required TResult Function(_ProgressUpdated value) progressUpdated,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_SyncCompleted value) syncCompleted,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OperationSuccess value)? operationSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult? Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult? Function(_ProgressUpdated value)? progressUpdated,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_SyncCompleted value)? syncCompleted,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OperationSuccess value)? operationSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult Function(_ProgressUpdated value)? progressUpdated,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_SyncCompleted value)? syncCompleted,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements LearningState {
  const factory _Error(final Failure failure) = _$ErrorImpl;

  Failure get failure;

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OperationSuccessImplCopyWith<$Res> {
  factory _$$OperationSuccessImplCopyWith(_$OperationSuccessImpl value,
          $Res Function(_$OperationSuccessImpl) then) =
      __$$OperationSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, Map<String, dynamic>? data});
}

/// @nodoc
class __$$OperationSuccessImplCopyWithImpl<$Res>
    extends _$LearningStateCopyWithImpl<$Res, _$OperationSuccessImpl>
    implements _$$OperationSuccessImplCopyWith<$Res> {
  __$$OperationSuccessImplCopyWithImpl(_$OperationSuccessImpl _value,
      $Res Function(_$OperationSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$OperationSuccessImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$OperationSuccessImpl implements _OperationSuccess {
  const _$OperationSuccessImpl(
      {required this.message, final Map<String, dynamic>? data})
      : _data = data;

  @override
  final String message;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'LearningState.operationSuccess(message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OperationSuccessImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(_data));

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OperationSuccessImplCopyWith<_$OperationSuccessImpl> get copyWith =>
      __$$OperationSuccessImplCopyWithImpl<_$OperationSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)
        loaded,
    required TResult Function(Failure failure) error,
    required TResult Function(String message, Map<String, dynamic>? data)
        operationSuccess,
    required TResult Function(
            List<LessonEntity> searchResults, String searchQuery)
        searchSuccess,
    required TResult Function(String lessonId) lessonDetailLoading,
    required TResult Function(LessonEntity lesson, bool isBookmarked)
        lessonDetailLoaded,
    required TResult Function(LearningProgressEntity progress, String message)
        progressUpdated,
    required TResult Function() syncing,
    required TResult Function(String message) syncCompleted,
  }) {
    return operationSuccess(message, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult? Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult? Function(String lessonId)? lessonDetailLoading,
    TResult? Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult? Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult? Function()? syncing,
    TResult? Function(String message)? syncCompleted,
  }) {
    return operationSuccess?.call(message, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult Function(Failure failure)? error,
    TResult Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult Function(String lessonId)? lessonDetailLoading,
    TResult Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult Function()? syncing,
    TResult Function(String message)? syncCompleted,
    required TResult orElse(),
  }) {
    if (operationSuccess != null) {
      return operationSuccess(message, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OperationSuccess value) operationSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_LessonDetailLoading value) lessonDetailLoading,
    required TResult Function(_LessonDetailLoaded value) lessonDetailLoaded,
    required TResult Function(_ProgressUpdated value) progressUpdated,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_SyncCompleted value) syncCompleted,
  }) {
    return operationSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OperationSuccess value)? operationSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult? Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult? Function(_ProgressUpdated value)? progressUpdated,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_SyncCompleted value)? syncCompleted,
  }) {
    return operationSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OperationSuccess value)? operationSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult Function(_ProgressUpdated value)? progressUpdated,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_SyncCompleted value)? syncCompleted,
    required TResult orElse(),
  }) {
    if (operationSuccess != null) {
      return operationSuccess(this);
    }
    return orElse();
  }
}

abstract class _OperationSuccess implements LearningState {
  const factory _OperationSuccess(
      {required final String message,
      final Map<String, dynamic>? data}) = _$OperationSuccessImpl;

  String get message;
  Map<String, dynamic>? get data;

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OperationSuccessImplCopyWith<_$OperationSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchSuccessImplCopyWith<$Res> {
  factory _$$SearchSuccessImplCopyWith(
          _$SearchSuccessImpl value, $Res Function(_$SearchSuccessImpl) then) =
      __$$SearchSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<LessonEntity> searchResults, String searchQuery});
}

/// @nodoc
class __$$SearchSuccessImplCopyWithImpl<$Res>
    extends _$LearningStateCopyWithImpl<$Res, _$SearchSuccessImpl>
    implements _$$SearchSuccessImplCopyWith<$Res> {
  __$$SearchSuccessImplCopyWithImpl(
      _$SearchSuccessImpl _value, $Res Function(_$SearchSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchResults = null,
    Object? searchQuery = null,
  }) {
    return _then(_$SearchSuccessImpl(
      searchResults: null == searchResults
          ? _value._searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as List<LessonEntity>,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchSuccessImpl implements _SearchSuccess {
  const _$SearchSuccessImpl(
      {required final List<LessonEntity> searchResults,
      required this.searchQuery})
      : _searchResults = searchResults;

  final List<LessonEntity> _searchResults;
  @override
  List<LessonEntity> get searchResults {
    if (_searchResults is EqualUnmodifiableListView) return _searchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchResults);
  }

  @override
  final String searchQuery;

  @override
  String toString() {
    return 'LearningState.searchSuccess(searchResults: $searchResults, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchSuccessImpl &&
            const DeepCollectionEquality()
                .equals(other._searchResults, _searchResults) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_searchResults), searchQuery);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchSuccessImplCopyWith<_$SearchSuccessImpl> get copyWith =>
      __$$SearchSuccessImplCopyWithImpl<_$SearchSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)
        loaded,
    required TResult Function(Failure failure) error,
    required TResult Function(String message, Map<String, dynamic>? data)
        operationSuccess,
    required TResult Function(
            List<LessonEntity> searchResults, String searchQuery)
        searchSuccess,
    required TResult Function(String lessonId) lessonDetailLoading,
    required TResult Function(LessonEntity lesson, bool isBookmarked)
        lessonDetailLoaded,
    required TResult Function(LearningProgressEntity progress, String message)
        progressUpdated,
    required TResult Function() syncing,
    required TResult Function(String message) syncCompleted,
  }) {
    return searchSuccess(searchResults, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult? Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult? Function(String lessonId)? lessonDetailLoading,
    TResult? Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult? Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult? Function()? syncing,
    TResult? Function(String message)? syncCompleted,
  }) {
    return searchSuccess?.call(searchResults, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult Function(Failure failure)? error,
    TResult Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult Function(String lessonId)? lessonDetailLoading,
    TResult Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult Function()? syncing,
    TResult Function(String message)? syncCompleted,
    required TResult orElse(),
  }) {
    if (searchSuccess != null) {
      return searchSuccess(searchResults, searchQuery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OperationSuccess value) operationSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_LessonDetailLoading value) lessonDetailLoading,
    required TResult Function(_LessonDetailLoaded value) lessonDetailLoaded,
    required TResult Function(_ProgressUpdated value) progressUpdated,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_SyncCompleted value) syncCompleted,
  }) {
    return searchSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OperationSuccess value)? operationSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult? Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult? Function(_ProgressUpdated value)? progressUpdated,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_SyncCompleted value)? syncCompleted,
  }) {
    return searchSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OperationSuccess value)? operationSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult Function(_ProgressUpdated value)? progressUpdated,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_SyncCompleted value)? syncCompleted,
    required TResult orElse(),
  }) {
    if (searchSuccess != null) {
      return searchSuccess(this);
    }
    return orElse();
  }
}

abstract class _SearchSuccess implements LearningState {
  const factory _SearchSuccess(
      {required final List<LessonEntity> searchResults,
      required final String searchQuery}) = _$SearchSuccessImpl;

  List<LessonEntity> get searchResults;
  String get searchQuery;

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchSuccessImplCopyWith<_$SearchSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LessonDetailLoadingImplCopyWith<$Res> {
  factory _$$LessonDetailLoadingImplCopyWith(_$LessonDetailLoadingImpl value,
          $Res Function(_$LessonDetailLoadingImpl) then) =
      __$$LessonDetailLoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String lessonId});
}

/// @nodoc
class __$$LessonDetailLoadingImplCopyWithImpl<$Res>
    extends _$LearningStateCopyWithImpl<$Res, _$LessonDetailLoadingImpl>
    implements _$$LessonDetailLoadingImplCopyWith<$Res> {
  __$$LessonDetailLoadingImplCopyWithImpl(_$LessonDetailLoadingImpl _value,
      $Res Function(_$LessonDetailLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lessonId = null,
  }) {
    return _then(_$LessonDetailLoadingImpl(
      null == lessonId
          ? _value.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LessonDetailLoadingImpl implements _LessonDetailLoading {
  const _$LessonDetailLoadingImpl(this.lessonId);

  @override
  final String lessonId;

  @override
  String toString() {
    return 'LearningState.lessonDetailLoading(lessonId: $lessonId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonDetailLoadingImpl &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lessonId);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonDetailLoadingImplCopyWith<_$LessonDetailLoadingImpl> get copyWith =>
      __$$LessonDetailLoadingImplCopyWithImpl<_$LessonDetailLoadingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)
        loaded,
    required TResult Function(Failure failure) error,
    required TResult Function(String message, Map<String, dynamic>? data)
        operationSuccess,
    required TResult Function(
            List<LessonEntity> searchResults, String searchQuery)
        searchSuccess,
    required TResult Function(String lessonId) lessonDetailLoading,
    required TResult Function(LessonEntity lesson, bool isBookmarked)
        lessonDetailLoaded,
    required TResult Function(LearningProgressEntity progress, String message)
        progressUpdated,
    required TResult Function() syncing,
    required TResult Function(String message) syncCompleted,
  }) {
    return lessonDetailLoading(lessonId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult? Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult? Function(String lessonId)? lessonDetailLoading,
    TResult? Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult? Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult? Function()? syncing,
    TResult? Function(String message)? syncCompleted,
  }) {
    return lessonDetailLoading?.call(lessonId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult Function(Failure failure)? error,
    TResult Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult Function(String lessonId)? lessonDetailLoading,
    TResult Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult Function()? syncing,
    TResult Function(String message)? syncCompleted,
    required TResult orElse(),
  }) {
    if (lessonDetailLoading != null) {
      return lessonDetailLoading(lessonId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OperationSuccess value) operationSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_LessonDetailLoading value) lessonDetailLoading,
    required TResult Function(_LessonDetailLoaded value) lessonDetailLoaded,
    required TResult Function(_ProgressUpdated value) progressUpdated,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_SyncCompleted value) syncCompleted,
  }) {
    return lessonDetailLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OperationSuccess value)? operationSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult? Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult? Function(_ProgressUpdated value)? progressUpdated,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_SyncCompleted value)? syncCompleted,
  }) {
    return lessonDetailLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OperationSuccess value)? operationSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult Function(_ProgressUpdated value)? progressUpdated,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_SyncCompleted value)? syncCompleted,
    required TResult orElse(),
  }) {
    if (lessonDetailLoading != null) {
      return lessonDetailLoading(this);
    }
    return orElse();
  }
}

abstract class _LessonDetailLoading implements LearningState {
  const factory _LessonDetailLoading(final String lessonId) =
      _$LessonDetailLoadingImpl;

  String get lessonId;

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonDetailLoadingImplCopyWith<_$LessonDetailLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LessonDetailLoadedImplCopyWith<$Res> {
  factory _$$LessonDetailLoadedImplCopyWith(_$LessonDetailLoadedImpl value,
          $Res Function(_$LessonDetailLoadedImpl) then) =
      __$$LessonDetailLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LessonEntity lesson, bool isBookmarked});
}

/// @nodoc
class __$$LessonDetailLoadedImplCopyWithImpl<$Res>
    extends _$LearningStateCopyWithImpl<$Res, _$LessonDetailLoadedImpl>
    implements _$$LessonDetailLoadedImplCopyWith<$Res> {
  __$$LessonDetailLoadedImplCopyWithImpl(_$LessonDetailLoadedImpl _value,
      $Res Function(_$LessonDetailLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lesson = null,
    Object? isBookmarked = null,
  }) {
    return _then(_$LessonDetailLoadedImpl(
      lesson: null == lesson
          ? _value.lesson
          : lesson // ignore: cast_nullable_to_non_nullable
              as LessonEntity,
      isBookmarked: null == isBookmarked
          ? _value.isBookmarked
          : isBookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LessonDetailLoadedImpl implements _LessonDetailLoaded {
  const _$LessonDetailLoadedImpl(
      {required this.lesson, required this.isBookmarked});

  @override
  final LessonEntity lesson;
  @override
  final bool isBookmarked;

  @override
  String toString() {
    return 'LearningState.lessonDetailLoaded(lesson: $lesson, isBookmarked: $isBookmarked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonDetailLoadedImpl &&
            (identical(other.lesson, lesson) || other.lesson == lesson) &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lesson, isBookmarked);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonDetailLoadedImplCopyWith<_$LessonDetailLoadedImpl> get copyWith =>
      __$$LessonDetailLoadedImplCopyWithImpl<_$LessonDetailLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)
        loaded,
    required TResult Function(Failure failure) error,
    required TResult Function(String message, Map<String, dynamic>? data)
        operationSuccess,
    required TResult Function(
            List<LessonEntity> searchResults, String searchQuery)
        searchSuccess,
    required TResult Function(String lessonId) lessonDetailLoading,
    required TResult Function(LessonEntity lesson, bool isBookmarked)
        lessonDetailLoaded,
    required TResult Function(LearningProgressEntity progress, String message)
        progressUpdated,
    required TResult Function() syncing,
    required TResult Function(String message) syncCompleted,
  }) {
    return lessonDetailLoaded(lesson, isBookmarked);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult? Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult? Function(String lessonId)? lessonDetailLoading,
    TResult? Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult? Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult? Function()? syncing,
    TResult? Function(String message)? syncCompleted,
  }) {
    return lessonDetailLoaded?.call(lesson, isBookmarked);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult Function(Failure failure)? error,
    TResult Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult Function(String lessonId)? lessonDetailLoading,
    TResult Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult Function()? syncing,
    TResult Function(String message)? syncCompleted,
    required TResult orElse(),
  }) {
    if (lessonDetailLoaded != null) {
      return lessonDetailLoaded(lesson, isBookmarked);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OperationSuccess value) operationSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_LessonDetailLoading value) lessonDetailLoading,
    required TResult Function(_LessonDetailLoaded value) lessonDetailLoaded,
    required TResult Function(_ProgressUpdated value) progressUpdated,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_SyncCompleted value) syncCompleted,
  }) {
    return lessonDetailLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OperationSuccess value)? operationSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult? Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult? Function(_ProgressUpdated value)? progressUpdated,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_SyncCompleted value)? syncCompleted,
  }) {
    return lessonDetailLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OperationSuccess value)? operationSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult Function(_ProgressUpdated value)? progressUpdated,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_SyncCompleted value)? syncCompleted,
    required TResult orElse(),
  }) {
    if (lessonDetailLoaded != null) {
      return lessonDetailLoaded(this);
    }
    return orElse();
  }
}

abstract class _LessonDetailLoaded implements LearningState {
  const factory _LessonDetailLoaded(
      {required final LessonEntity lesson,
      required final bool isBookmarked}) = _$LessonDetailLoadedImpl;

  LessonEntity get lesson;
  bool get isBookmarked;

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonDetailLoadedImplCopyWith<_$LessonDetailLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProgressUpdatedImplCopyWith<$Res> {
  factory _$$ProgressUpdatedImplCopyWith(_$ProgressUpdatedImpl value,
          $Res Function(_$ProgressUpdatedImpl) then) =
      __$$ProgressUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LearningProgressEntity progress, String message});
}

/// @nodoc
class __$$ProgressUpdatedImplCopyWithImpl<$Res>
    extends _$LearningStateCopyWithImpl<$Res, _$ProgressUpdatedImpl>
    implements _$$ProgressUpdatedImplCopyWith<$Res> {
  __$$ProgressUpdatedImplCopyWithImpl(
      _$ProgressUpdatedImpl _value, $Res Function(_$ProgressUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? message = null,
  }) {
    return _then(_$ProgressUpdatedImpl(
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as LearningProgressEntity,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProgressUpdatedImpl implements _ProgressUpdated {
  const _$ProgressUpdatedImpl({required this.progress, required this.message});

  @override
  final LearningProgressEntity progress;
  @override
  final String message;

  @override
  String toString() {
    return 'LearningState.progressUpdated(progress: $progress, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressUpdatedImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, progress, message);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressUpdatedImplCopyWith<_$ProgressUpdatedImpl> get copyWith =>
      __$$ProgressUpdatedImplCopyWithImpl<_$ProgressUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)
        loaded,
    required TResult Function(Failure failure) error,
    required TResult Function(String message, Map<String, dynamic>? data)
        operationSuccess,
    required TResult Function(
            List<LessonEntity> searchResults, String searchQuery)
        searchSuccess,
    required TResult Function(String lessonId) lessonDetailLoading,
    required TResult Function(LessonEntity lesson, bool isBookmarked)
        lessonDetailLoaded,
    required TResult Function(LearningProgressEntity progress, String message)
        progressUpdated,
    required TResult Function() syncing,
    required TResult Function(String message) syncCompleted,
  }) {
    return progressUpdated(progress, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult? Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult? Function(String lessonId)? lessonDetailLoading,
    TResult? Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult? Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult? Function()? syncing,
    TResult? Function(String message)? syncCompleted,
  }) {
    return progressUpdated?.call(progress, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult Function(Failure failure)? error,
    TResult Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult Function(String lessonId)? lessonDetailLoading,
    TResult Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult Function()? syncing,
    TResult Function(String message)? syncCompleted,
    required TResult orElse(),
  }) {
    if (progressUpdated != null) {
      return progressUpdated(progress, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OperationSuccess value) operationSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_LessonDetailLoading value) lessonDetailLoading,
    required TResult Function(_LessonDetailLoaded value) lessonDetailLoaded,
    required TResult Function(_ProgressUpdated value) progressUpdated,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_SyncCompleted value) syncCompleted,
  }) {
    return progressUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OperationSuccess value)? operationSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult? Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult? Function(_ProgressUpdated value)? progressUpdated,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_SyncCompleted value)? syncCompleted,
  }) {
    return progressUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OperationSuccess value)? operationSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult Function(_ProgressUpdated value)? progressUpdated,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_SyncCompleted value)? syncCompleted,
    required TResult orElse(),
  }) {
    if (progressUpdated != null) {
      return progressUpdated(this);
    }
    return orElse();
  }
}

abstract class _ProgressUpdated implements LearningState {
  const factory _ProgressUpdated(
      {required final LearningProgressEntity progress,
      required final String message}) = _$ProgressUpdatedImpl;

  LearningProgressEntity get progress;
  String get message;

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgressUpdatedImplCopyWith<_$ProgressUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SyncingImplCopyWith<$Res> {
  factory _$$SyncingImplCopyWith(
          _$SyncingImpl value, $Res Function(_$SyncingImpl) then) =
      __$$SyncingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SyncingImplCopyWithImpl<$Res>
    extends _$LearningStateCopyWithImpl<$Res, _$SyncingImpl>
    implements _$$SyncingImplCopyWith<$Res> {
  __$$SyncingImplCopyWithImpl(
      _$SyncingImpl _value, $Res Function(_$SyncingImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SyncingImpl implements _Syncing {
  const _$SyncingImpl();

  @override
  String toString() {
    return 'LearningState.syncing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SyncingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)
        loaded,
    required TResult Function(Failure failure) error,
    required TResult Function(String message, Map<String, dynamic>? data)
        operationSuccess,
    required TResult Function(
            List<LessonEntity> searchResults, String searchQuery)
        searchSuccess,
    required TResult Function(String lessonId) lessonDetailLoading,
    required TResult Function(LessonEntity lesson, bool isBookmarked)
        lessonDetailLoaded,
    required TResult Function(LearningProgressEntity progress, String message)
        progressUpdated,
    required TResult Function() syncing,
    required TResult Function(String message) syncCompleted,
  }) {
    return syncing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult? Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult? Function(String lessonId)? lessonDetailLoading,
    TResult? Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult? Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult? Function()? syncing,
    TResult? Function(String message)? syncCompleted,
  }) {
    return syncing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult Function(Failure failure)? error,
    TResult Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult Function(String lessonId)? lessonDetailLoading,
    TResult Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult Function()? syncing,
    TResult Function(String message)? syncCompleted,
    required TResult orElse(),
  }) {
    if (syncing != null) {
      return syncing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OperationSuccess value) operationSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_LessonDetailLoading value) lessonDetailLoading,
    required TResult Function(_LessonDetailLoaded value) lessonDetailLoaded,
    required TResult Function(_ProgressUpdated value) progressUpdated,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_SyncCompleted value) syncCompleted,
  }) {
    return syncing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OperationSuccess value)? operationSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult? Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult? Function(_ProgressUpdated value)? progressUpdated,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_SyncCompleted value)? syncCompleted,
  }) {
    return syncing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OperationSuccess value)? operationSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult Function(_ProgressUpdated value)? progressUpdated,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_SyncCompleted value)? syncCompleted,
    required TResult orElse(),
  }) {
    if (syncing != null) {
      return syncing(this);
    }
    return orElse();
  }
}

abstract class _Syncing implements LearningState {
  const factory _Syncing() = _$SyncingImpl;
}

/// @nodoc
abstract class _$$SyncCompletedImplCopyWith<$Res> {
  factory _$$SyncCompletedImplCopyWith(
          _$SyncCompletedImpl value, $Res Function(_$SyncCompletedImpl) then) =
      __$$SyncCompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SyncCompletedImplCopyWithImpl<$Res>
    extends _$LearningStateCopyWithImpl<$Res, _$SyncCompletedImpl>
    implements _$$SyncCompletedImplCopyWith<$Res> {
  __$$SyncCompletedImplCopyWithImpl(
      _$SyncCompletedImpl _value, $Res Function(_$SyncCompletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SyncCompletedImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SyncCompletedImpl implements _SyncCompleted {
  const _$SyncCompletedImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'LearningState.syncCompleted(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncCompletedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncCompletedImplCopyWith<_$SyncCompletedImpl> get copyWith =>
      __$$SyncCompletedImplCopyWithImpl<_$SyncCompletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String? message) loading,
    required TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)
        loaded,
    required TResult Function(Failure failure) error,
    required TResult Function(String message, Map<String, dynamic>? data)
        operationSuccess,
    required TResult Function(
            List<LessonEntity> searchResults, String searchQuery)
        searchSuccess,
    required TResult Function(String lessonId) lessonDetailLoading,
    required TResult Function(LessonEntity lesson, bool isBookmarked)
        lessonDetailLoaded,
    required TResult Function(LearningProgressEntity progress, String message)
        progressUpdated,
    required TResult Function() syncing,
    required TResult Function(String message) syncCompleted,
  }) {
    return syncCompleted(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? message)? loading,
    TResult? Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult? Function(Failure failure)? error,
    TResult? Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult? Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult? Function(String lessonId)? lessonDetailLoading,
    TResult? Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult? Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult? Function()? syncing,
    TResult? Function(String message)? syncCompleted,
  }) {
    return syncCompleted?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? message)? loading,
    TResult Function(
            LearningProgressEntity progress,
            List<LessonEntity> lessons,
            List<LessonEntity> searchResults,
            bool isSearching,
            String? searchQuery,
            Map<String, dynamic>? completionResult)?
        loaded,
    TResult Function(Failure failure)? error,
    TResult Function(String message, Map<String, dynamic>? data)?
        operationSuccess,
    TResult Function(List<LessonEntity> searchResults, String searchQuery)?
        searchSuccess,
    TResult Function(String lessonId)? lessonDetailLoading,
    TResult Function(LessonEntity lesson, bool isBookmarked)?
        lessonDetailLoaded,
    TResult Function(LearningProgressEntity progress, String message)?
        progressUpdated,
    TResult Function()? syncing,
    TResult Function(String message)? syncCompleted,
    required TResult orElse(),
  }) {
    if (syncCompleted != null) {
      return syncCompleted(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_OperationSuccess value) operationSuccess,
    required TResult Function(_SearchSuccess value) searchSuccess,
    required TResult Function(_LessonDetailLoading value) lessonDetailLoading,
    required TResult Function(_LessonDetailLoaded value) lessonDetailLoaded,
    required TResult Function(_ProgressUpdated value) progressUpdated,
    required TResult Function(_Syncing value) syncing,
    required TResult Function(_SyncCompleted value) syncCompleted,
  }) {
    return syncCompleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_OperationSuccess value)? operationSuccess,
    TResult? Function(_SearchSuccess value)? searchSuccess,
    TResult? Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult? Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult? Function(_ProgressUpdated value)? progressUpdated,
    TResult? Function(_Syncing value)? syncing,
    TResult? Function(_SyncCompleted value)? syncCompleted,
  }) {
    return syncCompleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_OperationSuccess value)? operationSuccess,
    TResult Function(_SearchSuccess value)? searchSuccess,
    TResult Function(_LessonDetailLoading value)? lessonDetailLoading,
    TResult Function(_LessonDetailLoaded value)? lessonDetailLoaded,
    TResult Function(_ProgressUpdated value)? progressUpdated,
    TResult Function(_Syncing value)? syncing,
    TResult Function(_SyncCompleted value)? syncCompleted,
    required TResult orElse(),
  }) {
    if (syncCompleted != null) {
      return syncCompleted(this);
    }
    return orElse();
  }
}

abstract class _SyncCompleted implements LearningState {
  const factory _SyncCompleted(final String message) = _$SyncCompletedImpl;

  String get message;

  /// Create a copy of LearningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncCompletedImplCopyWith<_$SyncCompletedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
