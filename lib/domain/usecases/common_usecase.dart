import 'package:autocyr_pro/data/repositories/common_repository_impl.dart';

class CommonUseCase {

  final CommonRepositoryImpl _commonRepositoryImpl;

  CommonUseCase(this._commonRepositoryImpl);

  Future getAutoMakes() async {
    return await _commonRepositoryImpl.getAutoMakes();
  }

  Future getBikeMakes() async {
    return await _commonRepositoryImpl.getBikeMakes();
  }

  Future getCountries() async {
    return await _commonRepositoryImpl.getCountries();
  }

  Future getPartnerTypes() async {
    return await _commonRepositoryImpl.getPartnerTypes();
  }

  Future getPlans() async {
    return await _commonRepositoryImpl.getPlans();
  }
}