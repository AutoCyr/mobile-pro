abstract class PartnerRepository {
  Future checkSubscription(String id);

  Future addSubscription(Map<String, dynamic> body);

  Future addFreeSubscription(Map<String, dynamic> body);

  Future addPiece(Map<String, String> body, String filepath, String name);

  Future addDisponibilities(Map<String, dynamic> body);

  Future getPieces(String id);

  Future getPiece(String id);

  Future updateAdresses(Map<String, dynamic> body);
}