import 'package:autocyr_pro/domain/models/core/plan.dart';
import 'package:autocyr_pro/domain/models/core/subscription.dart';
import 'package:autocyr_pro/domain/models/pieces/detail_piece.dart';
import 'package:autocyr_pro/domain/models/response/failure.dart';
import 'package:autocyr_pro/domain/models/response/success.dart';
import 'package:autocyr_pro/domain/usecases/partner_usecase.dart';
import 'package:autocyr_pro/presentation/notifier/auth_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/common_notifier.dart';
import 'package:autocyr_pro/presentation/ui/helpers/snacks.dart';
import 'package:autocyr_pro/presentation/ui/screens/masters/home.dart';
import 'package:autocyr_pro/presentation/ui/screens/subscriptions/subscription.dart';
import 'package:autocyr_pro/presentation/ui/screens/subscriptions/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartnerNotifier extends ChangeNotifier {

  final PartnerUseCase partnerUseCase;
  PartnerNotifier({required this.partnerUseCase});

  bool _loading = false;
  Subscription? _subscription;
  List<DetailPiece> _pieces = [];

  bool get loading => _loading;
  Subscription? get subscription => _subscription;
  List<DetailPiece> get pieces => _pieces;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSubscription(Subscription value) {
    _subscription = value;
    notifyListeners();
  }

  setPieces(List<DetailPiece> value) {
    _pieces = value;
    notifyListeners();
  }

  checkSubscription({required String id, required List<Plan> plans, required BuildContext context}) async {
    setLoading(true);
    try {
      var data = await partnerUseCase.checkSubscription(id);

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
      var data = await partnerUseCase.addSubscription(body);

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

  addPiece({
    required Map<String, String> body,
    required String filepath,
    required String name,
    required BuildContext context
  }) async {
    setLoading(true);
    try {
      var data = await partnerUseCase.addPiece(body, filepath, name);

      if(data['error'] == false) {
        Success success = Success.fromJson(data);

        DetailPiece detailPiece = DetailPiece.fromJson(success.data);
        _pieces.add(detailPiece);
        setPieces(_pieces);
        if(context.mounted) {
          Snacks.successBar("Votre pièce a bien été enregistrée", context);
          Navigator.pop(context);
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

  getPieces({required String id, required BuildContext context}) async {
    setLoading(true);
    try {
      var data = await partnerUseCase.getPieces(id);

      if(data['error'] == false) {
        Success success = Success.fromJson(data);

        List<DetailPiece> pieces = [];
        for(var piece in success.data) {
          DetailPiece detailPiece = DetailPiece.fromJson(piece);
          pieces.add(detailPiece);
        }
        setPieces(pieces);

        if(context.mounted) {
          Snacks.successBar("Vos pieces ont bien été récupérées", context);
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

  updateAddresses({required Map<String, dynamic> body, required AuthNotifier auth, required BuildContext context}) async {
    setLoading(true);
    try {
      var data = await partnerUseCase.updateAdresses(body);

      if(data['error'] == false) {
        Success success = Success.fromJson(data);

        if (context.mounted) {
          await auth.getProfile(context: context);
          Snacks.successBar(success.message, context);
          setLoading(false);
          Navigator.pop(context);
        }
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