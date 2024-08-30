import 'package:autocyr_pro/presentation/ui/atoms/labels/label13.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label17.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label20.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label30.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_button.dart';
import 'package:autocyr_pro/presentation/ui/screens/masters/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class ValidatorScreen extends StatefulWidget {
  final Map<String, dynamic> selectedSubscription;
  const ValidatorScreen({super.key, required this.selectedSubscription});

  @override
  State<ValidatorScreen> createState() => _ValidatorScreenState();
}

class _ValidatorScreenState extends State<ValidatorScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: GlobalThemeData.lightColorScheme.primary),
        backgroundColor: GlobalThemeData.lightColorScheme.onPrimary,
        title: Label14(text: "Validation de la souscription", color: GlobalThemeData.lightColorScheme.primaryContainer, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          height: size.height - kToolbarHeight,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Label30(
                  text: "Maison LOG Pieces",
                  color: GlobalThemeData.lightColorScheme.secondaryContainer,
                  weight: FontWeight.bold,
                  maxLines: 2
              ).animate().fadeIn(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Label14(
                      text: "Récapitulatif de votre offre :",
                      color: GlobalThemeData.lightColorScheme.outline,
                      weight: FontWeight.bold,
                      maxLines: 2
                  ),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    width: size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      color: GlobalThemeData.lightColorScheme.onPrimary,
                      border: Border.all(
                        color: GlobalThemeData.lightColorScheme.primaryContainer.withOpacity(0.2),
                        width: 1
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Label20(
                              text: widget.selectedSubscription["title"],
                              color: GlobalThemeData.lightColorScheme.primaryContainer,
                              weight: FontWeight.normal,
                              maxLines: 1
                          ),
                          const Gap(10),
                          Label30(
                              text: widget.selectedSubscription["price"],
                              color: GlobalThemeData.lightColorScheme.secondaryContainer,
                              weight: FontWeight.bold,
                              maxLines: 1
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                "assets/logos/auto.png",
                                width: 50,
                                height: 50,
                              ).animate().fadeIn(),
                            ],
                          ),
                        ]
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Label14(
                      text: "Merci d'avoir souscrit à notre offre... Nous mettons tout en œuvre pour activer votre accès dans les plus brefs délais. Veuillez nous contacter très tôt pour avoir les détails concernant les transactions. Nous apprécions votre patience et votre confiance.",
                      color: GlobalThemeData.lightColorScheme.outline,
                      weight: FontWeight.normal,
                      maxLines: 5
                  ),
                  const Gap(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Label14(
                          text: "L'équipe AUTOCYR.",
                          color: GlobalThemeData.lightColorScheme.outline,
                          weight: FontWeight.bold,
                          maxLines: 5
                      ),
                    ],
                  ),
                ],
              ),
              CustomButton(
                  text: "Accéder à mon espace",
                  size: size,
                  globalWidth: size.width,
                  widthSize: size.width * 0.87,
                  backSize: size.width * 0.87,
                  context: context,
                  function: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeDashScreen()), (route) => false),
                  textColor: GlobalThemeData.lightColorScheme.primary,
                  buttonColor: GlobalThemeData.lightColorScheme.onPrimary,
                  backColor: GlobalThemeData.lightColorScheme.primary
              ).animate().fadeIn(),
            ],
          ),
        ),
      ),
    );
  }
}
