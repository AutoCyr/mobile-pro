import 'package:autocyr_pro/presentation/ui/organisms/selectors/selector.dart';
import 'package:flutter/material.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';

Widget CustomSelectableField({
  required TextEditingController controller,
  required String key,
  required TextInputType keyboardType,
  required String label,
  required double fontSize,
  required IconData icon,
  required List options,
  required String Function(dynamic) displayField,
  required final Function(dynamic) onSelected,
  required BuildContext context,
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
    style: TextStyle(
      fontSize: fontSize
    ),
    onTap: () => BottomSelector().showObjectLabelMenu(
      context: context,
      title: label,
      options: options,
      displayField: (dynamic value) => displayField(value),
      onSelected: (dynamic value) => onSelected(value)
    ),
  );
}