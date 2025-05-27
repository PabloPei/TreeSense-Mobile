import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:treesense/core/theme/format.dart';
import 'package:treesense/shared/utils/app_utils.dart';
//import 'package:treesense/core/theme/font_conf.dart';

class NumericField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final ValueChanged<String> onChanged;

  const NumericField({
    super.key,
    required this.label,
    this.initialValue,
    required this.onChanged,
  });

  bool _isValid(String input) {
    final regex = RegExp(r'^\d*\.?\d*$');
    return input.isEmpty || regex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        errorText:
            initialValue != null && !_isValid(initialValue!)
                ? MessageLoader.get('incorrect_numeric_format_msg')
                : null,
      ),
      onChanged: onChanged,
    );
  }
}
