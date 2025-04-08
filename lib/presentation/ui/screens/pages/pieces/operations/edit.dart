import 'dart:io';

import 'package:autocyr_pro/data/network/urls.dart';
import 'package:autocyr_pro/domain/models/commons/bike_make.dart';
import 'package:autocyr_pro/domain/models/commons/car_make.dart';
import 'package:autocyr_pro/domain/models/commons/engin_type.dart';
import 'package:autocyr_pro/domain/models/core/article.dart';
import 'package:autocyr_pro/domain/models/pieces/detail_piece.dart';
import 'package:autocyr_pro/presentation/notifier/auth_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/common_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/partner_notifier.dart';
import 'package:autocyr_pro/presentation/ui/atoms/buttons/progress_button.dart';
import 'package:autocyr_pro/presentation/ui/atoms/fields/custom_field.dart';
import 'package:autocyr_pro/presentation/ui/atoms/fields/custom_selectable_field.dart';
import 'package:autocyr_pro/presentation/ui/atoms/fields/description_field.dart';
import 'package:autocyr_pro/presentation/ui/atoms/fields/object_selectable_field.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label10.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/helpers/snacks.dart';
import 'package:autocyr_pro/presentation/ui/helpers/ui.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_button.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_icon_button.dart';
import 'package:autocyr_pro/presentation/ui/organisms/searchables/searchable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PieceEditScreen extends StatefulWidget {
  final DetailPiece detail;
  final Future function;
  const PieceEditScreen({super.key, required this.detail, required this.function});

  @override
  State<PieceEditScreen> createState() => _PieceEditScreenState();
}

class _PieceEditScreenState extends State<PieceEditScreen> {

  late bool _isGarantie = false;
  late String typeKey = "";

  File? media;
  late XFile? _image;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _nomPieceController = TextEditingController();
  final TextEditingController _articleController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _autreController = TextEditingController();

  Future getImageFromGallery() async {
    _image = await _picker.pickImage(source: ImageSource.gallery, maxHeight: 1080, maxWidth: 1080);
    setState(() {
      media = File(_image!.path);
    });
  }

  Future getImageFromCamera() async {
    _image = await _picker.pickImage(source: ImageSource.camera, maxHeight: 1080, maxWidth: 1080);
    setState(() {
      media = File(_image!.path);
    });
  }

  retrieveCommons() async {
    final common = Provider.of<CommonNotifier>(context, listen: false);
    if(!common.filling) {
      if(common.carMakes.isEmpty) {
        await common.retrieveAutoMakes(context: context);
      }
      if(common.bikeMakes.isEmpty) {
        await common.retrieveBikeMakes(context: context);
      }
      if(common.enginTypes.isEmpty) {
        await common.retrieveEnginTypes(context: context);
      }
      if(common.articles.isEmpty) {
        await common.retrieveArticles(context: context);
      }
    }
  }

  loadData() async {
    final common = Provider.of<CommonNotifier>(context, listen: false);

    EnginType type = common.enginTypes.firstWhere((element) => element.id == widget.detail.typeEngin.id);

    setState(() {
      if(widget.detail.piece != null) _nomPieceController.text = widget.detail.piece!.nomPiece;
      if(widget.detail.article != null) _articleController.text = widget.detail.article!.name;
      _typeController.text = type.libelle;
      typeKey = type.id.toString();
      _prixController.text = widget.detail.prixPiece.toString();
      _isGarantie = widget.detail.garantie == 1 ? true : false;
      _autreController.text = widget.detail.autres ?? "";
    });
  }

  _update() async {
    final partner = Provider.of<PartnerNotifier>(context, listen: false);
    final auth = Provider.of<AuthNotifier>(context, listen: false);
    final common = Provider.of<CommonNotifier>(context, listen: false);

    if(UiTools().checkFields([_typeController, _prixController])) {
      Map<String, String> body = {
        "partenaire_id" : auth.getPartenaire.partenaireId.toString(),
        "key_piece": widget.detail.article != null ? "article" : "piece",
        if(widget.detail.piece != null) "nom_piece" : _nomPieceController.text,
        "type_engin_id" : typeKey,
        "prix_piece" : _prixController.text,
        "garantie" : _isGarantie ? "1" : "0",
        "autres" : _autreController.text,
        if(media != null) "image_piece" : media.toString()
      };

      if(media == null) {
        if(widget.detail.piece != null) {
          await partner.updatePiece(body: body, id: widget.detail.piece!.pieceId.toString(), filepath: "", name: "", function: widget.function, context: context);
        } else {
          await partner.updatePiece(body: body, id: widget.detail.article!.id.toString(), filepath: "", name: "", function: widget.function, context: context);
        }
      } else {
        if(widget.detail.piece != null) {
          await partner.updatePiece(body: body, id: widget.detail.piece!.pieceId.toString(), filepath: media!.path, name: "image_piece", function: widget.function, context: context);
        } else {
          await partner.updatePiece(body: body, id: widget.detail.article!.id.toString(), filepath: media!.path, name: "image_piece", function: widget.function, context: context);
        }
      }
    } else {
      Snacks.failureBar("Veuillez remplir tous les champs avant de continuer", context);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await retrieveCommons();
      await loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: GlobalThemeData.lightColorScheme.primary),
        backgroundColor: GlobalThemeData.lightColorScheme.onPrimary,
        title: Label14(text: "Modifier la pièce", color: GlobalThemeData.lightColorScheme.primary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn()
      ),
      body: Consumer2<CommonNotifier, PartnerNotifier>(
          builder: (context, common, partner, child) {
            return SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(media == null)
                          Row(
                            children: [
                              Container(
                                width: size.width * 0.3,
                                height: size.width * 0.3,
                                decoration: BoxDecoration(
                                  color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.1),
                                  border: Border.all(color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.1), width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    onError: (Object e, StackTrace? stackTrace) => Image.asset(
                                      "assets/images/back-2.webp",
                                      fit: BoxFit.cover,
                                    ),
                                    image: NetworkImage(
                                      Urls.imageUrl+widget.detail.imagePiece,
                                    ),
                                    fit: BoxFit.cover
                                  )
                                ),
                              ).animate().fadeIn(),
                              const Gap(10),
                              SizedBox(
                                height: size.width * 0.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Label12(text: "Changer l'image", color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                                    const Gap(10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CustomIconButton(
                                            icon: Icons.photo_library_outlined,
                                            size: size,
                                            context: context,
                                            function: () => getImageFromGallery(),
                                            iconColor: GlobalThemeData.lightColorScheme.primary,
                                            buttonColor: GlobalThemeData.lightColorScheme.onPrimary,
                                            backColor: GlobalThemeData.lightColorScheme.primary
                                        ).animate().fadeIn(),
                                        CustomIconButton(
                                            icon: Icons.photo_camera_outlined,
                                            size: size,
                                            context: context,
                                            function: () => getImageFromCamera(),
                                            iconColor: GlobalThemeData.lightColorScheme.primary,
                                            buttonColor: GlobalThemeData.lightColorScheme.onPrimary,
                                            backColor: GlobalThemeData.lightColorScheme.primary
                                        ).animate().fadeIn(),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        else if(media != null)
                          Container(
                              width: size.width,
                              height: size.width * 0.3,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.1),
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: size.width * 0.27,
                                          height: size.width * 0.27,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: GlobalThemeData.lightColorScheme.primary, width: 1),
                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                            image: DecorationImage(
                                                image: FileImage(media!),
                                                fit: BoxFit.cover
                                            ),
                                          )
                                      ),
                                      const Gap(10),
                                      SizedBox(
                                        width: size.width * 0.55,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      media = null;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.black,
                                                    size: 20,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Label12(text: "Média sélectionné", color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                                                const Gap(5),
                                                Label12(text: _image!.name, color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )

                                    ],
                                  )
                                ],
                              )
                          ).animate().fadeIn(),
                        const Gap(20),
                        if(widget.detail.piece != null)
                          CustomField(
                            controller: _nomPieceController,
                            keyboardType: TextInputType.text,
                            label: "Nom de la pièce",
                            fontSize: 12,
                            icon: Icons.text_fields_outlined,
                          ).animate().fadeIn()
                        else
                          ObjectSelectableField(
                              controller: _articleController,
                              keyboardType: TextInputType.none,
                              label: "Pièce",
                              fontSize: 12,
                              icon: Icons.settings_outlined,
                              context: context,
                              onSelected: () {}
                          ).animate().fadeIn(),
                        const Gap(10),
                        common.filling ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Label10(text: "Chargement des types d'engin...", color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
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
                          CustomSelectableField(
                            controller: _typeController,
                            key: typeKey,
                            keyboardType: TextInputType.none,
                            label: "Type d'engin",
                            fontSize: 12,
                            icon: Icons.car_rental_outlined,
                            context: context,
                            options: common.enginTypes,
                            displayField: (value) => (value as EnginType).libelle,
                            onSelected: (value) {
                              setState(() {
                                _typeController.text = value.libelle;
                                typeKey = value.id.toString();
                              });
                            }
                          ).animate().fadeIn(),
                        const Gap(10),
                        CustomField(
                          controller: _prixController,
                          keyboardType: TextInputType.number,
                          label: "Prix",
                          fontSize: 12,
                          icon: Icons.onetwothree_sharp,
                        ).animate().fadeIn(),
                        const Gap(10),
                        Row(
                          children: [
                            Checkbox(
                              value: _isGarantie,
                              onChanged: (value) {
                                setState(() {
                                  _isGarantie = value!;
                                });
                              },
                            ).animate().fadeIn(),
                            const Gap(10),
                            const Text("Est garantie").animate().fadeIn(),
                          ],
                        ),
                        const Gap(10),
                        DescriptionField(
                            controller: _autreController,
                            keyboardType: TextInputType.text,
                            label: "Autres informations",
                            fontSize: 12,
                            icon: Icons.more_horiz_outlined
                        ).animate().fadeIn(),
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
                                text: "Modifier",
                                size: size,
                                globalWidth: size.width * 0.9,
                                widthSize: size.width * 0.87,
                                backSize: size.width * 0.87,
                                context: context,
                                function: () => _update(),
                                textColor: GlobalThemeData.lightColorScheme.primary,
                                buttonColor: GlobalThemeData.lightColorScheme.onPrimary,
                                backColor: GlobalThemeData.lightColorScheme.primary
                            ).animate().fadeIn(),
                          ),
                      ]
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
