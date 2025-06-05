import '../entities/home_data_entity.dart';
import '../entities/user_stats_entity.dart';
import '../entities/notification_entity.dart';
import '../repositories/home_repository.dart';

/// 刷新主页数据用例
class RefreshHomeDataUseCase {
  final HomeRepository _repository;
  
  RefreshHomeDataUseCase(this._repository);
  
  Future<RefreshHomeDataResult> call(RefreshHomeDataParams params) async {
    return await _repository.refreshHomeData(params.userId);
  }
}

/// 刷新主页数据参数
class RefreshHomeDataParams {
  final String userId;
  
  const RefreshHomeDataParams({
    required this.userId,
  });
}

/// 刷新主页数据结果
class RefreshHomeDataResult {
  final HomeDataEntity homeData;
  final UserStatsEntity userStats;
  final List<NotificationEntity> notifications;
  
  const RefreshHomeDataResult({
    required this.homeData,
    required this.userStats,
    required this.notifications,
  });
}