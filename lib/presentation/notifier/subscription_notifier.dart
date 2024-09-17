import 'package:autocyr_pro/domain/models/response/success.dart';
import 'package:autocyr_pro/domain/usecases/subscription_usecase.dart';
import 'package:flutter/material.dart';

class SubscriptionNotifier extends ChangeNotifier {

  final SubscriptionUseCase subscriptionUseCase;
  SubscriptionNotifier({required this.subscriptionUseCase});

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  checkSubscription({required String id, required BuildContext context}) async {
    setLoading(true);
    try {
      var data = await subscriptionUseCase.checkSubscription(id);

      if(data['error'] == false) {
        Success success = Success.fromJson(data);
        debugPrint(success.data.toString());

        setLoading(false);
      }else{
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
    }
  }

  addSubscription({required Map<String, dynamic> body, required BuildContext context}) async {
    setLoading(true);
    try {
      var data = await subscriptionUseCase.addSubscription(body);

      if(data['error'] == false) {
        Success success = Success.fromJson(data);
        debugPrint(success.data.toString());

        setLoading(false);
      }else{
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
    }
  }

}