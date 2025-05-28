import 'package:flutter/material.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/presentation/state/tree_controller.dart';
import 'dart:io';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/core/theme/font_conf.dart';

class TreeSummarySheet extends ConsumerWidget {
  const TreeSummarySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(treeCensusControllerProvider).treeData;
    final species = data?.species ?? '-';
    final height = data?.height.toStringAsFixed(2) ?? '-';
    final diameter = data?.diameter.toStringAsFixed(2) ?? '-';
    final age = data?.age.toString() ?? '-';
    final imagePath = data?.imagePath;

    final fields = [
      //TODO: pasar al es.JSON los campos de texto de las respuestas
      (MessageLoader.get('save_tree_form_species'), species, Icons.park),
      (MessageLoader.get('save_tree_form_height'), '$height m', Icons.height),
      (
        MessageLoader.get('save_tree_form_diameter'),
        '$diameter m',
        Icons.swap_horiz,
      ),
      (
        MessageLoader.get('save_tree_form_age'),
        '$age años',
        Icons.calendar_today,
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...fields.asMap().entries.map((entry) {
            final index = entry.key;
            final (label, value, icon) = entry.value;
            final color = greenShades[index % greenShades.length];
            return SummaryTile(
              label: label,
              value: value,
              icon: icon,
              backgroundColor: color,
            );
          }).toList(),
          const SizedBox(height: 16),
          SummaryTile(
            label: MessageLoader.get('save_tree_form_image'),
            value:
                imagePath != null
                    ? ''
                    : MessageLoader.get("save_tree_form_no_image"),
            icon: Icons.image,
            backgroundColor: greenShades[fields.length % greenShades.length],
            child:
                imagePath != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                      child: Image.file(
                        File(imagePath),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                    : null,
          ),
        ],
      ),
    );
  }
}

class SummaryTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color backgroundColor;
  final Widget? child;

  const SummaryTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.backgroundColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppBorderRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.summaryTitleStyle),
                const SizedBox(height: AppSpacing.xs),
                value.isNotEmpty
                    ? Text(value, style: AppTextStyles.summaryBodyStyle)
                    : const SizedBox.shrink(),
                if (child != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  child!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
