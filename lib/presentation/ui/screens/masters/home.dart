import 'package:autocyr_pro/data/helpers/data_loaders.dart';
import 'package:autocyr_pro/presentation/notifier/auth_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/common_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/partner_notifier.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label10.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label13.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label17.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label20.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label30.dart';
import 'package:autocyr_pro/presentation/ui/atoms/loaders/loading_ads.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_button.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_icon_button.dart';
import 'package:autocyr_pro/presentation/ui/organisms/banners/blurred_banner.dart';
import 'package:autocyr_pro/presentation/ui/organisms/overviews/large_overview.dart';
import 'package:autocyr_pro/presentation/ui/organisms/overviews/small_overview.dart';
import 'package:autocyr_pro/presentation/ui/organisms/selectors/selector.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/addresses/list.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/commandes/commandes.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/pieces/list.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/publicites/detail.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/requests/requests.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeDashScreen extends StatefulWidget {
  const HomeDashScreen({super.key});

  @override
  State<HomeDashScreen> createState() => _HomeDashScreenState();
}

class _HomeDashScreenState extends State<HomeDashScreen> {

  int view = 0;

  Map<String, dynamic> getParams(int view) {
    Map<String, dynamic> params = {
      "page": view,
      "limit": 5000
    };
    return params;
  }

  List<Map> options = [
    {
      "label": "Pièces",
      "iconData": Icons.settings_outlined,
      "widget": const PieceListScreen()
    },
    {
      "label": "Commandes",
      "iconData": Icons.shopping_cart_checkout_rounded,
      "widget": const CommandeListScreen()
    },
    {
      "label": "Demandes",
      "iconData": Icons.content_paste_go_rounded,
      "widget": const RequestListScreen()
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

  loadDatas(int view, bool more) async {
    final partner = Provider.of<PartnerNotifier>(context, listen: false);

    Map<String, dynamic> params = getParams(view);

    // Liste des futures à exécuter en parallèle
    List<Future<void>> futures = [];

    futures.add(DataLoaders().loadDataFor(context: context, condition: partner.pieces.isEmpty, params: params, retrieveFunction: partner.getPieces, more: more));
    futures.add(DataLoaders().loadDataFor(context: context, condition: partner.commandes.isEmpty, params: params, retrieveFunction: partner.retrieveCommandes, more: more));
    futures.add(DataLoaders().loadDataFor(context: context, condition: partner.requests.isEmpty, params: params, retrieveFunction: partner.retrieveRequests, more: more));

    // Exécution en parallèle
    await Future.wait(futures);
  }

  retrieveCommons() async {
    final common = Provider.of<CommonNotifier>(context, listen: false);
    if(!common.filling) {
      if(common.publicites.isEmpty) {
        await common.retrievePublicites(context: context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateFCM();
      view++;
      loadDatas(view, false);
      retrieveCommons();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Label12(text: "Appuyez encore pour fermer l'application", color: Colors.white, weight: FontWeight.bold, maxLines: 2),
        ),
        child: Consumer3<AuthNotifier, PartnerNotifier, CommonNotifier>(
          builder: (context, auth, partner, common, child) {

            return SafeArea(
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
                            color: GlobalThemeData.lightColorScheme.primary,
                          ),
                        ),
                        Image.asset(
                          "assets/logos/auto.png",
                          width: 50,
                          height: 50,
                        )
                      ]
                  ).animate().fadeIn(),
                  const Gap(30),
                  Column(
                    children: [
                      if(common.filling && common.publicites.isEmpty)
                        LoadingAds(
                            widthSize: size.width,
                            heightSize: size.height * 0.25,
                            context: context,
                            bgColor: GlobalThemeData.lightColorScheme.primary.withOpacity(0.1),
                            shimmerColor: GlobalThemeData.lightColorScheme.primary
                        ).animate().fadeIn(),

                      if(!common.filling && common.publicites.isEmpty)
                        Label14(text: "Aucune annonce trouvée", color: Colors.black, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),

                      if(common.publicites.isNotEmpty)
                        FlutterCarousel(
                          options: FlutterCarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 10),
                              disableCenter: true,
                              viewportFraction: 1,
                              height: size.height * 0.25,
                              indicatorMargin: 10,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                              autoPlayCurve: Curves.slowMiddle,
                              slideIndicator: CircularSlideIndicator(
                                slideIndicatorOptions: const SlideIndicatorOptions(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    itemSpacing: 10,
                                    indicatorRadius: 4,
                                    alignment: Alignment.topRight
                                ),
                              ),
                              onPageChanged: (index, r) {
                                setState(() {
                                });
                              }
                          ),
                          items: common.publicites.map((e) {
                            return InkWell(
                                splashColor: Colors.transparent,
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PubliciteDetailScreen(publicite: e))),
                                child: BlurredBanner(imageUrl: e.banner)
                            );
                          }).toList(),
                        ).animate().fadeIn(),
                    ],
                  ),
                  const Gap(20),
                  Label20(
                      text: auth.getPartenaire.raisonSociale,
                      color: GlobalThemeData.lightColorScheme.secondary,
                      weight: FontWeight.bold,
                      maxLines: 1
                  ).animate().fadeIn(),
                  const Gap(10),
                  Column(
                    children: [
                      Container(
                        width: size.width,
                        height: 175,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: GlobalThemeData.lightColorScheme.surfaceTint,
                            )
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                "assets/images/banner.webp",
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                // Ignorer les métadonnées d'orientation
                                excludeFromSemantics: true,
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                ),
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
                                        text: "Ajoutez les adresses de vos boutiques",
                                        color: GlobalThemeData.lightColorScheme.onSecondary,
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
                                            color: GlobalThemeData.lightColorScheme.onSecondary,
                                            weight: FontWeight.normal,
                                            maxLines: 3
                                        ),
                                      ),
                                      CustomIconButton(
                                          icon: Icons.arrow_forward_ios_rounded,
                                          size: size,
                                          context: context,
                                          function: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddressListScreen())),
                                          iconColor: GlobalThemeData.lightColorScheme.onPrimary,
                                          buttonColor: GlobalThemeData.lightColorScheme.primary,
                                          backColor: GlobalThemeData.lightColorScheme.onPrimary
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
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              GlobalThemeData.lightColorScheme.primary.withOpacity(0.2),
                              Colors.transparent
                            ]
                        ),
                      ),
                      child: Label17(text: "Tableau de bord", color: GlobalThemeData.lightColorScheme.primary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn()
                  ),
                  const Gap(20),
                  LargeOverview(
                    context: context,
                    label: "Pièces enregistrées",
                    value: partner.mainLoading && partner.pieces.isEmpty ? "..." : partner.pieces.length.toString(),
                    icon: "assets/pngs/asset_1.png",
                    size: size,
                    child: const PieceListScreen(),
                    bgColor: GlobalThemeData.lightColorScheme.onPrimary
                  ).animate().fadeIn(),
                  const Gap(5),
                  LargeOverview(
                      context: context,
                      label: "Commandes",
                      value: partner.loading && partner.commandes.isEmpty ? "..." : partner.commandes.length.toString(),
                      icon: "assets/pngs/asset_3.png",
                      size: size,
                      child: const CommandeListScreen(),
                      bgColor: GlobalThemeData.lightColorScheme.onPrimary
                  ).animate().fadeIn(),
                  const Gap(5),
                  LargeOverview(
                    context: context,
                    label: "Interventions",
                    value: partner.loading && partner.requests.isEmpty ? "..." : partner.requests.length.toString(),
                    icon: "assets/pngs/asset_4.png",
                    size: size,
                    child: const RequestListScreen(),
                    bgColor: GlobalThemeData.lightColorScheme.onPrimary
                  ).animate().fadeIn(),
                  const Gap(5),
                  LargeOverview(
                    context: context,
                    label: "Contacts établis",
                    value: partner.loading && partner.commandes.isEmpty ? "..." : partner.commandes.length.toString(),
                    icon: "assets/pngs/asset_5.png",
                    size: size,
                    bgColor: GlobalThemeData.lightColorScheme.primary.withOpacity(0.1)
                  ).animate().fadeIn(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: "© Autocyr 2025",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Lufga",
                            ),
                          ),
                        )
                      ],
                    ),
                  ).animate().fadeIn(),
                ],
              ),
            );
          }
        ),
      )
    );
  }
}
