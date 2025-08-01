import 'package:flutter/material.dart';

Widget BackBackground({required Size size}){
  return Container(
    height: size.height,
    width: double.infinity,
    child: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/back-1.webp",
            fit: BoxFit.cover,
            alignment: Alignment.center,
            // Ignorer les métadonnées d'orientation
            excludeFromSemantics: true,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
      ],
    ),
  );
}