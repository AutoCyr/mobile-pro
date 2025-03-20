import 'package:autocyr_pro/data/helpers/redirections.dart';
import 'package:autocyr_pro/domain/models/features/demande.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label13.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label17.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class RequestDetailScreen extends StatefulWidget {
  final Demande demande;
  const RequestDetailScreen({super.key, required this.demande});

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {

  Demande? detail;

  @override
  void initState() {
    super.initState();
    detail = widget.demande;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: GlobalThemeData.lightColorScheme.primary),
          backgroundColor: GlobalThemeData.lightColorScheme.onPrimary,
          title: Label14(text: "Détail de la demande", color: GlobalThemeData.lightColorScheme.primaryContainer, weight: FontWeight.bold, maxLines: 1).animate().fadeIn()
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            width: size.width,
            decoration: BoxDecoration(
              color: GlobalThemeData.lightColorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              border: Border.all(color: GlobalThemeData.lightColorScheme.primary, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label17(text: "Demande #${detail!.reference}", color: GlobalThemeData.lightColorScheme.onPrimaryContainer, weight: FontWeight.bold, maxLines: 1).animate().fadeIn(),
                const Gap(10),
                Label13(text: "Effectuée le ${DateFormat.yMMMMEEEEd("fr").format(detail!.dateDemande)} à ${DateFormat.Hm("fr").format(detail!.dateDemande)}", color: GlobalThemeData.lightColorScheme.onPrimaryContainer, weight: FontWeight.normal, maxLines: 2).animate().fadeIn(),
              ],
            ),
          ),
          const Gap(10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: size.width,
            decoration: BoxDecoration(
              color: GlobalThemeData.lightColorScheme.onPrimary,
              border: Border.all(color: GlobalThemeData.lightColorScheme.primary, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label14(text: detail!.article.name, color: Colors.black87, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
                const Gap(10),
                Label14(text: "${detail!.marque.name} ${detail!.modelePiece ?? ""} ${detail!.numeroPiece ?? ""} ${detail!.anneePiece ?? ""}", color: Colors.black87, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
                const Gap(5),
                Label13(text: detail!.garantie == 1 ? "Pièce garantie" : "Pièce non garantie", color: Colors.black87, weight: FontWeight.normal, maxLines: 2).animate().fadeIn(),
                const Gap(10),
                Divider(
                  color: GlobalThemeData.lightColorScheme.onSurface,
                  thickness: 1,
                  height: 1,
                ).animate().fadeIn(),
                const Gap(10),
                Label14(text: "Description de la pièce", color: Colors.black87, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
                const Gap(5),
                Label12(text: detail!.descriptionPiece, color: Colors.black87, weight: FontWeight.normal, maxLines: 50).animate().fadeIn(),
                const Gap(10),
                if(detail!.autres != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(10),
                      Label14(text: "Autres informations", color: Colors.black87, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
                      const Gap(10),
                      Label12(text: detail!.autres!, color: Colors.black87, weight: FontWeight.bold, maxLines: 50).animate().fadeIn(),
                    ],
                  ).animate().fadeIn(),
              ],
            ),
          ),
          if(detail!.etatDemande == 1)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: size.width,
                  decoration: BoxDecoration(
                    color: GlobalThemeData.lightColorScheme.onPrimary,
                    border: Border.all(color: GlobalThemeData.lightColorScheme.primary, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Label14(text: "Information sur le client", color: GlobalThemeData.lightColorScheme.onSurface, weight: FontWeight.normal, maxLines: 2).animate().fadeIn(),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: size.width * 0.6),
                            child: Label14(text: detail!.client.pseudoClient, color: GlobalThemeData.lightColorScheme.onSurface, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () => Redirections().launchCall(context: context, number: detail!.client.telephone1),
                                  style: ButtonStyle(
                                    shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                            side: BorderSide(color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.1)),
                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                                        )
                                    ),
                                    backgroundColor: WidgetStateProperty.all(GlobalThemeData.lightColorScheme.onPrimary),
                                  ),
                                  icon: Icon(Icons.settings_phone_sharp, color: GlobalThemeData.lightColorScheme.primary, size: 20,)
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
        ],
      )
    );
  }
}
