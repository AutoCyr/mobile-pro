import 'package:autocyr_pro/presentation/ui/atoms/labels/label10.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label17.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_button.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_icon_button.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/pieces/add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class PieceListScreen extends StatefulWidget {
  const PieceListScreen({super.key});

  @override
  State<PieceListScreen> createState() => _PieceListScreenState();
}

class _PieceListScreenState extends State<PieceListScreen> {

  int numberOfPieces = 7;
  String? selectedChip;
  late List<String> chips = [
    "Deux roues",
    "Quatre roues",
  ];

  late bool search = false;

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

            },
          ),
        ).animate().fadeIn(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                search = !search;
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Label12(
                text: "Filtrer par :",
                color: GlobalThemeData.lightColorScheme.secondaryContainer,
                weight: FontWeight.bold,
                maxLines: 1
              ).animate().fadeIn(),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 5,
                children: [
                  ...chips.map((e) => FilterChip(
                    side: BorderSide(color: GlobalThemeData.lightColorScheme.primaryContainer),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    label: Label10(
                      text: e,
                      color: GlobalThemeData.lightColorScheme.primaryContainer,
                      weight: FontWeight.w600,
                      maxLines: 1
                    ).animate().fadeIn(),
                    selected: selectedChip == e ? true : false,
                    onSelected: (selected) => setState(() {
                      selectedChip = selected ? e : null;
                    }),
                    backgroundColor: GlobalThemeData.lightColorScheme.primary.withOpacity(0.1),
                  ))
                ],
              ).animate().fadeIn(),
            ],
          ),
          const Gap(20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: numberOfPieces,
            itemBuilder: (context, index) => Container(
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
                        image: const DecorationImage(
                          image: AssetImage("assets/images/piece.webp"),
                          fit: BoxFit.cover,
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
                                height: 35,
                                decoration: BoxDecoration(
                                    color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.7)
                                ),
                                child: Center(
                                  child: Label12(
                                      text: "Quatre roues",
                                      color: GlobalThemeData.lightColorScheme.onPrimary,
                                      weight: FontWeight.bold,
                                      maxLines: 1
                                  ).animate().fadeIn(),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                width: size.width * 0.3,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: GlobalThemeData.lightColorScheme.secondaryContainer.withOpacity(0.7)
                                ),
                                child: Center(
                                  child: Label12(
                                      text: "TOYOTA",
                                      color: GlobalThemeData.lightColorScheme.onPrimary,
                                      weight: FontWeight.bold,
                                      maxLines: 1
                                  ).animate().fadeIn(),
                                ),
                              ),
                            ],
                          )
                        ]
                    ),
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.6,
                        child: Label14(
                            text: "Pièce d'engrenage",
                            color: GlobalThemeData.lightColorScheme.primaryContainer,
                            weight: FontWeight.bold,
                            maxLines: 2
                        ).animate().fadeIn(),
                      ),
                      CustomIconButton(
                        icon: Icons.arrow_forward_ios_rounded,
                        size: size,
                        context: context,
                        function: () {},
                        iconColor: GlobalThemeData.lightColorScheme.primary,
                        buttonColor: GlobalThemeData.lightColorScheme.onPrimary,
                        backColor: GlobalThemeData.lightColorScheme.primary
                      ).animate().fadeIn(),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(),
          )
        ],
      ),
    );
  }
}
