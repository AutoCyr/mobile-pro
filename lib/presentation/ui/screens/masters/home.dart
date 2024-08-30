import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label17.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label20.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label30.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class HomeDashScreen extends StatefulWidget {
  const HomeDashScreen({super.key});

  @override
  State<HomeDashScreen> createState() => _HomeDashScreenState();
}

class _HomeDashScreenState extends State<HomeDashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.menu_rounded,
                  color: GlobalThemeData.lightColorScheme.primaryContainer,
                ),
                Image.asset(
                  "assets/logos/auto.png",
                  width: 50,
                  height: 50,
                ),
                Icon(
                  Icons.notifications_on_rounded,
                  color: GlobalThemeData.lightColorScheme.primaryContainer,
                ),
              ]
            ).animate().fadeIn(),
            const Gap(20),
            Label20(
              text: "Tableau de bord",
              color: GlobalThemeData.lightColorScheme.secondaryContainer,
              weight: FontWeight.bold,
              maxLines: 1
            ).animate().fadeIn(),
            const Gap(10),
            Label14(
              text: "Maison LOG Pieces",
              color: GlobalThemeData.lightColorScheme.secondary,
              weight: FontWeight.normal,
              maxLines: 2
            ).animate().fadeIn(),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: size.width,
              height: 100,
              decoration: BoxDecoration(
                color: GlobalThemeData.lightColorScheme.onPrimary,
                border: Border.all(
                    color: GlobalThemeData.lightColorScheme.primaryContainer.withOpacity(0.5),
                    width: 1
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label14(
                        text: "Total pièces enregistrées",
                        color: GlobalThemeData.lightColorScheme.primaryContainer,
                        weight: FontWeight.bold,
                        maxLines: 1
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Label30(
                            text: "17",
                            color: GlobalThemeData.lightColorScheme.secondaryContainer,
                            weight: FontWeight.bold,
                            maxLines: 1
                        ),
                      ],
                    ),
                  ]
              ),
            ),
            const Gap(15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: size.width,
              height: 100,
              decoration: BoxDecoration(
                color: GlobalThemeData.lightColorScheme.onPrimary,
                border: Border.all(
                    color: GlobalThemeData.lightColorScheme.primaryContainer.withOpacity(0.5),
                    width: 1
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label14(
                        text: "Total commandes",
                        color: GlobalThemeData.lightColorScheme.primaryContainer,
                        weight: FontWeight.bold,
                        maxLines: 1
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Label30(
                            text: "40",
                            color: GlobalThemeData.lightColorScheme.secondaryContainer,
                            weight: FontWeight.bold,
                            maxLines: 1
                        ),
                      ],
                    ),
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
