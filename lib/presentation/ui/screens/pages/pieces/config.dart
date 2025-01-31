import 'package:autocyr_pro/domain/models/pieces/detail_piece.dart';
import 'package:autocyr_pro/presentation/notifier/auth_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/common_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/partner_notifier.dart';
import 'package:autocyr_pro/presentation/ui/atoms/buttons/progress_button.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label10.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label13.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label17.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label20.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PieceConfigScreen extends StatefulWidget {
  final DetailPiece detail;
  const PieceConfigScreen({super.key, required this.detail});

  @override
  State<PieceConfigScreen> createState() => _PieceConfigScreenState();
}

class _PieceConfigScreenState extends State<PieceConfigScreen> {

  List<int> autos = [];
  List<int> moteurs = [];
  List<Map<String, dynamic>> categories = [];

  retrieveCommons() async {
    final common = Provider.of<CommonNotifier>(context, listen: false);
    if(!common.filling) {
      if(common.autoTypes.isEmpty) {
        await common.retrieveAutoTypes(context: context);
      }
      if(common.enginCategories.isEmpty) {
        await common.retrieveEnginCategories(context: context);
      }
      if(common.motorTypes.isEmpty) {
        await common.retrieveMotorTypes(context: context);
      }
    }
  }

  _save() async {
    final partner = Provider.of<PartnerNotifier>(context, listen: false);
    final auth = Provider.of<AuthNotifier>(context, listen: false);

    Map<String, dynamic> body = {
      "partenaire_id" : auth.getPartenaire.partenaireId,
      "detail_piece_id" : widget.detail.detailPieceId,
      "autos" : autos,
      "categories" : categories,
      "moteurs" : moteurs
    };
    await partner.addDisponibilities(body: body, context: context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      retrieveCommons();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: GlobalThemeData.lightColorScheme.primary),
          backgroundColor: GlobalThemeData.lightColorScheme.onPrimary,
          title: Label14(text: "Configuration de la pièce", color: GlobalThemeData.lightColorScheme.primaryContainer, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
      ),
      body: Consumer2<CommonNotifier, PartnerNotifier>(
        builder: (context, common, partner, child) {

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            children: [
              Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  color: GlobalThemeData.lightColorScheme.inversePrimary,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                  border: Border.all(
                    color: GlobalThemeData.lightColorScheme.primaryContainer.withOpacity(0.5),
                    width: 1
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label12(text: "Récapitulatif de la pièce :", color: GlobalThemeData.lightColorScheme.primary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                    const Gap(10),
                    Label10(text: widget.detail.piece.nomPiece, color: GlobalThemeData.lightColorScheme.outline, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                    const Gap(5),
                    Label10(text: widget.detail.marque.name, color: GlobalThemeData.lightColorScheme.outline, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                    const Gap(5),
                    Label10(text: "${widget.detail.modelePiece} ${widget.detail.numeroPiece} ${widget.detail.anneePiece}", color: GlobalThemeData.lightColorScheme.outline, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                  ],
                ),
              ).animate().fadeIn(),
              const Gap(20),
              Label17(text: "Choisir les disponibilités", color: GlobalThemeData.lightColorScheme.outline, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
              const Gap(20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.7),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                ),
                child: Label12(text: "Types de véhicules", color: GlobalThemeData.lightColorScheme.onPrimary, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
              ),
              const Gap(10),
              common.filling ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label10(text: "Chargement des types de véhicules...", color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                    const Gap(10),
                    ProgressButton(
                        widthSize: size.width * 0.9,
                        context: context,
                        bgColor: GlobalThemeData.lightColorScheme.onPrimary,
                        shimmerColor: GlobalThemeData.lightColorScheme.primary
                    )
                  ]
                ).animate().fadeIn()
                  :
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: common.autoTypes.length,
                  itemBuilder: (context, index) {
                    var auto = common.autoTypes[index];
                    return Row(
                      children: [
                        Checkbox(
                          value: autos.contains(auto.id),
                          onChanged: (value) {
                            setState(() {
                              if(autos.contains(auto.id)) {
                                autos.remove(auto.id);
                              } else {
                                autos.add(auto.id);
                              }
                            });
                          },
                        ).animate().fadeIn(),
                        const Gap(10),
                        Label10(
                          text: auto.libelle,
                          color: autos.contains(auto.id) ? GlobalThemeData.lightColorScheme.primary : GlobalThemeData.lightColorScheme.secondary,
                          weight: autos.contains(auto.id) ? FontWeight.bold : FontWeight.normal,
                          maxLines: 1
                        ).animate().fadeIn(),
                      ],
                    );
                  }
                ),
              const Gap(20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.7),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                ),
                child: Label12(text: "Types de moteur", color: GlobalThemeData.lightColorScheme.onPrimary, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
              ),
              const Gap(10),
              common.filling ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label10(text: "Chargement des types de moteur...", color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                    const Gap(10),
                    ProgressButton(
                        widthSize: size.width * 0.9,
                        context: context,
                        bgColor: GlobalThemeData.lightColorScheme.onPrimary,
                        shimmerColor: GlobalThemeData.lightColorScheme.primary
                    )
                  ]
                ).animate().fadeIn()
                  :
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: common.motorTypes.length,
                  itemBuilder: (context, index) {
                    var motor = common.motorTypes[index];
                    return Row(
                      children: [
                        Checkbox(
                          value: moteurs.contains(motor.id),
                          onChanged: (value) {
                            setState(() {
                              if(moteurs.contains(motor.id)) {
                                moteurs.remove(motor.id);
                              } else {
                                moteurs.add(motor.id);
                              }
                            });
                          },
                        ).animate().fadeIn(),
                        const Gap(10),
                        Label10(
                          text: motor.libelle,
                          color: moteurs.contains(motor.id) ? GlobalThemeData.lightColorScheme.primary : GlobalThemeData.lightColorScheme.secondary,
                          weight: moteurs.contains(motor.id) ? FontWeight.bold : FontWeight.normal,
                          maxLines: 1
                        ).animate().fadeIn(),
                      ],
                    );
                  }
                ),
              const Gap(20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.7),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                ),
                child: Label12(text: "Catégories d'engin", color: GlobalThemeData.lightColorScheme.onPrimary, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
              ),
              const Gap(10),
              common.filling ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label10(text: "Chargement des catégories d'engin...", color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                    const Gap(10),
                    ProgressButton(
                        widthSize: size.width * 0.9,
                        context: context,
                        bgColor: GlobalThemeData.lightColorScheme.onPrimary,
                        shimmerColor: GlobalThemeData.lightColorScheme.primary
                    )
                  ]
                ).animate().fadeIn()
                  :
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: common.enginCategories.length,
                  itemBuilder: (context, index) {
                    var engin = common.enginCategories[index];

                    var categoryIndex = categories.indexWhere((category) => category["id"] == engin.id);
                    var isSelected = categoryIndex != -1;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      if (isSelected) {
                                        categories.removeAt(categoryIndex);
                                      } else {
                                        categories.add({
                                          "id": engin.id,
                                          "hybrid": 0,
                                        });
                                      }
                                    });
                                  },
                                ).animate().fadeIn(),
                                const Gap(10),
                                Label10(
                                    text: engin.libelle,
                                    color: isSelected ? GlobalThemeData.lightColorScheme.primary : GlobalThemeData.lightColorScheme.secondary,
                                    weight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    maxLines: 1
                                ).animate().fadeIn(),
                              ],
                            ),
                            if(isSelected)
                              Icon(Icons.arrow_drop_down_outlined, size: 20, color: GlobalThemeData.lightColorScheme.primary,).animate().fadeIn(),
                          ],
                        ),
                        if(isSelected)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Label10(
                                  text: "Utilisable avec hybride",
                                  color: categories[categoryIndex]["hybrid"] == 1 ? GlobalThemeData.lightColorScheme.primary : GlobalThemeData.lightColorScheme.secondary,
                                  weight: categories[categoryIndex]["hybrid"] == 1 ? FontWeight.bold : FontWeight.normal,
                                  maxLines: 1
                              ).animate().fadeIn(),
                              const Gap(5),
                              Checkbox(
                                value: categories[categoryIndex]["hybrid"] == 1 ? true : false,
                                onChanged: (value) {
                                  setState(() {
                                    categories[categoryIndex]["hybrid"] = value == true ? 1 : 0;
                                  });
                                },
                              ).animate().fadeIn(),
                            ],
                          )
                      ],
                    );
                  }
                ),
              const Gap(20),
              partner.loading ?
                ProgressButton(
                  widthSize: size.width * 0.9,
                  context: context,
                  bgColor: GlobalThemeData.lightColorScheme.onPrimary,
                  shimmerColor: GlobalThemeData.lightColorScheme.primary
                ).animate().fadeIn()
                  :
                SizedBox(
                  width: size.width,
                  child: CustomButton(
                      text: "Enregistrer",
                      size: size,
                      globalWidth: size.width * 0.9,
                      widthSize: size.width * 0.87,
                      backSize: size.width * 0.87,
                      context: context,
                      function: () => _save(),
                      textColor: GlobalThemeData.lightColorScheme.primary,
                      buttonColor: GlobalThemeData.lightColorScheme.onPrimary,
                      backColor: GlobalThemeData.lightColorScheme.primary
                  ).animate().fadeIn(),
                ),
            ],
          );
        }
      )
    );
  }
}
