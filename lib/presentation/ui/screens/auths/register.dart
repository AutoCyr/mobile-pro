import 'package:autocyr_pro/presentation/ui/atoms/fields/custom_field.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label30.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/molecules/custom_buttons/small_custom_button.dart';
import 'package:autocyr_pro/presentation/ui/screens/auths/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _raisonController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
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
                      CustomField(
                        controller: _typeController,
                        keyboardType: TextInputType.emailAddress,
                        label: "Type de partenaire",
                        fontSize: 12,
                        icon: Icons.new_releases_outlined,
                        readOnly: true
                      ).animate().fadeIn(),
                      const Gap(10),
                      CustomField(
                        controller: _raisonController,
                        keyboardType: TextInputType.text,
                        label: "Raison sociale",
                        fontSize: 12,
                        icon: Icons.business_outlined,
                        readOnly: false
                      ).animate().fadeIn(),
                      const Gap(10),
                      CustomField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        label: "Téléphone",
                        fontSize: 12,
                        icon: Icons.phone_outlined,
                        readOnly: false
                      ).animate().fadeIn(),
                      const Gap(10),
                      CustomField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        label: "Adresse email",
                        fontSize: 12,
                        icon: Icons.alternate_email,
                        readOnly: false
                      ).animate().fadeIn(),
                      const Gap(10),
                      CustomField(
                        controller: _townController,
                        keyboardType: TextInputType.text,
                        label: "Ville",
                        fontSize: 12,
                        icon: Icons.share_location_outlined,
                        readOnly: false
                      ).animate().fadeIn(),
                      const Gap(10),
                      CustomField(
                        controller: _districtController,
                        keyboardType: TextInputType.text,
                        label: "Quartier",
                        fontSize: 12,
                        icon: Icons.share_location_outlined,
                        readOnly: false
                      ).animate().fadeIn(),
                      const Gap(20),
                      SizedBox(
                        width: size.width,
                        child: SmallCustomButton(
                            text: "S'inscrire",
                            size: size,
                            globalWidth: size.width * 0.9,
                            widthSize: size.width * 0.87,
                            backSize: size.width * 0.87,
                            context: context,
                            function: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                            textColor: GlobalThemeData.lightColorScheme.primary,
                            buttonColor: GlobalThemeData.lightColorScheme.onPrimary,
                            backColor: GlobalThemeData.lightColorScheme.primary
                        ).animate().fadeIn(),
                      ),
                      /*Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.25,
                            child: CustomField(
                                controller: _raisonController,
                                keyboardType: TextInputType.number,
                                label: "Téléphone",
                                fontSize: 12,
                                icon: Icons.phone_outlined,
                                readOnly: true
                            ).animate().fadeIn(),
                          ),
                          SizedBox(
                            width: size.width * 0.7,
                            child: CustomField(
                                controller: _raisonController,
                                keyboardType: TextInputType.number,
                                label: "Téléphone",
                                fontSize: 12,
                                icon: Icons.phone_outlined,
                                readOnly: false
                            ).animate().fadeIn(),
                          ),
                        ],
                      )*/
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
      ),
    );
  }
}
