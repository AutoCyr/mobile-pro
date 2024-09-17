import 'package:autocyr_pro/data/datasources/subscriptions/subscription_datasource_impl.dart';
import 'package:autocyr_pro/domain/repositories/subscription_repository.dart';

class SubscriptionRepositoryImpl extends SubscriptionRepository {

  final SubscriptionDataSourceImpl _subscriptionDataSourceImpl;
  SubscriptionRepositoryImpl(this._subscriptionDataSourceImpl);

  @override
  Future addPiece(Map<String, dynamic> body) async {
    return await _subscriptionDataSourceImpl.addPiece(body);
  }

  @override
  Future addSubscription(Map<String, dynamic> body) async {
    return await _subscriptionDataSourceImpl.addSubscription(body);
  }

  @override
  Future checkSubscription(String id) async {
    return await _subscriptionDataSourceImpl.checkSubscription(id);
  }

  @override
  Future getPieces(String id) async {
    return await _subscriptionDataSourceImpl.getPieces(id);
  }

}