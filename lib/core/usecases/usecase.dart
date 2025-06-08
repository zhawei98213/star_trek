import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// 基础UseCase抽象类
/// 所有用例都应该继承此类
abstract class UseCase<Type, Params> {
  /// 执行用例
  /// [params] 用例参数
  /// 返回 `Either<Failure, Type>` 表示成功或失败
  Future<Either<Failure, Type>> call(Params params);
}

/// 无参数的UseCase
abstract class NoParamsUseCase<Type> {
  /// 执行用例（无参数）
  /// 返回 `Either<Failure, Type>` 表示成功或失败
  Future<Either<Failure, Type>> call();
}

/// 同步UseCase
abstract class SyncUseCase<Type, Params> {
  /// 同步执行用例
  /// [params] 用例参数
  /// 返回 `Either<Failure, Type>` 表示成功或失败
  Either<Failure, Type> call(Params params);
}

/// 同步无参数UseCase
abstract class SyncNoParamsUseCase<Type> {
  /// 同步执行用例（无参数）
  /// 返回 `Either<Failure, Type>` 表示成功或失败
  Either<Failure, Type> call();
}

/// Stream UseCase
abstract class StreamUseCase<Type, Params> {
  /// 执行流式用例
  /// [params] 用例参数
  /// 返回 `Stream<Either<Failure, Type>>` 表示成功或失败的流
  Stream<Either<Failure, Type>> call(Params params);
}

/// 无参数的Stream UseCase
abstract class StreamNoParamsUseCase<Type> {
  /// 执行流式用例（无参数）
  /// 返回 `Stream<Either<Failure, Type>>` 表示成功或失败的流
  Stream<Either<Failure, Type>> call();
}

/// 无参数标记类
class NoParams {
  const NoParams();
}