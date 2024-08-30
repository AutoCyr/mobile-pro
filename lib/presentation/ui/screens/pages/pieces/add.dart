import 'package:autocyr_pro/presentation/ui/atoms/fields/custom_field.dart';
import 'package:autocyr_pro/presentation/ui/atoms/fields/description_field.dart';
import 'package:autocyr_pro/presentation/ui/atoms/fields/selectable_field.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label30.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class PieceAddScreen extends StatefulWidget {
  const PieceAddScreen({super.key});

  @override
  State<PieceAddScreen> createState() => _PieceAddScreenState();
}

class _PieceAddScreenState extends State<PieceAddScreen> {

  List<String> options = [
    "Deux roues",
    "Quatre roues",
  ];

  List<String> marques = [
    "Citroën",
    "Peugeot",
    "Honda",
    "Toyota",
    "Fiat",
  ];

  final TextEditingController _nomPieceController = TextEditingController();
  final TextEditingController _marqueController = TextEditingController();
  final TextEditingController _categorieController = TextEditingController();
  final TextEditingController _modeleController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _anneeController = TextEditingController();
  final TextEditingController _autreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: GlobalThemeData.lightColorScheme.primary),
        backgroundColor: GlobalThemeData.lightColorScheme.onPrimary,
        title: Label14(text: "Nouvelle pièce", color: GlobalThemeData.lightColorScheme.primaryContainer, weight: FontWeight.bold, maxLines: 1).animate().fadeIn()
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Label30(text: "Nouvelle pièce", color: GlobalThemeData.lightColorScheme.primary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                  const Gap(30),*/
                  CustomField(
                      controller: _nomPieceController,
                      keyboardType: TextInputType.text,
                      label: "Nom de la pièce",
                      fontSize: 12,
                      icon: Icons.text_fields_outlined,
                  ).animate().fadeIn(),
                  const Gap(10),
                  SelectableField(
                    controller: _categorieController,
                    keyboardType: TextInputType.none,
                    label: "Catégorie de pièce",
                    fontSize: 12,
                    icon: Icons.car_rental_outlined,
                    options: options,
                    context: context
                  ).animate().fadeIn(),
                  const Gap(10),
                  SelectableField(
                      controller: _marqueController,
                      keyboardType: TextInputType.none,
                      label: "Marque",
                      fontSize: 12,
                      icon: Icons.loyalty_outlined,
                      options: marques,
                      context: context
                  ).animate().fadeIn(),
                  const Gap(10),
                  CustomField(
                      controller: _modeleController,
                      keyboardType: TextInputType.text,
                      label: "Modèle",
                      fontSize: 12,
                      icon: Icons.style_outlined,
                  ).animate().fadeIn(),
                  const Gap(10),
                  CustomField(
                      controller: _numeroController,
                      keyboardType: TextInputType.text,
                      label: "Numéro",
                      fontSize: 12,
                      icon: Icons.onetwothree_sharp,
                  ).animate().fadeIn(),
                  const Gap(10),
                  CustomField(
                      controller: _anneeController,
                      keyboardType: TextInputType.number,
                      label: "Année",
                      fontSize: 12,
                      icon: Icons.calendar_today_outlined,
                  ).animate().fadeIn(),
                  const Gap(10),
                  DescriptionField(
                      controller: _autreController,
                      keyboardType: TextInputType.text,
                      label: "Autres informations",
                      fontSize: 12,
                      icon: Icons.more_horiz_outlined
                  ).animate().fadeIn(),
                  const Gap(20),
                  SizedBox(
                    width: size.width,
                    child: CustomButton(
                        text: "Enregistrer",
                        size: size,
                        globalWidth: size.width * 0.9,
                        widthSize: size.width * 0.87,
                        backSize: size.width * 0.87,
                        context: context,
                        function: () => Navigator.pop(context),
                        textColor: GlobalThemeData.lightColorScheme.primary,
                        buttonColor: GlobalThemeData.lightColorScheme.onPrimary,
                        backColor: GlobalThemeData.lightColorScheme.primary
                    ).animate().fadeIn(),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
