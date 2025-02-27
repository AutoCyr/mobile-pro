abstract class PartnerDataSource {
  Future checkSubscription(String id);

  Future addSubscription(Map<String, dynamic> body);

  Future addFreeSubscription(Map<String, dynamic> body);

  Future addPiece(Map<String, String> body, String filepath, String name);

  Future updatePiece(Map<String, String> body, String id, String filepath, String name);

  Future changePieceStatus(String id);

  Future addDisponibilities(Map<String, dynamic> body);

  Future updateDisponibilities(Map<String, dynamic> body);

  Future getPieces(Map<String, dynamic> params);

  Future getPiece(String id);

  Future updateAdresses(Map<String, dynamic> body);

  Future getCommandes(Map<String, dynamic> params);
}