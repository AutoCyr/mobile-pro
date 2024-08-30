import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:flutter/material.dart';

Widget BackGradientOverlay({required Size size}) {
  return Positioned(
    bottom: 0,
    child: Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              GlobalThemeData.lightColorScheme.primaryFixed.withOpacity(0.4),
              GlobalThemeData.lightColorScheme.primaryFixed.withOpacity(0.8),
              GlobalThemeData.lightColorScheme.primaryFixed
            ],
            stops: const [0, 0.2, 0.4, 1],
          )
      ),
    ),
  );
}