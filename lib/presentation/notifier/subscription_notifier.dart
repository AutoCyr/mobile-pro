import 'package:autocyr_pro/domain/models/core/plan.dart';
import 'package:autocyr_pro/domain/models/core/subscription.dart';
import 'package:autocyr_pro/domain/models/response/failure.dart';
import 'package:autocyr_pro/domain/models/response/success.dart';
import 'package:autocyr_pro/domain/usecases/subscription_usecase.dart';
import 'package:autocyr_pro/presentation/notifier/common_notifier.dart';
import 'package:autocyr_pro/presentation/ui/helpers/snacks.dart';
import 'package:autocyr_pro/presentation/ui/screens/masters/home.dart';
import 'package:autocyr_pro/presentation/ui/screens/subscriptions/subscription.dart';
import 'package:autocyr_pro/presentation/ui/screens/subscriptions/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionNotifier extends ChangeNotifier {

  final SubscriptionUseCase subscriptionUseCase;
  SubscriptionNotifier({required this.subscriptionUseCase});

  bool _loading = false;
  Subscription? _subscription;

  bool get loading => _loading;
  Subscription? get subscription => _subscription;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSubscription(Subscription value) {
    _subscription = value;
    notifyListeners();
  }

  checkSubscription({required String id, required List<Plan> plans, required BuildContext context}) async {
    setLoading(true);
    try {
      var data = await subscriptionUseCase.checkSubscription(id);

      if(data['error'] == false) {
        Success success = Success.fromJson(data);

        Subscription subscription = Subscription.fromJson(success.data);
        setSubscription(subscription);

        Plan plan = plans.firstWhere((element) => element.id == subscription.abonnementId);

        if(subscription.status == 0) {
          if(context.mounted) {
            final common = Provider.of<CommonNotifier>(context, listen: false);
            await common.setPlan(plan);
            Snacks.infoBar("Votre souscription est en attente de validation", context);
          }
        } else if(subscription.status == 1) {
          if(context.mounted) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeDashScreen()), (route) => false);
          }
        }
        setLoading(false);
      }else{
        Failure failure = Failure.fromJson(data);

        if(failure.except == null) {
          setLoading(false);
          if(context.mounted) {
            Snacks.infoBar("Veuillez souscrire à un plan avant de continuer", context);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SubscriptionChoiceScreen()), (route) => false);
          }
        }else{
          setLoading(false);
          if(context.mounted) {
            Snacks.failureBar(failure.message, context);
          }
        }
      }
    } catch (e) {
      print(e);
      setLoading(false);
      Snacks.failureBar("Une erreur est survenue", context);
    }
  }

  addSubscription({required Map<String, dynamic> body, required Plan plan, required BuildContext context}) async {
    setLoading(true);
    try {
      var data = await subscriptionUseCase.addSubscription(body);

      if(data['error'] == false) {
        Success success = Success.fromJson(data);

        Subscription subscription = Subscription.fromJson(success.data);
        setSubscription(subscription);

        if(context.mounted) {
          Snacks.successBar("Votre souscription a bien été prise en compte", context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ValidatorScreen()));
        }

        setLoading(false);
      }else{
        Failure failure = Failure.fromJson(data);

        setLoading(false);
        if(context.mounted) {
          Snacks.failureBar(failure.message, context);
        }
      }
    } catch (e) {
      print(e);
      setLoading(false);
      Snacks.failureBar("Une erreur est survenue", context);
    }
  }

}