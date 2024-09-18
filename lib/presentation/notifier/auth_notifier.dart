import 'dart:convert';
import 'package:autocyr_pro/data/helpers/notifications.dart';
import 'package:autocyr_pro/data/helpers/preferences.dart';
import 'package:autocyr_pro/domain/models/profile/partenaire.dart';
import 'package:autocyr_pro/domain/models/profile/user.dart';
import 'package:autocyr_pro/domain/models/response/failure.dart';
import 'package:autocyr_pro/domain/models/response/success.dart';
import 'package:autocyr_pro/domain/usecases/auth_usecase.dart';
import 'package:autocyr_pro/presentation/notifier/common_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/subscription_notifier.dart';
import 'package:autocyr_pro/presentation/ui/helpers/snacks.dart';
import 'package:autocyr_pro/presentation/ui/screens/auths/login.dart';
import 'package:autocyr_pro/presentation/ui/screens/masters/home.dart';
import 'package:autocyr_pro/presentation/ui/screens/starters/chooser.dart';
import 'package:autocyr_pro/presentation/ui/screens/subscriptions/validator.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class AuthNotifier extends ChangeNotifier {

  final AuthUseCase authUseCase;
  AuthNotifier({required this.authUseCase});

  bool _loading = false;
  User? user;
  Partenaire? partenaire;

  bool get loading => _loading;
  User get getUser => user!;
  Partenaire get getPartenaire => partenaire!;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setUser(User value) {
    user = value;
    notifyListeners();
  }

  setPartenaire(Partenaire value) {
    partenaire = value;
    notifyListeners();
  }

  Future verifyConnection() async {
    setLoading(true);
    final userJson = await Preferences().getString('user') ?? '';
    final partenaireJson = await Preferences().getString('partenaire') ?? '';

    if (userJson != '' && partenaireJson != '') {
      User user = User.fromJson(json.decode(userJson));
      Partenaire partenaire = Partenaire.fromJson(json.decode(partenaireJson));

      setUser(user);
      setPartenaire(partenaire);

      setLoading(false);
      return true;
    } else {
      setLoading(false);
      return false;
    }
  }

  Future login({required Map<String, dynamic> body, required LocalAuthentication localAuth, required BuildContext context}) async {
    setLoading(true);
    try {
      var data = await authUseCase.login(body);

      if(data['error'] == false) {
        Success success = Success.fromJson(data);

        if(success.data.containsKey("partenaire")) {
          await Future.wait([
            saveToPreferences("user", success.data["user"]),
            saveToPreferences("partenaire", success.data["partenaire"])
          ]);
          await Preferences().saveString("token", success.data['token']);

          await setUser(User.fromJson(success.data["user"]));
          await setPartenaire(Partenaire.fromJson(success.data["partenaire"]));

          setLoading(false);
          if(context.mounted) {
            await myAuthentication(context: context, local: localAuth);
          }
        } else {
          if(context.mounted) {
            Snacks.failureBar("Vous n'avez pas l'autorisation requise.", context);
          }
          setLoading(false);
        }
      }else{
        Failure failure = Failure.fromJson(data);

        if(context.mounted) {
          Snacks.failureBar(failure.message, context);
        }
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      Snacks.failureBar("Une erreur est survenue", context);
    }
  }

  Future register({required Map<String, dynamic> body, required BuildContext context}) async {
    setLoading(true);
    try {
      var data = await authUseCase.register(body);

      if(data['error'] == false) {
        Success success = Success.fromJson(data);

        setLoading(false);
        if (context.mounted) {
          Snacks.successBar(success.message, context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      }else{
        Failure failure = Failure.fromJson(data);
        if(context.mounted) {
          Snacks.failureBar(failure.message, context);
        }
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      Snacks.failureBar("Une erreur est survenue", context);
    }
  }

  Future logout({required BuildContext context}) async {
    await Preferences().clear();

    if(context.mounted){
      Snacks.successBar("Déconnexion effectuée. Bonne journée.", context);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ChooserScreen()), (route) => false);
    }
  }

  Future updateFCM({required BuildContext context}) async {
    setLoading(true);
    try {
      if(context.mounted) {
        Snacks.infoBar("Mise à jour des données...", context);
      }
      var token = await Notifications().getFCMToken();
      Map<String, dynamic> body = {
        "id": getUser.id,
        "token": token
      };
      var data = await authUseCase.updateFCMToken(body);
      if(data['error'] == false) {
        Success success = Success.fromJson(data);

        setLoading(false);
        if (context.mounted) {
          Snacks.successBar(success.message, context);
        }
      }else{
        Failure failure = Failure.fromJson(data);
        if(context.mounted) {
          Snacks.failureBar(failure.message, context);
        }
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
    }

  }

  Future<void> saveToPreferences(String key, dynamic value) async {
    await Preferences().saveString(key, jsonEncode(value));
  }

  Future myAuthentication({required BuildContext context, required LocalAuthentication local}) async {

    try {
      bool isAuthenticated = await local.authenticate(
        localizedReason: "Pour plus de sécurité, procéder à la vérification",
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
          sensitiveTransaction: true
        ),
      );

      if(isAuthenticated){
        if(context.mounted) {
          Snacks.successBar("Connexion réussie", context);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ValidatorScreen()), (route) => false);
        }
      }else{
        Snacks.failureBar("Veuillez vérifier votre identité", context);
      }
    } catch (e) {
      Snacks.failureBar("Une erreur est survenue", context);
    }

  }


}