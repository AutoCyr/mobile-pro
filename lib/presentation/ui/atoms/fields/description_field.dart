import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:flutter/material.dart';

Widget DescriptionField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String label,
  required double fontSize,
  required IconData icon
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    maxLines: 7,
    decoration: InputDecoration(
      filled: true,
      fillColor: GlobalThemeData.lightColorScheme.primary.withOpacity(0.1),
      labelText: label,
      prefixIcon: Icon(icon),
      labelStyle: TextStyle(
        fontSize: fontSize
      )
    ),
    style: TextStyle(
      fontSize: fontSize
    )
  );
}