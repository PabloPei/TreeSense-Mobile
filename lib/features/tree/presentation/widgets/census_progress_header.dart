import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/features/tree/presentation/state/tree_state.dart';

class CensusProgressHeader extends StatelessWidget {
  final TreeCensusFormStep currentStep;
  final List<String> steps;

  const CensusProgressHeader({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.chevron_left),
            iconSize: 40,
            tooltip: MessageLoader.get('save_tree_form_back'),
            onPressed: () => context.pop(),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
          child: Text(
            steps[currentStep.index],
            style: AppTextStyles.formStepTitleStyle,
          ),
        ),

        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm,
            horizontal: AppSpacing.lg,
          ),
          child: Row(
            children: List.generate(steps.length * 2 - 1, (index) {
              if (index.isEven) {
                final stepIndex = index ~/ 2;
                final isActive = stepIndex == currentStep.index;

                return CircleAvatar(
                  radius: 14,
                  backgroundColor:
                      isActive ? primarySeedColor : Colors.grey.shade400,
                  child: Text(
                    '${stepIndex + 1}',
                    style: AppTextStyles.captionTextStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: Divider(thickness: 2, color: Colors.grey.shade300),
                );
              }
            }),
          ),
        ),
      ],
    );
  }
}
