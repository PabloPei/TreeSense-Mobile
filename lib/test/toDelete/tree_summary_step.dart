import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/presentation/state/tree_controller.dart';
import 'package:treesense/shared/utils/app_utils.dart' show MessageLoader;

class TreeSummaryStep extends ConsumerWidget {
  const TreeSummaryStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(treeCensusControllerProvider);
    final data = state.treeData;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${MessageLoader.get("save_tree_form_species")}: ${data?.species ?? '-'}',
        ),
        SizedBox(height: 10),
        Text(
          '${MessageLoader.get("save_tree_form_height")}: ${data?.height.toStringAsFixed(2) ?? '-'} m',
        ),
        SizedBox(height: 10),
        Text(
          '${MessageLoader.get("save_tree_form_diameter")}: ${data?.diameter.toStringAsFixed(2) ?? '-'} m',
        ),
        SizedBox(height: 10),
        Text(
          '${MessageLoader.get("save_tree_form_age")}: ${data?.age ?? '-'} años',
        ),
        SizedBox(height: 10),
        data?.imagePath != null
            ? Image.file(File(data!.imagePath!), height: 100)
            : Text(MessageLoader.get("save_tree_form_no_image")),
      ],
    );
  }
}
