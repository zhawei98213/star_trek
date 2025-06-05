import '../entities/notification_entity.dart';
import '../repositories/home_repository.dart';

/// 获取通知列表用例
class GetNotificationsUseCase {
  final HomeRepository _repository;
  
  GetNotificationsUseCase(this._repository);
  
  Future<List<NotificationEntity>> call(GetNotificationsParams params) async {
    return await _repository.getNotifications(
      params.userId,
      limit: params.limit,
      offset: params.offset,
      unreadOnly: params.unreadOnly,
    );
  }
}

/// 获取通知列表参数
class GetNotificationsParams {
  final String userId;
  final int limit;
  final int offset;
  final bool unreadOnly;
  
  const GetNotificationsParams({
    required this.userId,
    this.limit = 20,
    this.offset = 0,
    this.unreadOnly = false,
  });
}