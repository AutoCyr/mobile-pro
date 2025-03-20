import 'package:autocyr_pro/domain/models/features/demande.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label10.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/screens/pages/requests/detail.dart';
import 'package:autocyr_pro/domain/models/features/demande.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class RequestWidget extends StatelessWidget {
  final Demande demande;
  const RequestWidget({super.key, required this.demande});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RequestDetailScreen(demande: demande))),
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.1), width: 1),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Label14(text: "#${demande.reference}", color: Colors.black87, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
                  const Gap(10),
                  Label12(text: demande.article.name, color: Colors.black87, weight: FontWeight.bold, maxLines: 2).animate().fadeIn(),
                  const Gap(10),
                  Label10(text: demande.descriptionPiece, color: Colors.black87, weight: FontWeight.normal, maxLines: 3).animate().fadeIn(),
                  const Gap(5),
                  Label12(text: "le ${DateFormat.yMMMMEEEEd("fr").format(demande.dateDemande)} à ${DateFormat.Hm("fr").format(demande.dateDemande)}", color: Colors.black87, weight: FontWeight.normal, maxLines: 1).animate().fadeIn(),
                ],
              ),
            ),
            Container(
              width: size.width * 0.1,
              height: size.width * 0.1,
              decoration: BoxDecoration(
                  color: GlobalThemeData.lightColorScheme.primary,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(5))
              ),
              child: Center(
                child: Icon(Icons.chevron_right, size: 20, color: GlobalThemeData.lightColorScheme.onPrimary),
              ).animate().fadeIn(),
            )
          ],
        ),
      ),
    );
  }
}
