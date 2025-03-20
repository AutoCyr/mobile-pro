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
  Future addDisponibilities(Map<String, dynamic> body) async {
    return await _partnerDataSourceImpl.addDisponibilities(body);
  }

  @override
  Future addSubscription(Map<String, dynamic> body) async {
    return await _partnerDataSourceImpl.addSubscription(body);
  }

  @override
  Future addFreeSubscription(Map<String, dynamic> body) async {
    return await _partnerDataSourceImpl.addFreeSubscription(body);
  }

  @override
  Future checkSubscription(String id) async {
    return await _partnerDataSourceImpl.checkSubscription(id);
  }

  @override
  Future getPieces(Map<String, dynamic> params) async {
    return await _partnerDataSourceImpl.getPieces(params);
  }

  @override
  Future getPiece(String id) async {
    return await _partnerDataSourceImpl.getPiece(id);
  }

  @override
  Future updateAdresses(Map<String, dynamic> body) async {
    return await _partnerDataSourceImpl.updateAdresses(body);
  }

  @override
  Future updateDisponibilities(Map<String, dynamic> body) async {
    return await _partnerDataSourceImpl.updateDisponibilities(body);
  }

  @override
  Future updatePiece(Map<String, String> body, String id, String filepath, String name) async {
    return await _partnerDataSourceImpl.updatePiece(body, id, filepath, name);
  }

  @override
  Future changePieceStatus(String id) async {
    return await _partnerDataSourceImpl.changePieceStatus(id);
  }

  @override
  Future getCommandes(Map<String, dynamic> params) async {
    return await _partnerDataSourceImpl.getCommandes(params);
  }

  @override
  Future getRequests(Map<String, dynamic> params) async {
    return await _partnerDataSourceImpl.getRequests(params);
  }

}