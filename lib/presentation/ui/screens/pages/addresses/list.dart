import 'package:autocyr_pro/domain/models/profile/address.dart';
import 'package:autocyr_pro/domain/models/profile/partenaire.dart';
import 'package:autocyr_pro/presentation/notifier/auth_notifier.dart';
import 'package:autocyr_pro/presentation/notifier/partner_notifier.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/helpers/snacks.dart';
import 'package:autocyr_pro/presentation/ui/helpers/state.dart';
import 'package:autocyr_pro/presentation/ui/helpers/ui.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/addresses/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {

  List<Address> adresses = [];

  retrieveAdresses() async {
    final auth = Provider.of<AuthNotifier>(context, listen: false);

    List<Address> localAdresses = [];
    if(auth.partenaire != null && auth.partenaire!.adressesPartenaire != null) {
      localAdresses = auth.partenaire!.adressesPartenaire!;
    }

    setState(() {
      adresses = localAdresses.where((element) => element.status == 1).toList();
    });
  }

  disableAdress(Address address) async {
    final auth = Provider.of<AuthNotifier>(context, listen: false);
    final partner = Provider.of<PartnerNotifier>(context, listen: false);

    int index = auth.partenaire!.adressesPartenaire!.indexOf(address);

    Map<String, dynamic> body = {
      "position": index,
      "status": 0,
    };
    await partner.disableAdress(body: body, auth: auth, context: context);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      retrieveAdresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: GlobalThemeData.lightColorScheme.primary),
        backgroundColor: GlobalThemeData.lightColorScheme.onPrimary,
        title: Label14(text: "Mes adresses", color: GlobalThemeData.lightColorScheme.primary, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddressMapScreen(function: retrieveAdresses))),
            icon: const Icon(Icons.add),
          ).animate().fadeIn(),
        ]
      ),
      body: Consumer2<AuthNotifier, PartnerNotifier>(
          builder: (context, auth, partner, child) {

            if(adresses.isEmpty) {
              return const StateScreen(icon: Icons.inbox_sharp, message: "Aucune adresse trouvée.", isError: false,);
            }

            return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: [
                  ...adresses.reversed.map((address) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on_rounded, color: Colors.grey, size: 24,),
                              const Gap(20),
                              SizedBox(
                                  width: size.width * 0.6,
                                  child: Label12(text: address.libelle, color: Colors.black, weight: FontWeight.bold, maxLines: 2)
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              if(partner.loading) {
                                return Snacks.infoBar("Veuillez patienter. Une opération est en cours...", context);
                              } else {
                                UiTools().confirmOperationBox(
                                  context: context,
                                  function: () => disableAdress(address)
                                );
                              }
                            },
                            icon: Icon(
                              Icons.delete_rounded,
                              color: partner.loading ? GlobalThemeData.lightColorScheme.secondary : GlobalThemeData.lightColorScheme.error,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ).animate().slide();
                  })
                ]
            );
          }
      ),
    );
  }
}
