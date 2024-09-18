import 'package:autocyr_pro/data/datasources/commons/common_datasource_impl.dart';
import 'package:autocyr_pro/domain/repositories/common_repository.dart';

class CommonRepositoryImpl extends CommonRepository {

  final CommonDataSourceImpl _commonDataSourceImpl;

  CommonRepositoryImpl(this._commonDataSourceImpl);

  @override
  Future getCountries() async {
    return await _commonDataSourceImpl.getCountries();
  }

  @override
  Future getAutoMakes() async {
    return await _commonDataSourceImpl.getAutoMakes();
  }

  @override
  Future getBikeMakes() async {
    return await _commonDataSourceImpl.getBikeMakes();
  }

  @override
  Future getPartnerTypes() async {
    return await _commonDataSourceImpl.getPartnerTypes();
  }

  @override
  Future getPlans() async {
    return await _commonDataSourceImpl.getPlans();
  }


}