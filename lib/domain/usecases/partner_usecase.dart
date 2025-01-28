import 'package:autocyr_pro/data/repositories/partner_repository_impl.dart';

class PartnerUseCase {

  final PartnerRepositoryImpl _partnerRepositoryImpl;

  PartnerUseCase(this._partnerRepositoryImpl);

  Future addPiece(Map<String, String> body, String filepath, String name) async {
    return await _partnerRepositoryImpl.addPiece(body, filepath, name);
  }

  Future addDisponibilities(Map<String, dynamic> body) async {
    return await _partnerRepositoryImpl.addDisponibilities(body);
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

  Future getPieces(String id) async {
    return await _partnerRepositoryImpl.getPieces(id);
  }

  Future getPiece(String id) async {
    return await _partnerRepositoryImpl.getPiece(id);
  }

  Future updateAdresses(Map<String, dynamic> body) async {
    return await _partnerRepositoryImpl.updateAdresses(body);
  }

}