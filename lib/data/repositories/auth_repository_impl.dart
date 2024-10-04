import 'package:autocyr_pro/data/datasources/auths/auth_datasource_impl.dart';
import 'package:autocyr_pro/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {

  final AuthDataSourceImpl _authDataSourceImpl;
  AuthRepositoryImpl(this._authDataSourceImpl);

  @override
  Future login(Map<String, dynamic> body) async {
    return await _authDataSourceImpl.login(body);
  }

  @override
  Future logout() async {
    return await _authDataSourceImpl.logout();
  }

  @override
  Future register(Map<String, dynamic> body) async {
    return await _authDataSourceImpl.register(body);
  }

  @override
  Future updateFCMToken(Map<String, dynamic> body) async {
    return await _authDataSourceImpl.updateFCMToken(body);
  }

  @override
  Future getProfile() async {
    return await _authDataSourceImpl.getProfile();
  }
}