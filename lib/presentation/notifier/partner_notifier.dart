import 'package:autocyr_pro/domain/models/core/plan.dart';
import 'package:autocyr_pro/domain/models/core/subscription.dart';
import 'package:autocyr_pro/domain/models/pieces/detail_piece.dart';
import 'package:autocyr_pro/domain/models/pieces/piece.dart';
import 'package:autocyr_pro/domain/models/pieces/piece_info.dart';
import 'package:autocyr_pro/domain/models/response/failure.dart';
import 'package:autocyr_pro/domain/models/response/success.dart';
import 'package:autocyr_pro/domain/usecases/partner_usecase.dart';
import 'package:autocyr_pro/presentation/notifier/auth_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/common_notifier.dart';
import 'package:autocyr_pro/presentation/ui/helpers/snacks.dart';
import 'package:autocyr_pro/presentation/ui/screens/masters/home.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/pieces/operations/config.dart';
import 'package:autocyr_pro/presentation/ui/screens/subscriptions/subscription.dart';
import 'package:autocyr_pro/presentation/ui/screens/subscriptions/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PartnerNotifier extends ChangeNotifier {

  final PartnerUseCase partnerUseCase;
  PartnerNotifier({required this.partnerUseCase});

  bool _mainLoading = false;
  bool _loading = false;
  bool _update = false;
  Subscription? _subscription;
  PieceInfo? _piece;
  List<DetailPiece> _pieces = [];
  Map<DetailPiece, bool> _actionPieces = {};

  bool get mainLoading => _mainLoading;
  bool get loading => _loading;
  bool get update => _update;
  Subscription? get subscription => _subscription;
  PieceInfo? get piece => _piece;
  List<DetailPiece> get pieces => _pieces;
  Map<DetailPiece, bool> get actionPieces => _actionPieces;

  setMainLoading(bool value) {
    _mainLoading = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setUpdate(bool value) {
    _update = value;
    notifyListeners();
  }

  setSubscription(Subscription value) {
    _subscription = value;
    notifyListeners();
  }

  setPiece(PieceInfo value) {
    _piece = value;
    notifyListeners();
  }

  setPieces(List<DetailPiece> value) {
    _pieces = value;
    notifyListeners();
  }

  setActionPieces(Map<DetailPiece, bool> value) {
    _actionPieces = value;
    notifyListeners();
  }

  updateActionPieces(DetailPiece piece) {
    _actionPieces[piece] = !_actionPieces[piece]!;
    notifyListeners();
  }

  bool isActionPiece(DetailPiece piece) {
    return _actionPieces[piece] ?? false;
  }

  checkSubscription({required String id, required List<Plan> plans, required BuildContext context}) async {
    setLoading(true);
    try {
      var data = await partnerUseCase.checkSubscription(id);

      if(data['error'] == false) {
        Success success = Success.fromJson(data);

        if(success.data == null) {
          setLoading(false);
          if(context.mounted) {
            Snacks.infoBar("Veuillez souscrire à un plan avant de continuer", context);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SubscriptionChoiceScreen(isFree: true,)), (route) => false);
          }
        } else {
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
        }
      }else{
        Failure failure = Failure.fromJson(data);

        if(failure.except == null) {
          setLoading(false);
          if(context.mounted) {
            Snacks.infoBar("Veuillez souscrire à un plan avant de continuer", context);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SubscriptionChoiceScreen(isFree: false,)), (route) => false);
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

  addFreeSubscription({required Map<String, dynamic> body, required Plan plan, required BuildContext context}) async {
    setLoading(true);
    try {
      var data = await partnerUseCase.addFreeSubscription(body);

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

  addPiece({required Map<String, String> body, required String filepath, required String name, required BuildContext context}) async {
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
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PieceConfigScreen(detail: detailPiece)));
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

  updatePiece({required Map<String, String> body, required String id, required String filepath, required String name, required Future function, required BuildContext context}) async {
    setLoading(true);
    try {
      var data = await partnerUseCase.updatePiece(body, id, filepath, name);

      if(data['error'] == false) {
        Success success = Success.fromJson(data);

        DetailPiece detailPiece = DetailPiece.fromJson(success.data);
        final updatePieces = List.of(_pieces)..removeWhere((element) => element.detailPieceId == detailPiece.detailPieceId);
        updatePieces.add(detailPiece);
        setPieces(updatePieces);

        final updateActionPiece = Map.of(_actionPieces)..[detailPiece] = false;
        setActionPieces(updateActionPiece);

        setLoading(false);
        if(context.mounted) {
          Snacks.successBar("Votre pièce a bien été modifiée", context);
          await function;
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

  changePieceStatus({required DetailPiece piece, required Future function, required BuildContext context}) async {
    setUpdate(true);
    try {
      var data = await partnerUseCase.changePieceStatus(piece.detailPieceId.toString());

      if(data['error'] == false) {
        Success success = Success.fromJson(data);

        setUpdate(false);
        if(context.mounted) {
          await function;
          Snacks.successBar("Le statut de votre pièce a bien été modifié", context);
        }
      }else{
        Failure failure = Failure.fromJson(data);

        setUpdate(false);
        if(context.mounted) {
          Snacks.failureBar(failure.message, context);
        }
      }
    } catch (e) {
      print(e);
      setUpdate(false);
      Snacks.failureBar("Une erreur est survenue", context);
    }
  }

  addDisponibilities({required Map<String, dynamic> body, required BuildContext context}) async {
    setLoading(true);
    try {
      var data = await partnerUseCase.addDisponibilities(body);

      if(data['error'] == false) {
        Success success = Success.fromJson(data);

        if(context.mounted) {
          Snacks.successBar("Vos configurations ont bien été enregistrées", context);
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

  updateDisponibilities({required Map<String, dynamic> body, required BuildContext context}) async {
    setLoading(true);
    try {
      var data = await partnerUseCase.updateDisponibilities(body);

      if(data['error'] == false) {
        Success success = Success.fromJson(data);

        if(context.mounted) {
          Snacks.successBar("Vos configurations ont bien été modifiées", context);
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
    setMainLoading(true);
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

        Map<DetailPiece, bool> actionPieces = { for(var piece in pieces) piece : false };
        setActionPieces(actionPieces);

        setMainLoading(false);
      }else{
        Failure failure = Failure.fromJson(data);

        setMainLoading(false);
        if(context.mounted) {
          Snacks.failureBar(failure.message, context);
        }
      }
    } catch (e) {
      print(e);
      setMainLoading(false);
      Snacks.failureBar("Une erreur est survenue", context);
    }
  }

  getPiece({required String id, required BuildContext context}) async {
    setLoading(true);
    try {
      var data = await partnerUseCase.getPiece(id);

      if(data['error'] == false) {
        Success success = Success.fromJson(data);

        PieceInfo info = PieceInfo.fromJson(success.data);
        setPiece(info);
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