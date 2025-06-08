import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import '../error/failures.dart';

/// Either扩展方法，提供便捷的错误处理功能
extension EitherExtensions<L, R> on Either<L, R> {
  /// 获取Right值（成功值）
  R getRight() => (this as Right<L, R>).value;
  
  /// 获取Left值（失败值）
  L getLeft() => (this as Left<L, R>).value;
  
  /// 在UI中根据成功/失败状态渲染不同的Widget
  Widget when({
    required Widget Function(L failure) failure,
    required Widget Function(R data) success,
  }) {
    return fold(
      (l) => failure(l),
      (r) => success(r),
    );
  }
  
  /// 简化链式操作，用于可能失败的连续操作
  Either<L, T> flatMap<T>(Either<L, T> Function(R r) f) {
    return fold(
      (l) => Left(l),
      (r) => f(r),
    );
  }
  
  /// 将Right值转换为另一种类型
  Either<L, T> mapRight<T>(T Function(R r) f) {
    return fold(
      (l) => Left(l),
      (r) => Right(f(r)),
    );
  }
  
  /// 将Left值转换为另一种类型
  Either<T, R> mapLeft<T>(T Function(L l) f) {
    return fold(
      (l) => Left(f(l)),
      (r) => Right(r),
    );
  }
  
  /// 检查是否为成功状态
  bool get isRight => fold((_) => false, (_) => true);
  
  /// 检查是否为失败状态
  bool get isLeft => fold((_) => true, (_) => false);
  
  /// 获取Right值，如果是Left则返回默认值
  R getOrElse(R Function() defaultValue) {
    return fold((_) => defaultValue(), (r) => r);
  }
  
  /// 如果是Right值则执行操作
  Either<L, R> doOnRight(void Function(R r) action) {
    return fold(
      (l) => Left(l),
      (r) {
        action(r);
        return Right(r);
      },
    );
  }
  
  /// 如果是Left值则执行操作
  Either<L, R> doOnLeft(void Function(L l) action) {
    return fold(
      (l) {
        action(l);
        return Left(l);
      },
      (r) => Right(r),
    );
  }
}

/// Failure特定的Either扩展
extension FailureEitherExtensions<R> on Either<Failure, R> {
  /// 获取错误消息
  String get errorMessage => fold((failure) => failure.message, (_) => '');
  
  /// 获取错误代码
  String? get errorCode => fold((failure) => failure.code, (_) => null);
  
  /// 检查是否为特定类型的失败
  bool isFailureOfType<T extends Failure>() {
    return fold((failure) => failure is T, (_) => false);
  }
  
  /// 在UI中处理Failure的便捷方法
  Widget whenFailure({
    required Widget Function(Failure failure) onFailure,
    required Widget Function(R data) onSuccess,
    Widget Function(String message)? onServerFailure,
    Widget Function(String message)? onNetworkFailure,
    Widget Function(String message)? onCacheFailure,
    Widget Function(String message)? onValidationFailure,
  }) {
    return fold(
      (failure) {
        // 根据失败类型选择特定的处理方式
        if (failure.runtimeType.toString().contains('ServerFailure') && onServerFailure != null) {
          return onServerFailure(failure.message);
        } else if (failure.runtimeType.toString().contains('NetworkFailure') && onNetworkFailure != null) {
          return onNetworkFailure(failure.message);
        } else if (failure.runtimeType.toString().contains('CacheFailure') && onCacheFailure != null) {
          return onCacheFailure(failure.message);
        } else if (failure.runtimeType.toString().contains('ValidationFailure') && onValidationFailure != null) {
          return onValidationFailure(failure.message);
        }
        return onFailure(failure);
      },
      (data) => onSuccess(data),
    );
  }
}