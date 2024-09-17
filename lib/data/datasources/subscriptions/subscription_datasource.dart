abstract class SubscriptionDataSource {
  Future checkSubscription(String id);

  Future addSubscription(Map<String, dynamic> body);

  Future addPiece(Map<String, dynamic> body);

  Future getPieces(String id);
}