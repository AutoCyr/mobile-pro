import 'package:autocyr_pro/domain/models/core/plan.dart';
import 'package:autocyr_pro/presentation/notifier/auth_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/common_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/partner_notifier.dart';
import 'package:autocyr_pro/presentation/ui/atoms/buttons/progress_button.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label13.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label17.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label20.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label30.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_button.dart';
import 'package:autocyr_pro/presentation/ui/screens/subscriptions/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SubscriptionChoiceScreen extends StatefulWidget {
  final bool isFree;
  const SubscriptionChoiceScreen({super.key, required this.isFree});

  @override
  State<SubscriptionChoiceScreen> createState() => _SubscriptionChoiceScreenState();
}

class _SubscriptionChoiceScreenState extends State<SubscriptionChoiceScreen> {

  Plan? _selectedPlan;

  _save(BuildContext context) async {
    final partner = Provider.of<PartnerNotifier>(context, listen: false);
    final auth = Provider.of<AuthNotifier>(context, listen: false);
    Map<String, dynamic> body = {
      "abonnement_id": _selectedPlan!.id,
      "partenaire_id": auth.getPartenaire.partenaireId,
      "statut": widget.isFree ? 1 : 0
    };
    print(body);
    // await partner.addSubscription(body: body, plan: _selectedPlan!, context: context);
  }

  _retrievePlans(BuildContext context) async {
    final common = Provider.of<CommonNotifier>(context, listen: false);
    widget.isFree ? await common.retrieveFreePlans(context: context) : await common.retrievePlans(context: context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _retrievePlans(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer3<AuthNotifier, CommonNotifier, PartnerNotifier>(
        builder: (context, auth, common, partner, child) {
          if(common.filling) {
            return SizedBox(
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProgressButton(
                      widthSize: size.width * 0.9,
                      context: context,
                      bgColor: GlobalThemeData.lightColorScheme.onPrimary,
                      shimmerColor: GlobalThemeData.lightColorScheme.primary
                  ).animate().fadeIn(),
                  const Gap(20),
                  Label12(
                      text: "Récupération des plans...",
                      color: Colors.black,
                      weight: FontWeight.bold,
                      maxLines: 2
                  ).animate().fadeIn()
                ],
              ),
            );
          }

          if(common.plans.isEmpty) {
            return ListView(
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
                    text: auth.getPartenaire.raisonSociale,
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
                const Gap(30),
                Label14(
                  text: "Aucun plan disponible pour le moment. Veuillez attendre que nous ajoutons des offres. \nMerci de votre patience.",
                  color: GlobalThemeData.lightColorScheme.outline,
                  weight: FontWeight.normal,
                  maxLines: 10
                ).animate().fadeIn(),
              ],
            );
          }

          return ListView(
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
                  text: auth.getPartenaire.raisonSociale,
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
                  text: widget.isFree ? "Choisissez un plan gratuit" : "Choisissez un plan de souscription",
                  color: GlobalThemeData.lightColorScheme.secondary,
                  weight: FontWeight.bold,
                  maxLines: 2
              ).animate().fadeIn(),
              const Gap(15),
              ...common.plans.map((e) => InkWell(
                onTap: () {
                  setState(() {
                    _selectedPlan = e;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  width: size.width,
                  decoration: BoxDecoration(
                    color: _selectedPlan == e ? GlobalThemeData.lightColorScheme.primaryContainer : GlobalThemeData.lightColorScheme.onPrimary,
                    border: Border.all(
                        color: _selectedPlan == e ? GlobalThemeData.lightColorScheme.onPrimary.withOpacity(0.2) : GlobalThemeData.lightColorScheme.primaryContainer.withOpacity(0.2),
                        width: 1
                    ),
                  ),
                  child: Row(
                    children: [
                      const Gap(5),
                      _selectedPlan == e ? Icon(Icons.radio_button_on_rounded, color: GlobalThemeData.lightColorScheme.onPrimary, size: 24.0) : Icon(Icons.radio_button_off_rounded, color: GlobalThemeData.lightColorScheme.outline, size: 24.0),
                      const Gap(15),
                      SizedBox(
                        width: size.width * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Label13(
                                text: e.libelle,
                                color: _selectedPlan == e ? GlobalThemeData.lightColorScheme.onPrimary : GlobalThemeData.lightColorScheme.primaryContainer,
                                weight: FontWeight.normal,
                                maxLines: 1
                            ),
                            if(widget.isFree == false)
                              Column(
                                children: [
                                  const Gap(5),
                                  Label20(
                                      text: "${e.montant} FCFA",
                                      color: _selectedPlan == e ? GlobalThemeData.lightColorScheme.onPrimary : GlobalThemeData.lightColorScheme.secondaryContainer,
                                      weight: FontWeight.bold,
                                      maxLines: 1
                                  ),
                                ],
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ).animate().fadeIn(),
              )),
              const Gap(20),
              if(_selectedPlan != null)
                partner.loading ?
                  ProgressButton(
                    widthSize: size.width * 0.9,
                    context: context,
                    bgColor: GlobalThemeData.lightColorScheme.onPrimary,
                    shimmerColor: GlobalThemeData.lightColorScheme.primary
                  ).animate().fadeIn()
                    :
                  CustomButton(
                    text: "Valider",
                    size: size,
                    globalWidth: size.width * 0.9,
                    widthSize: size.width * 0.87,
                    backSize: size.width * 0.87,
                    context: context,
                    function: () => _save(context),
                    textColor: GlobalThemeData.lightColorScheme.primary,
                    buttonColor: GlobalThemeData.lightColorScheme.onPrimary,
                    backColor: GlobalThemeData.lightColorScheme.primary
                  ).animate().fadeIn(),
            ],
          );
        }
      )
    );
  }
}
