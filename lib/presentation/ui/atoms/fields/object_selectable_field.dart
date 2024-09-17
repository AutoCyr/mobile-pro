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
  required List<Selectable> options,
  required BuildContext context,
  required String typeSelection,
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
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CustomSearchable(
        controller: controller,
        list: options,
        typeSelection: typeSelection,
    ))),
  );
}