import 'package:autocyr_pro/data/repositories/subscription_repository_impl.dart';

class SubscriptionUseCase {

  final SubscriptionRepositoryImpl _subscriptionRepositoryImpl;

  SubscriptionUseCase(this._subscriptionRepositoryImpl);

  Future addPiece(Map<String, dynamic> body) async {
    return await _subscriptionRepositoryImpl.addPiece(body);
  }

  Future addSubscription(Map<String, dynamic> body) async {
    return await _subscriptionRepositoryImpl.addSubscription(body);
  }

  Future checkSubscription(String id) async {
    return await _subscriptionRepositoryImpl.checkSubscription(id);
  }

  Future getPieces(String id) async {
    return await _subscriptionRepositoryImpl.getPieces(id);
  }

}