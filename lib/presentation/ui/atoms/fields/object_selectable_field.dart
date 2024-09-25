import 'package:autocyr_pro/domain/models/abstractables/selectable.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:autocyr_pro/presentation/ui/organisms/searchables/searchable.dart';
import 'package:flutter/material.dart';

Widget ObjectSelectableField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String label,
  required double fontSize,
  required IconData icon,
  required BuildContext context,
  required Function() onSelected,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    readOnly: true,
    decoration: InputDecoration(
      focusColor: GlobalThemeData.lightColorScheme.primary,
      filled: true,
      fillColor: GlobalThemeData.lightColorScheme.primary.withOpacity(0.1),
      labelText: label,
      prefixIcon: Icon(icon),
      labelStyle: TextStyle(
        fontSize: fontSize
      )
    ),
    onTap: () => onSelected(),
  );
}