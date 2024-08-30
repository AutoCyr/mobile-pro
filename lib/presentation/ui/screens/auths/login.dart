import 'package:autocyr_pro/presentation/ui/atoms/fields/custom_field.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label13.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label20.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label30.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_button.dart';
import 'package:autocyr_pro/presentation/ui/screens/auths/register.dart';
import 'package:autocyr_pro/presentation/ui/screens/subscriptions/subscription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          SizedBox(height: size.height * 0.25),
          Row(
            children: [
              Image.asset(
                "assets/logos/auto.png",
                width: 100,
                height: 100,
              ).animate().fadeIn(),
            ],
          ),
          Label30(text: "Connexion", color: GlobalThemeData.lightColorScheme.primary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
          const Gap(40),
          CustomField(
            controller: _usernameController,
            keyboardType: TextInputType.emailAddress,
            label: "Email / Numéro de téléphone",
            fontSize: 12,
            icon: Icons.alternate_email,
          ).animate().fadeIn(),
          const Gap(30),
          CustomButton(
              text: "Se connecter",
              size: size,
              globalWidth: size.width * 0.9,
              widthSize: size.width * 0.87,
              backSize: size.width * 0.87,
              context: context,
              function: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SubscriptionChoiceScreen()), (route) => false),
              textColor: GlobalThemeData.lightColorScheme.primary,
              buttonColor: GlobalThemeData.lightColorScheme.onPrimary,
              backColor: GlobalThemeData.lightColorScheme.primary
          ).animate().fadeIn(),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Label12(text: "Vous n'avez pas de compte ?", color: Colors.black, weight: FontWeight.normal, maxLines: 1).animate().fadeIn(),
              TextButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterScreen())),
                child: Label12(text: "Créer un compte", color: GlobalThemeData.lightColorScheme.primary, weight: FontWeight.bold, maxLines: 1)
              ).animate().fadeIn()
            ]
          )
        ],
      ),
    );
  }
}
