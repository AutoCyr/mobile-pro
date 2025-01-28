import 'package:autocyr_pro/domain/models/commons/partner_type.dart';
import 'package:autocyr_pro/presentation/notifier/auth_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/common_notifier.dart';
import 'package:autocyr_pro/presentation/ui/atoms/buttons/progress_button.dart';
import 'package:autocyr_pro/presentation/ui/atoms/fields/custom_field.dart';
import 'package:autocyr_pro/presentation/ui/atoms/fields/custom_selectable_field.dart';
import 'package:autocyr_pro/presentation/ui/atoms/fields/object_selectable_field.dart';
import 'package:autocyr_pro/presentation/ui/atoms/fields/selectable_field.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label10.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label30.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/helpers/snacks.dart';
import 'package:autocyr_pro/presentation/ui/helpers/ui.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/custom_button.dart';
import 'package:autocyr_pro/presentation/ui/organisms/searchables/searchable.dart';
import 'package:autocyr_pro/presentation/ui/screens/auths/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  String typeKey = "";
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _raisonController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();

  retrieveCommons() async {
    final common = Provider.of<CommonNotifier>(context, listen: false);
    if(!common.filling) {
      if(common.countries.isEmpty) {
        await common.retrieveCountries(context: context);
      }
      if(common.partnerTypes.isEmpty) {
        await common.retrievePartnerTypes(context: context);
      }
    }
  }

  _save(BuildContext context) async {
    final auth = Provider.of<AuthNotifier>(context, listen: false);
    final common = Provider.of<CommonNotifier>(context, listen: false);

    if(UiTools().checkFields([_countryController, _raisonController, _phoneController, _emailController, _townController, _districtController])) {
      Map<String, dynamic> body = {
        "pays_id": common.country!.id,
        "type_id": common.partnerType!.id,
        "raison_sociale": _raisonController.text,
        "telephone_partenaire": "${common.country!.countryCode}${_phoneController.text}",
        "email_partenaire": _emailController.text,
        "ville_partenaire": _townController.text,
        "quartier_partenaire": _districtController.text,
      };
      await auth.register(context: context, body: body);
    } else {
      Snacks.failureBar("Veuillez remplir tous les champs avant de continuer", context);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      retrieveCommons();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer2<CommonNotifier, AuthNotifier>(
        builder: (context, common, auth, child) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Label30(text: "Inscription", color: GlobalThemeData.lightColorScheme.primary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                          const Gap(30),
                          common.filling ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Label10(text: "Chargement des types de partenaire...", color: GlobalThemeData.lightColorScheme.primary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
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
                              label: "Type de partenaire",
                              fontSize: 12,
                              icon: Icons.person_pin_outlined,
                              context: context,
                              options: common.partnerTypes,
                              displayField: (value) => (value as PartnerType).libelle,
                              onSelected: (value) {
                                common.setPartnerType(value as PartnerType);
                                setState(() {
                                  _typeController.text = value.libelle;
                                  typeKey = value.id.toString();
                                });
                              }
                            ).animate().fadeIn(),
                          const Gap(10),
                          common.filling ?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Label10(text: "Chargement des pays...", color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
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
                            ObjectSelectableField(
                              controller: _countryController,
                              keyboardType: TextInputType.none,
                              label: "Pays",
                              fontSize: 12,
                              icon: Icons.flag_outlined,
                              context: context,
                              /*options: common.countries,
                              typeSelection: "country",*/
                              onSelected: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CustomSearchable(
                                controller: _countryController,
                                list: common.countries,
                                typeSelection: "country",
                              ))),
                            ).animate().fadeIn(),
                          const Gap(10),
                          CustomField(
                            controller: _raisonController,
                            keyboardType: TextInputType.text,
                            label: "Raison sociale",
                            fontSize: 12,
                            icon: Icons.business_outlined,
                          ).animate().fadeIn(),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width * 0.25,
                                child: common.country != null ?
                                  Label14(text: "${common.country!.initials} (${common.country!.countryCode})", color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn()
                                    :
                                  Label14(text: "Pays (+---)", color: GlobalThemeData.lightColorScheme.secondary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                              ),
                              SizedBox(
                                width: size.width * 0.65,
                                child: CustomField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.number,
                                  label: "Téléphone",
                                  fontSize: 12,
                                  icon: Icons.phone_outlined,
                                ).animate().fadeIn(),
                              ),
                            ],
                          ),
                          const Gap(10),
                          CustomField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            label: "Adresse email",
                            fontSize: 12,
                            icon: Icons.alternate_email,
                          ).animate().fadeIn(),
                          const Gap(10),
                          CustomField(
                            controller: _townController,
                            keyboardType: TextInputType.text,
                            label: "Ville",
                            fontSize: 12,
                            icon: Icons.share_location_outlined,
                          ).animate().fadeIn(),
                          const Gap(10),
                          CustomField(
                            controller: _districtController,
                            keyboardType: TextInputType.text,
                            label: "Quartier",
                            fontSize: 12,
                            icon: Icons.share_location_outlined,
                          ).animate().fadeIn(),
                          const Gap(20),
                          auth.loading ?
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
                                  text: "S'inscrire",
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
                            ),
                        ]
                    ),
                    const Gap(20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Label12(text: "Vous avez déjà un compte ?", color: Colors.black, weight: FontWeight.normal, maxLines: 1).animate().fadeIn(),
                          TextButton(
                              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                              child: Label12(text: "Se connecter", color: GlobalThemeData.lightColorScheme.primary, weight: FontWeight.bold, maxLines: 1)
                          ).animate().fadeIn()
                        ]
                    )
                  ],
                ),
              ),
            ),
          );
        }
      )
    );
  }
}
