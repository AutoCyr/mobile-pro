import 'package:autocyr_pro/presentation/ui/organisms/selectors/selector.dart';
import 'package:flutter/material.dart';

import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:flutter/material.dart';

Widget SmallObjectSelectableField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String label,
  required double fontSize,
  required IconData icon,
  required List options,
  required BuildContext context,
  required Function(Object) onSelected,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    readOnly: true,
    decoration: InputDecoration(
      filled: true,
      fillColor: GlobalThemeData.lightColorScheme.primary.withOpacity(0.1),
      labelText: label,
      prefixIcon: Icon(icon),
      labelStyle: TextStyle(
        fontSize: fontSize
      )
    ),
    onTap: () => BottomSelector().showObjectLabelMenu(
      context: context,
      title: label,
      options: options,
      onSelected: (value) => onSelected(value)
    ),
  );
}