import 'package:flutter/material.dart';
import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:intl/intl.dart';

class TreeCard extends StatelessWidget {
  final Tree tree;

  const TreeCard({super.key, required this.tree});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatted = DateFormat(dateFormatPattern);

    final formattedDate = dateFormatted.format(tree.createdAt);

    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icons/tree.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Text(tree.species, style: AppTextStyles.titleStyle),
              ],
            ),
            const SizedBox(height: 10),

            Text(
              '${MessageLoader.get('tree_form_createAt')}: $formattedDate',
              style: AppTextStyles.bodyTextStyle,
            ),
            const SizedBox(height: 5),
            Text(
              '${MessageLoader.get('save_tree_form_height')}: ${tree.height}',
              style: AppTextStyles.bodyTextStyle,
            ),
            const SizedBox(height: 5),
            Text(
              '${MessageLoader.get('save_tree_form_age')}: ${tree.age} ',
              style: AppTextStyles.bodyTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
