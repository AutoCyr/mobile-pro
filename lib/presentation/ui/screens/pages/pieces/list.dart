import 'package:autocyr_pro/data/network/urls.dart';
import 'package:autocyr_pro/domain/models/pieces/detail_piece.dart';
import 'package:autocyr_pro/presentation/notifier/auth_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/partner_notifier.dart';
import 'package:autocyr_pro/presentation/ui/atoms/buttons/progress_button.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label10.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label13.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label17.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/helpers/state.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_button.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_icon_button.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/pieces/add.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/pieces/detail.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/pieces/edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PieceListScreen extends StatefulWidget {
  const PieceListScreen({super.key});

  @override
  State<PieceListScreen> createState() => _PieceListScreenState();
}

class _PieceListScreenState extends State<PieceListScreen> {

  String? selectedChip;
  late List<String> chips = [
    "Deux roues",
    "Quatre roues",
  ];
  late bool search = false;
  late List<DetailPiece> pieces = [];
  late List<DetailPiece> localPieces = [];

  void filterList(String searchQuery) {
    List<DetailPiece> filtered = [];
    for (var value in pieces) {
      if (value.piece.nomPiece.toLowerCase().contains(searchQuery.toLowerCase())) {
        filtered.add(value);
      }
    }
    setState(() {
      localPieces = filtered;
    });
  }

  retrievePieces() async {
    final partner = Provider.of<PartnerNotifier>(context, listen: false);
    final auth = Provider.of<AuthNotifier>(context, listen: false);
    await partner.getPieces(id: auth.getUser.id.toString(), context: context);
    localPieces = pieces = partner.pieces;
  }

  _changePieceStatus(DetailPiece detail, Future function, BuildContext context) async {
    final partner = Provider.of<PartnerNotifier>(context, listen: false);
    await partner.changePieceStatus(piece: detail, function: function, context: context);
  }

  void showMenuOptions({
    required BuildContext context,
    required DetailPiece detail,
  }){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero)
        ),
        context: context,
        builder: (BuildContext context){
          Size size = MediaQuery.of(context).size;
          return Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Label14(
                        text: "Actions",
                        color: GlobalThemeData.lightColorScheme.secondaryContainer,
                        weight: FontWeight.bold,
                        maxLines: 1
                    ).animate().fadeIn(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: GlobalThemeData.lightColorScheme.secondaryContainer,),
                    ).animate().fadeIn(),
                  ],
                ),
                Divider(color: GlobalThemeData.lightColorScheme.outline.withOpacity(0.5),).animate().fadeIn(),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PieceEditScreen(detail: detail, function: retrievePieces(),)));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.edit_note_outlined, color: GlobalThemeData.lightColorScheme.secondaryContainer, size: 20),
                            const Gap(20),
                            Label12(text: "Modifier la pièce", color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.normal, maxLines: 1).animate().fadeIn(),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, color: GlobalThemeData.lightColorScheme.secondaryContainer, size: 15),
                      ],
                    ),
                  ),
                ).animate().fadeIn(),
                const Gap(10),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => PlanEditScreen(plan: plan)));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.settings_outlined, color: GlobalThemeData.lightColorScheme.secondaryContainer, size: 20),
                            const Gap(20),
                            Label12(text: "Modifier les configurations", color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.normal, maxLines: 1).animate().fadeIn(),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, color: GlobalThemeData.lightColorScheme.secondaryContainer, size: 15),
                      ],
                    ),
                  ),
                ).animate().fadeIn(),
                const Gap(10),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                    _changePieceStatus(detail, retrievePieces(), context);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(detail.piece.statut == 1 ? Icons.highlight_off : Icons.done_all_sharp, color: GlobalThemeData.lightColorScheme.secondaryContainer, size: 20),
                            const Gap(20),
                            Label12(text: detail.piece.statut == 1 ? "Désactiver" : "Activer", color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.normal, maxLines: 1).animate().fadeIn(),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, color: GlobalThemeData.lightColorScheme.secondaryContainer, size: 15),
                      ],
                    ),
                  ),
                ).animate().fadeIn(),
              ],
            ),
          );
        }
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      retrievePieces();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: GlobalThemeData.lightColorScheme.primary),
        backgroundColor: GlobalThemeData.lightColorScheme.onPrimary,
        title: search == false ?
          Label14(text: "Mes pièces", color: GlobalThemeData.lightColorScheme.primaryContainer, weight: FontWeight.bold, maxLines: 1).animate().fadeIn()
            :
          SizedBox(
          height: 45,
          child: TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: GlobalThemeData.lightColorScheme.primaryContainer.withOpacity(0.1),

              hintText: "Rechercher",
              border: InputBorder.none,
              hintStyle: const TextStyle(
                  fontSize: 13
              ),
            ),
            style: const TextStyle(
                fontSize: 13
            ),
            autofocus: true,
            onChanged: (value){
              filterList(value);
            },
          ),
        ).animate().fadeIn(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                search = !search;
                filterList("");
              });
            },
            icon: search ? const Icon(Icons.clear) : const Icon(Icons.search_rounded),
          ).animate().fadeIn(),
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PieceAddScreen())),
            icon: const Icon(Icons.add),
          ).animate().fadeIn(),
        ]
      ),
      body: Consumer2<AuthNotifier, PartnerNotifier>(
        builder: (context, auth, partner, child) {
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
                    Label10(text: "Chargement des pièces...", color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.bold, maxLines: 1),
                  ]
              ).animate().fadeIn(),
            );
          }

          if(localPieces.isEmpty && !partner.loading) {
            return const StateScreen(icon: Icons.settings_outlined, message: "Aucune pièce trouvée.", isError: false,);
          }

          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: localPieces.length,
            itemBuilder: (context, index) {
              var piece = localPieces[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                width: size.width,
                decoration: BoxDecoration(
                  color: GlobalThemeData.lightColorScheme.onPrimary,
                  border: Border.all(
                      color: GlobalThemeData.lightColorScheme.primaryContainer.withOpacity(0.5),
                      width: 1
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: GlobalThemeData.lightColorScheme.primaryContainer,
                              width: 1
                          ),
                          image: DecorationImage(
                              onError: (Object e, StackTrace? stackTrace) => Image.asset(
                                "assets/images/back-2.webp",
                                fit: BoxFit.cover,
                              ),
                              image: NetworkImage(
                                Urls.imageUrl+piece.imagePiece,
                              ),
                              fit: BoxFit.cover
                          )
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  width: size.width * 0.3,
                                  decoration: BoxDecoration(
                                      color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.7)
                                  ),
                                  child: Center(
                                    child: Label10(
                                        text: piece.typeEngin.libelle,
                                        color: GlobalThemeData.lightColorScheme.onPrimary,
                                        weight: FontWeight.bold,
                                        maxLines: 1
                                    ).animate().fadeIn(),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  width: size.width * 0.3,
                                  decoration: BoxDecoration(
                                      color: GlobalThemeData.lightColorScheme.secondaryContainer.withOpacity(0.7)
                                  ),
                                  child: Center(
                                    child: Label10(
                                        text: piece.marque.name.toUpperCase(),
                                        color: GlobalThemeData.lightColorScheme.onPrimary,
                                        weight: FontWeight.bold,
                                        maxLines: 1
                                    ).animate().fadeIn(),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: piece.piece.statut == 1 ? Colors.green : GlobalThemeData.lightColorScheme.errorContainer,
                                      borderRadius: BorderRadius.circular(50),
                                    )
                                ),
                                const Gap(10),
                                if(partner.isActionPiece(piece))
                                  Icon(Icons.update, color: GlobalThemeData.lightColorScheme.onPrimary, size: 20,)
                              ],
                            ),
                          ]
                      ),
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.55,
                          child: Label14(
                              text: piece.piece.nomPiece,
                              color: GlobalThemeData.lightColorScheme.primaryContainer,
                              weight: FontWeight.bold,
                              maxLines: 2
                          ).animate().fadeIn(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomIconButton(
                                icon: Icons.more_horiz_outlined,
                                size: size,
                                context: context,
                                function: () {
                                  showMenuOptions(context: context, detail: piece);
                                },
                                iconColor: GlobalThemeData.lightColorScheme.primary,
                                buttonColor: GlobalThemeData.lightColorScheme.onPrimary,
                                backColor: GlobalThemeData.lightColorScheme.primary
                            ).animate().fadeIn(),
                            CustomIconButton(
                                icon: Icons.arrow_forward_ios_rounded,
                                size: size,
                                context: context,
                                function: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPieceScreen(detail: piece)));
                                },
                                iconColor: GlobalThemeData.lightColorScheme.primary,
                                buttonColor: GlobalThemeData.lightColorScheme.onPrimary,
                                backColor: GlobalThemeData.lightColorScheme.primary
                            ).animate().fadeIn(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn();
            },
          );
        }
      )
    );
  }
}
