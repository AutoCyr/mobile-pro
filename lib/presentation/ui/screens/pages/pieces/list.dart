import 'package:autocyr_pro/data/network/urls.dart';
import 'package:autocyr_pro/domain/models/pieces/detail_piece.dart';
import 'package:autocyr_pro/domain/models/pieces/piece_info.dart';
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
import 'package:autocyr_pro/presentation/ui/screens/pages/pieces/operations/add_article.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/pieces/operations/add_piece.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/pieces/detail.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/pieces/operations/edit.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/pieces/operations/edit_config.dart';
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

  late PieceInfo info;
  late bool search = false;
  late List<DetailPiece> pieces = [];
  late List<DetailPiece> localPieces = [];

  List<Map<String, dynamic>> options = [
    {
      "label": "À partir des pièces pré-enregistrées",
      "image": "assets/pngs/system.webp",
      "widget": const ArticleAddScreen(),
      "recommended": true
    },
    {
      "label": "Pièce personnalisée",
      "image": "assets/pngs/custom.webp",
      "widget": const PieceAddScreen(),
      "recommended": false
    },
  ];

  void filterList(String searchQuery) {
    List<DetailPiece> filtered = [];
    for (var value in pieces) {
      if (value.piece!.nomPiece.toLowerCase().contains(searchQuery.toLowerCase()) || value.article!.name.toLowerCase().contains(searchQuery.toLowerCase())) {
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

  retrievePieceDetails(DetailPiece piece) async {
    final partner = Provider.of<PartnerNotifier>(context, listen: false);
    await partner.getPiece(id: piece.detailPieceId.toString(), context: context);
    setState(() {
      info = partner.piece!;
    });
  }

  _changePieceStatus(DetailPiece detail, Future function) async {
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
                  onTap: () async {
                    await retrievePieceDetails(detail);
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigEditScreen(detail: info)));
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
                    _changePieceStatus(detail, retrievePieces());
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(detail.statut == 1 ? Icons.highlight_off : Icons.done_all_sharp, color: GlobalThemeData.lightColorScheme.secondaryContainer, size: 20),
                            const Gap(20),
                            Label12(text: detail.statut == 1 ? "Désactiver" : "Activer", color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.normal, maxLines: 1).animate().fadeIn(),
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

  void addOptions({
    required BuildContext context,
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
                      text: "Nouvelle pièce",
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
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...options.map((e) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => e["widget"]));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        width: size.width * 0.42,
                        height: size.height * 0.35,
                        decoration: BoxDecoration(
                          border: Border.all(color: GlobalThemeData.lightColorScheme.outline.withOpacity(0.5), width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if(e["recommended"])
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: GlobalThemeData.lightColorScheme.primaryContainer,
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                    ),
                                    child: Center(
                                      child: Label10(
                                        text: "Recommandé",
                                        color: GlobalThemeData.lightColorScheme.onPrimaryContainer,
                                        weight: FontWeight.w700,
                                        maxLines: 2,
                                      ),
                                    ),
                                  )
                                else
                                  const SizedBox()
                              ],
                            ),
                            Image.asset(
                              e["image"],
                              width: size.width * 0.3,
                              height: size.width * 0.3,
                              fit: BoxFit.cover,
                            ),
                            Label10(text: e["label"], color: GlobalThemeData.lightColorScheme.primary, weight: FontWeight.normal, maxLines: 2).animate().fadeIn(),
                          ],
                        ),
                      ),
                    );
                  })
                ],
              )
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
            onPressed: () => addOptions(context: context),
            icon: const Icon(Icons.add),
          ).animate().fadeIn(),
        ]
      ),
      body: Consumer2<AuthNotifier, PartnerNotifier>(
        builder: (context, auth, partner, child) {

          if(partner.mainLoading) {
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

          if(localPieces.isEmpty && !partner.mainLoading) {
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
                          mainAxisAlignment: MainAxisAlignment.end,
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
                                )
                              ],
                            ),
                            /*Column(
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
                            ),*/
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
                              text: piece.piece != null ? piece.piece!.nomPiece : piece.article!.name,
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
