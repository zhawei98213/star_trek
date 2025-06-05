import '../repositories/home_repository.dart';

/// 标记通知为已读用例
class MarkNotificationReadUseCase {
  final HomeRepository _repository;
  
  MarkNotificationReadUseCase(this._repository);
  
  Future<void> call(MarkNotificationReadParams params) async {
    return await _repository.markNotificationAsRead(params.notificationId);
  }
}

/// 标记通知为已读参数
class MarkNotificationReadParams {
  final String notificationId;
  
  const MarkNotificationReadParams({
    required this.notificationId,
  });
}