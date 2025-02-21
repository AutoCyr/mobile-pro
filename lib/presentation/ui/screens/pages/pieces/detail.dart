import 'package:autocyr_pro/data/network/urls.dart';
import 'package:autocyr_pro/domain/models/pieces/detail_piece.dart';
import 'package:autocyr_pro/presentation/notifier/partner_notifier.dart';
import 'package:autocyr_pro/presentation/ui/atoms/buttons/progress_button.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label10.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label13.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label17.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/helpers/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class DetailPieceScreen extends StatefulWidget {
  final DetailPiece detail;
  const DetailPieceScreen({super.key, required this.detail});

  @override
  State<DetailPieceScreen> createState() => _DetailPieceScreenState();
}

class _DetailPieceScreenState extends State<DetailPieceScreen> {

  retrievePieceDetails() async {
    final partner = Provider.of<PartnerNotifier>(context, listen: false);
    await partner.getPiece(id: widget.detail.detailPieceId.toString(), context: context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      retrievePieceDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: GlobalThemeData.lightColorScheme.primary),
        backgroundColor: GlobalThemeData.lightColorScheme.onPrimary,
        title: Label14(text: "Détail de la pièce", color: GlobalThemeData.lightColorScheme.primaryContainer, weight: FontWeight.bold, maxLines: 1).animate().fadeIn()
      ),
      body: Consumer<PartnerNotifier>(
        builder: (context, partner, child) {
          if(partner.loading) {
            return SizedBox(
              width: size.width,
              height: size.height - kToolbarHeight,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProgressButton(
                        widthSize: size.width * 0.9,
                        context: context,
                        bgColor: GlobalThemeData.lightColorScheme.onPrimary,
                        shimmerColor: GlobalThemeData.lightColorScheme.primary
                    ),
                    const Gap(20),
                    Label10(text: "Chargement des informations de la pièce...", color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.bold, maxLines: 2),
                  ]
              ).animate().fadeIn(),
            );
          }

          if(partner.piece == null && !partner.loading) {
            return const StateScreen(icon: Icons.more_horiz, message: "Détails de la pièce non trouvée.", isError: false,);
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width * 0.6,
                    height: size.width * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                      border: Border.all(color: GlobalThemeData.lightColorScheme.primaryContainer, width: 1),
                      image: DecorationImage(
                        onError: (Object e, StackTrace? stackTrace) => Image.asset(
                          "assets/images/back-2.webp",
                          fit: BoxFit.cover,
                        ),
                        image: NetworkImage(
                          Urls.imageUrl+partner.piece!.imagePiece,
                        ),
                        fit: BoxFit.cover
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: size.width * 0.6,
                          decoration: BoxDecoration(
                            color: partner.piece!.statut == 1 ? Colors.green : GlobalThemeData.lightColorScheme.errorContainer,
                          ),
                          child: Center(
                            child: Label12(
                                text: partner.piece!.statut == 1 ? "Actif" : "Inactif",
                                color:GlobalThemeData.lightColorScheme.onPrimary,
                                weight: FontWeight.bold,
                                maxLines: 1
                            ).animate().fadeIn(),
                          ),
                        )
                      ],
                    ),
                  ).animate().fadeIn(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        width: size.width * 0.3,
                        decoration: BoxDecoration(
                            color: GlobalThemeData.lightColorScheme.surfaceTint
                        ),
                        child: Center(
                          child: Label12(
                              text: partner.piece!.typeEngin.libelle,
                              color: GlobalThemeData.lightColorScheme.onPrimary,
                              weight: FontWeight.bold,
                              maxLines: 1
                          ).animate().fadeIn(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Gap(20),
              Label17(text: "Informations sur la pièce", color: GlobalThemeData.lightColorScheme.onSurface, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
              const Gap(10),
              Label13(text: "Prix - ${partner.piece!.prixPiece} FCFA", color: GlobalThemeData.lightColorScheme.outline, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
              const Gap(10),
              Label13(text: partner.piece!.garantie == 1 ? "Pièce garantie" : "Pièce non garantie", color: GlobalThemeData.lightColorScheme.outline, weight: FontWeight.normal, maxLines: 2).animate().fadeIn(),
              const Gap(10),
              Label13(text: partner.piece!.autres ?? "Pas d'autres informations disponible", color: GlobalThemeData.lightColorScheme.outline, weight: FontWeight.normal, maxLines: 20).animate().fadeIn(),
              if(partner.piece!.autos!.isNotEmpty || partner.piece!.moteurs!.isNotEmpty || partner.piece!.categories!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Label17(text: "Disponibilités de la pièce", color: GlobalThemeData.lightColorScheme.onSurface, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(10),
                        Container(
                          width: size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.7),
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                          ),
                          child: Label12(text: "Marques compatibles", color: GlobalThemeData.lightColorScheme.onPrimary, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
                        ),
                        const Gap(10),
                        if(partner.piece!.marques!.isNotEmpty && partner.piece!.marques != null)
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              ...partner.piece!.marques!.map((e) => Container(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: GlobalThemeData.lightColorScheme.inversePrimary,
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                                ),
                                child: Label10(text: e.marque.name, color: GlobalThemeData.lightColorScheme.outline, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                              )),
                            ],
                          )
                        else
                          Label12(text: "Disponible pour toutes les marques correspondant au type d'engin choisi", color: Colors.green.shade700, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
                        const Gap(10),
                      ],
                    ),
                    if(partner.piece!.autos!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(10),
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.7),
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                            ),
                            child: Label12(text: "Types de véhicules", color: GlobalThemeData.lightColorScheme.onPrimary, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
                          ),
                          const Gap(10),
                          ...partner.piece!.autos!.map((e) => Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline, size: 20, color: GlobalThemeData.lightColorScheme.outline,).animate().fadeIn(),
                                const Gap(10),
                                Label12(text: e.typeAuto.libelle, color: GlobalThemeData.lightColorScheme.outline, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                              ],
                            ).animate().fadeIn(),
                          )).toList(),
                        ],
                      ),
                    if(partner.piece!.moteurs!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(10),
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.7),
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                            ),
                            child: Label12(text: "Types de moteur", color: GlobalThemeData.lightColorScheme.onPrimary, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
                          ),
                          const Gap(10),
                          ...partner.piece!.moteurs!.map((e) => Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline, size: 20, color: GlobalThemeData.lightColorScheme.outline,).animate().fadeIn(),
                                const Gap(10),
                                Label12(text: e.typeMoteur.libelle, color: GlobalThemeData.lightColorScheme.outline, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                              ],
                            ).animate().fadeIn(),
                          )).toList(),
                        ],
                      ),
                    if(partner.piece!.categories!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(10),
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.7),
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                            ),
                            child: Label12(text: "Catégories d'engin", color: GlobalThemeData.lightColorScheme.onPrimary, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
                          ),
                          const Gap(10),
                          ...partner.piece!.categories!.map((e) => Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline, size: 20, color: GlobalThemeData.lightColorScheme.outline,).animate().fadeIn(),
                                const Gap(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Label12(text: e.categorieEngin.libelle, color: GlobalThemeData.lightColorScheme.outline, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                                    if(e.hybride == 1)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Gap(5),
                                          Label10(text: "Hybride", color: GlobalThemeData.lightColorScheme.outline, weight: FontWeight.normal, maxLines: 1).animate().fadeIn(),
                                        ],
                                      ),
                                  ],
                                ),
                              ],
                            ).animate().fadeIn(),
                          )).toList(),
                        ],
                      ),
                  ],
                )
            ],
          );
        }
      )
    );
  }
}
