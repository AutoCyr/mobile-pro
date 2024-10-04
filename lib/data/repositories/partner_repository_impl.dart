import 'package:autocyr_pro/data/datasources/partners/partner_datasource_impl.dart';
import 'package:autocyr_pro/domain/repositories/partner_repository.dart';

class PartnerRepositoryImpl extends PartnerRepository {

  final PartnerDataSourceImpl _partnerDataSourceImpl;
  PartnerRepositoryImpl(this._partnerDataSourceImpl);

  @override
  Future addPiece(Map<String, String> body, String filepath, String name) async {
    return await _partnerDataSourceImpl.addPiece(body, filepath, name);
  }

  @override
  Future addSubscription(Map<String, dynamic> body) async {
    return await _partnerDataSourceImpl.addSubscription(body);
  }

  @override
  Future checkSubscription(String id) async {
    return await _partnerDataSourceImpl.checkSubscription(id);
  }

  @override
  Future getPieces(String id) async {
    return await _partnerDataSourceImpl.getPieces(id);
  }

  @override
  Future updateAdresses(Map<String, dynamic> body) async {
    return await _partnerDataSourceImpl.updateAdresses(body);
  }

}