import 'package:flutter/material.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/core/theme/font_conf.dart';

class OptionSelector<T> extends StatelessWidget {
  final String label;
  final List<T> options;
  final T? selected;
  final void Function(T) onChanged;
  final String Function(T) optionLabel;

  const OptionSelector({
    super.key,
    required this.label,
    required this.options,
    required this.selected,
    required this.onChanged,
    required this.optionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.userLabelStyle),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.sm,
          children:
              options.map((e) {
                final isSelected = e == selected;
                return ChoiceChip(
                  label: Text(optionLabel(e)),
                  selected: isSelected,
                  onSelected: (_) => onChanged(e),
                );
              }).toList(),
        ),
      ],
    );
  }
}
