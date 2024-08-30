import 'package:autocyr_pro/presentation/ui/atoms/labels/label13.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label17.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label20.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label30.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/small_custom_button.dart';
import 'package:autocyr_pro/presentation/ui/screens/subscriptions/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class SubscriptionChoiceScreen extends StatefulWidget {
  const SubscriptionChoiceScreen({super.key});

  @override
  State<SubscriptionChoiceScreen> createState() => _SubscriptionChoiceScreenState();
}

class _SubscriptionChoiceScreenState extends State<SubscriptionChoiceScreen> {

  Map<String, dynamic>? _selectedSubscription;
  List<Map<String, dynamic>> subscriptions = [
    {
      "title": "Mensuel",
      "price": "50000 FCFA",
    },
    {
      "title": "Bimestriel",
      "price": "100000 FCFA",
    },
    {
      "title": "Trimestriel",
      "price": "250000 FCFA",
    },
    {
      "title": "Semestriel",
      "price": "500000 FCFA",
    },
    {
      "title": "Annuel",
      "price": "1000000 FCFA",
    }
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          const Gap(kToolbarHeight),
          Label17(
            text: "Bienvenue",
            color: GlobalThemeData.lightColorScheme.secondary,
            weight: FontWeight.bold,
            maxLines: 2
          ).animate().fadeIn(),
          Label30(
            text: "Maison LOG Pieces",
            color: GlobalThemeData.lightColorScheme.primaryContainer,
            weight: FontWeight.bold,
            maxLines: 2
          ).animate().fadeIn(),
          const Gap(20),
          Label14(
            text: "Accédez à des fonctionnalités avancées, élargissez votre clientèle de mécaniciens et d'acheteurs particuliers, et augmentez vos ventes en souscrivant à nos offres d'abonnement.",
            color: GlobalThemeData.lightColorScheme.outline,
            weight: FontWeight.normal,
            maxLines: 10
          ).animate().fadeIn(),
          const Gap(20),
          Label14(
              text: "Choisissez un plan de souscription",
              color: GlobalThemeData.lightColorScheme.secondary,
              weight: FontWeight.bold,
              maxLines: 2
          ).animate().fadeIn(),
          const Gap(15),
          ...subscriptions.map((e) => InkWell(
            onTap: () {
              setState(() {
                _selectedSubscription = e;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: size.width,
              height: 70,
              decoration: BoxDecoration(
                color: _selectedSubscription == e ? GlobalThemeData.lightColorScheme.primaryContainer : GlobalThemeData.lightColorScheme.onPrimary,
                border: Border.all(
                  color: _selectedSubscription == e ? GlobalThemeData.lightColorScheme.onPrimary.withOpacity(0.2) : GlobalThemeData.lightColorScheme.primaryContainer.withOpacity(0.2),
                  width: 1
                ),
              ),
              child: Row(
                children: [
                  const Gap(5),
                  _selectedSubscription == e ? Icon(Icons.radio_button_on_rounded, color: GlobalThemeData.lightColorScheme.onPrimary, size: 24.0) : Icon(Icons.radio_button_off_rounded, color: GlobalThemeData.lightColorScheme.outline, size: 24.0),
                  const Gap(15),
                  SizedBox(
                    width: size.width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Label13(
                          text: e["title"],
                          color: _selectedSubscription == e ? GlobalThemeData.lightColorScheme.onPrimary : GlobalThemeData.lightColorScheme.primaryContainer,
                          weight: FontWeight.normal,
                          maxLines: 1
                        ),
                        const Gap(5),
                        Label20(
                          text: e["price"],
                          color: _selectedSubscription == e ? GlobalThemeData.lightColorScheme.onPrimary : GlobalThemeData.lightColorScheme.secondaryContainer,
                          weight: FontWeight.bold,
                          maxLines: 1
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ).animate().fadeIn(),
          )),
          const Gap(20),
          if(_selectedSubscription != null)
            SmallCustomButton(
            text: "Valider",
            size: size,
            globalWidth: size.width * 0.9,
            widthSize: size.width * 0.87,
            backSize: size.width * 0.87,
            context: context,
            function: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ValidatorScreen(selectedSubscription: _selectedSubscription!))),
            textColor: GlobalThemeData.lightColorScheme.primary,
            buttonColor: GlobalThemeData.lightColorScheme.onPrimary,
            backColor: GlobalThemeData.lightColorScheme.primary
          ).animate().fadeIn(),
        ],
      ),
    );
  }
}
