abstract class PartnerDataSource {
  Future checkSubscription(String id);

  Future addSubscription(Map<String, dynamic> body);

  Future addPiece(Map<String, String> body, String filepath, String name);

  Future getPieces(String id);

  Future updateAdresses(Map<String, dynamic> body);
}