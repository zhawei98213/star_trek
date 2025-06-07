/// 失败类型基类
abstract class Failure {
  final String message;
  final String? code;
  
  const Failure(this.message, {this.code});
  
  @override
  String toString() => 'Failure: $message';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure && other.message == message && other.code == code;
  }
  
  @override
  int get hashCode => message.hashCode ^ code.hashCode;
}

/// 服务器错误
class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code});
}

/// 网络错误
class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.code});
}

/// 缓存错误
class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.code});
}

/// 验证错误
class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.code});
}

/// 未找到错误
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, {super.code});
}

/// 权限错误
class PermissionFailure extends Failure {
  const PermissionFailure(super.message, {super.code});
}

/// 认证错误
class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message, {super.code});
}

/// 未知错误
class UnknownFailure extends Failure {
  const UnknownFailure(super.message, {super.code});
}