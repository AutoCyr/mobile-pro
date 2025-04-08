import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label30.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:flutter/material.dart';

Widget LargeOverview({
  required BuildContext context,
  required String label,
  required String value,
  required String icon,
  required Size size,
  Widget? child,
}) {
  return InkWell(
    splashColor: Colors.transparent,
    onTap: () {
      if(child != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => child));
      }
    },
    child: Container(
      width: size.width,
      height: 100,
      decoration: BoxDecoration(
        color: GlobalThemeData.lightColorScheme.onPrimary,
        border: Border.all(
            color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.5),
            width: 1
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Label12(
                      text: label,
                      color: GlobalThemeData.lightColorScheme.onSecondaryFixed,
                      weight: FontWeight.bold,
                      maxLines: 1
                  ),
                  Label30(
                      text: value,
                      color: GlobalThemeData.lightColorScheme.primary,
                      weight: FontWeight.bold,
                      maxLines: 1
                  ),
                ]
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Image.asset(icon, width: 50, fit: BoxFit.fill,),
          ),
        ],
      ),
    ),
  );
}