import 'package:autocyr_pro/data/repositories/partner_repository_impl.dart';

class PartnerUseCase {

  final PartnerRepositoryImpl _partnerRepositoryImpl;

  PartnerUseCase(this._partnerRepositoryImpl);

  Future addPiece(Map<String, String> body, String filepath, String name) async {
    return await _partnerRepositoryImpl.addPiece(body, filepath, name);
  }

  Future updatePiece(Map<String, String> body, String id, String filepath, String name) async {
    return await _partnerRepositoryImpl.updatePiece(body, id, filepath, name);
  }

  Future changePieceStatus(String id) async {
    return await _partnerRepositoryImpl.changePieceStatus(id);
  }

  Future addDisponibilities(Map<String, dynamic> body) async {
    return await _partnerRepositoryImpl.addDisponibilities(body);
  }

  Future updateDisponibilities(Map<String, dynamic> body) async {
    return await _partnerRepositoryImpl.updateDisponibilities(body);
  }

  Future addSubscription(Map<String, dynamic> body) async {
    return await _partnerRepositoryImpl.addSubscription(body);
  }

  Future addFreeSubscription(Map<String, dynamic> body) async {
    return await _partnerRepositoryImpl.addFreeSubscription(body);
  }

  Future checkSubscription(String id) async {
    return await _partnerRepositoryImpl.checkSubscription(id);
  }

  Future getPieces(Map<String, dynamic> params) async {
    return await _partnerRepositoryImpl.getPieces(params);
  }

  Future getPiece(String id) async {
    return await _partnerRepositoryImpl.getPiece(id);
  }

  Future updateAdresses(Map<String, dynamic> body) async {
    return await _partnerRepositoryImpl.updateAdresses(body);
  }

  Future getCommandes(Map<String, dynamic> params) async {
    return await _partnerRepositoryImpl.getCommandes(params);
  }

}