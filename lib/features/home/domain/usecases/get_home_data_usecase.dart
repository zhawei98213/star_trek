import '../entities/home_data_entity.dart';
import '../repositories/home_repository.dart';

/// 获取主页数据用例
class GetHomeDataUseCase {
  final HomeRepository _repository;
  
  GetHomeDataUseCase(this._repository);
  
  Future<HomeDataEntity> call(GetHomeDataParams params) async {
    return await _repository.getHomeData(params.userId);
  }
}

/// 获取主页数据参数
class GetHomeDataParams {
  final String userId;
  
  const GetHomeDataParams({
    required this.userId,
  });
}