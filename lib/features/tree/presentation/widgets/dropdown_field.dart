import 'package:flutter/material.dart';
import 'package:treesense/core/theme/format.dart';

class DropdownField<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final T? selected;
  final void Function(T?) onChanged;
  final String Function(T) itemLabel;

  const DropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.selected,
    required this.onChanged,
    required this.itemLabel,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selected,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
        ),
      ),
      items:
          items.map((e) {
            return DropdownMenuItem<T>(value: e, child: Text(itemLabel(e)));
          }).toList(),
      onChanged: onChanged,
    );
  }
}
