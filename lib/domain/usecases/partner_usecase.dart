import 'package:autocyr_pro/data/repositories/partner_repository_impl.dart';

class PartnerUseCase {

  final PartnerRepositoryImpl _partnerRepositoryImpl;

  PartnerUseCase(this._partnerRepositoryImpl);

  Future addPiece(Map<String, String> body, String filepath, String name) async {
    return await _partnerRepositoryImpl.addPiece(body, filepath, name);
  }

  Future addSubscription(Map<String, dynamic> body) async {
    return await _partnerRepositoryImpl.addSubscription(body);
  }

  Future checkSubscription(String id) async {
    return await _partnerRepositoryImpl.checkSubscription(id);
  }

  Future getPieces(String id) async {
    return await _partnerRepositoryImpl.getPieces(id);
  }

  Future updateAdresses(Map<String, dynamic> body) async {
    return await _partnerRepositoryImpl.updateAdresses(body);
  }

}