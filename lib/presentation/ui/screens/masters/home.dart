import 'package:autocyr_pro/presentation/notifier/auth_notifier.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label10.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label13.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label17.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label20.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label30.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_button.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_icon_button.dart';
import 'package:autocyr_pro/presentation/ui/organisms/overviews/large_overview.dart';
import 'package:autocyr_pro/presentation/ui/organisms/overviews/small_overview.dart';
import 'package:autocyr_pro/presentation/ui/organisms/selectors/selector.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/addresses/list.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/pieces/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeDashScreen extends StatefulWidget {
  const HomeDashScreen({super.key});

  @override
  State<HomeDashScreen> createState() => _HomeDashScreenState();
}

class _HomeDashScreenState extends State<HomeDashScreen> {

  List<Map> options = [
    {
      "label": "Pièces",
      "iconData": Icons.settings_outlined,
      "widget": const PieceListScreen()
    },
    {
      "label": "Commandes",
      "iconData": Icons.shopping_cart_checkout_rounded,
      "widget": null
    },
    {
      "label": "Demandes",
      "iconData": Icons.content_paste_go_rounded,
      "widget": null
    }
  ];

  bool visible = true;

  updateVisible() {
    setState(() {
      visible = !visible;
    });
  }

  updateFCM() async {
    final auth = Provider.of<AuthNotifier>(context, listen: false);
    await auth.updateFCM(context: context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateFCM();
    });
  }

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
                InkWell(
                  onTap: () => BottomSelector().showIconMenu(
                    context: context,
                    options: options,
                    title: "Options"
                  ),
                  splashColor: Colors.transparent,
                  child: Icon(
                    Icons.menu_rounded,
                    color: GlobalThemeData.lightColorScheme.primaryContainer,
                  ),
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
            const Gap(30),
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
            /*if(visible)
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 100,
                  decoration: BoxDecoration(
                    color: GlobalThemeData.lightColorScheme.errorContainer.withOpacity(0.6),
                    border: Border.all(
                      color: GlobalThemeData.lightColorScheme.onErrorContainer,
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Label14(
                            text: "Abonnement bientôt expiré",
                            color: GlobalThemeData.lightColorScheme.onErrorContainer,
                            weight: FontWeight.bold,
                            maxLines: 1
                          ),
                          GestureDetector(
                            onTap: () {
                              updateVisible();
                            },
                            child: Icon(
                              Icons.clear,
                              color: GlobalThemeData.lightColorScheme.onErrorContainer,
                              size: 24,
                            ),
                          )
                        ],
                      ),
                      const Gap(10),
                      Label12(
                        text: "Renouvelez votre abonnement pour continuer à profiter de nos services. \nMerci pour votre fidélité.",
                        color: GlobalThemeData.lightColorScheme.onErrorContainer,
                        weight: FontWeight.bold,
                        maxLines: 2
                      ),
                    ],
                  ),
                ).animate().fadeIn(),
                const Gap(20),
              ],
            ),*/
            Column(
              children: [
                Container(
                  width: size.width,
                  height: 150,
                  decoration: BoxDecoration(
                      color: GlobalThemeData.lightColorScheme.surfaceTint.withOpacity(0.7),
                      border: Border.all(
                        color: GlobalThemeData.lightColorScheme.surfaceTint,
                      )
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -120,
                        top: -40,
                        child: Image.asset(
                          "assets/pngs/map.png",
                          width: size.width * 0.8,
                          height: size.width * 0.8,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.7,
                              child: Label13(
                                  text: "Faites connaitre la position de vos boutiques",
                                  color: GlobalThemeData.lightColorScheme.onErrorContainer,
                                  weight: FontWeight.bold,
                                  maxLines: 2
                              ),
                            ),
                            const Gap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.width * 0.6,
                                  child: Label12(
                                      text: "Augmentez votre visibilité en permettant aux clients de facilement vous retrouver pour booster votre chiffre d'affaire.",
                                      color: GlobalThemeData.lightColorScheme.onErrorContainer,
                                      weight: FontWeight.normal,
                                      maxLines: 3
                                  ),
                                ),
                                CustomIconButton(
                                    icon: Icons.arrow_forward_ios_rounded,
                                    size: size,
                                    context: context,
                                    function: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddressListScreen())),
                                    iconColor: GlobalThemeData.lightColorScheme.primary,
                                    buttonColor: GlobalThemeData.lightColorScheme.onPrimary,
                                    backColor: GlobalThemeData.lightColorScheme.primary
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(),
                const Gap(20),
              ],
            ),
            LargeOverview(
              label: "Total pièces enregistrées",
              value: "17",
              icon: Icons.settings_rounded,
              size: size
            ).animate().fadeIn(),
            const Gap(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallOverview(
                    label: "Total commandes motos",
                    value: "07",
                    icon: Icons.motorcycle_rounded,
                    size: size
                ).animate().fadeIn(),
                SmallOverview(
                    label: "Total commandes auto",
                    value: "40",
                    icon: Icons.car_crash_rounded,
                    size: size
                ).animate().fadeIn()
              ],
            ),
            const Gap(5),
            LargeOverview(
                label: "Total interventions",
                value: "15",
                icon: Icons.scuba_diving_rounded,
                size: size
            ).animate().fadeIn(),
            const Gap(5),
            LargeOverview(
                label: "Total contacts établis",
                value: "75",
                icon: Icons.webhook_rounded,
                size: size
            ).animate().fadeIn(),
          ],
        ),
      ),
    );
  }
}
