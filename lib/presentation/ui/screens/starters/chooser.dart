import 'package:autocyr_pro/presentation/notifier/auth_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/common_notifier.dart';
import 'package:autocyr_pro/presentation/ui/atoms/buttons/small_button.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label17.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label20.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label30.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_button.dart';
import 'package:autocyr_pro/presentation/ui/organisms/starters/back.dart';
import 'package:autocyr_pro/presentation/ui/organisms/starters/overlay.dart';
import 'package:autocyr_pro/presentation/ui/screens/auths/login.dart';
import 'package:autocyr_pro/presentation/ui/screens/auths/register.dart';
import 'package:autocyr_pro/presentation/ui/screens/subscriptions/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ChooserScreen extends StatefulWidget {
  const ChooserScreen({super.key});

  @override
  State<ChooserScreen> createState() => _ChooserScreenState();
}

class _ChooserScreenState extends State<ChooserScreen> {

  bool? _isLoggedIn;

  _verifyConnection(BuildContext context) async {
    final auth = Provider.of<AuthNotifier>(context, listen: false);
    await auth.verifyConnection().then((value) async {
      setState(() {
        _isLoggedIn = value;
      });
      await _redirect(_isLoggedIn!);
    });
  }

  _redirect(bool isLoggedIn) async {
    if(isLoggedIn) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const ValidatorScreen()), (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verifyConnection(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<AuthNotifier>(
        builder: (context, auth, child) {
          return Stack(
            children: [
              BackBackground(size: size),
              BackGradientOverlay(size: size),
              Positioned(
                bottom: 10,
                child: Container(
                    width: size.width,
                    height: size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/logos/auto.png",
                                  width: 75,
                                ).animate().tint(color: GlobalThemeData.lightColorScheme.onPrimary).fadeIn(),
                                Label30(
                                    text: "Autocyr Pro".toUpperCase(),
                                    color: GlobalThemeData.lightColorScheme.onPrimary,
                                    weight: FontWeight.bold,
                                    maxLines: 1
                                ).animate().fadeIn(),
                                const Gap(15),
                                Label12(
                                    text: "Gagnez en visibilité et augmentez vos ventes de pièces détachées pour les acheteurs particuliers et mécaniciens",
                                    color: GlobalThemeData.lightColorScheme.onPrimary,
                                    weight: FontWeight.normal,
                                    maxLines: 4
                                ).animate().fadeIn(),
                                const Gap(40),
                                auth.loading ?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Label12(
                                        text: "Vérification de votre connexion...",
                                        color: GlobalThemeData.lightColorScheme.onPrimary,
                                        weight: FontWeight.bold,
                                        maxLines: 2
                                      ).animate().fadeIn()
                                    ],
                                  ).animate().fadeIn()
                                    :
                                  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomButton(
                                        text: "Connexion",
                                        size: size,
                                        globalWidth: size.width * 0.45,
                                        widthSize: size.width * 0.41,
                                        backSize: size.width * 0.43,
                                        context: context,
                                        function: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                                        textColor: GlobalThemeData.lightColorScheme.onPrimary,
                                        buttonColor: GlobalThemeData.lightColorScheme.primary,
                                        backColor: GlobalThemeData.lightColorScheme.onPrimary
                                    ).animate().fadeIn(),
                                    CustomButton(
                                        text: "Inscription",
                                        size: size,
                                        globalWidth: size.width * 0.45,
                                        widthSize: size.width * 0.41,
                                        backSize: size.width * 0.43,
                                        context: context,
                                        function: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen())),
                                        textColor: GlobalThemeData.lightColorScheme.primary,
                                        buttonColor: GlobalThemeData.lightColorScheme.onPrimary,
                                        backColor: GlobalThemeData.lightColorScheme.primary
                                    ).animate().fadeIn(),
                                  ],
                                )
                              ]
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ],
          );
        }
      )
    );
  }
}
