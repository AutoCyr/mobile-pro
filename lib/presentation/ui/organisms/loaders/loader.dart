import 'package:autocyr_pro/presentation/ui/atoms/labels/label10.dart';
import 'package:autocyr_pro/presentation/ui/atoms/loaders/loading.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Widget Loader({required BuildContext context, required Size size, required String message}) {
  return SizedBox(
    width: size.width,
    height: size.height - kToolbarHeight,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Label10(text: message, color: GlobalThemeData.lightColorScheme.primary, weight: FontWeight.bold, maxLines: 1),
          const Gap(5),
          Loading(
              widthSize: size.width * 0.9,
              context: context,
              bgColor: GlobalThemeData.lightColorScheme.onPrimary,
              shimmerColor: GlobalThemeData.lightColorScheme.primary
          ),
        ]
    )
  );
}