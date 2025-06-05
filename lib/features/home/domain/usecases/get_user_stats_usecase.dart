import '../entities/user_stats_entity.dart';
import '../repositories/home_repository.dart';

/// 获取用户统计数据用例
class GetUserStatsUseCase {
  final HomeRepository _repository;
  
  GetUserStatsUseCase(this._repository);
  
  Future<UserStatsEntity> call(GetUserStatsParams params) async {
    return await _repository.getUserStats(params.userId);
  }
}

/// 获取用户统计数据参数
class GetUserStatsParams {
  final String userId;
  
  const GetUserStatsParams({
    required this.userId,
  });
}