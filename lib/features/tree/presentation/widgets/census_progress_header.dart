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
  final void Function(int)? onStepTapped;

  const CensusProgressHeader({
    super.key,
    required this.currentStep,
    required this.steps,
    this.onStepTapped,
  });

  Future<bool?> _showExitConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmación'),
        content: Text(MessageLoader.get('exit_warning_massage')),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(MessageLoader.get('cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(MessageLoader.get('exit')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                iconSize: 40,
                tooltip: MessageLoader.get('save_tree_form_back'),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/tree-census/type'); // Ruta segura
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.close),
                iconSize: 40,
                tooltip: 'Cancelar y Salir',
                onPressed: () async {
                  final shouldExit = await _showExitConfirmationDialog(context);
                  if (shouldExit == true) {
                    context.go('/home');
                  }
                },
              ),
            ],
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(steps.length * 2 - 1, (index) {
              if (index.isEven) {
                final stepIndex = index ~/ 2;
                final isActive = stepIndex == currentStep.index;

                return GestureDetector(
                  onTap: onStepTapped != null
                      ? () => onStepTapped!(stepIndex)
                      : null,
                  child: CircleAvatar(
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
                  ),
                );
              } else {
                return const SizedBox(
                  width: 16,
                  child: Divider(thickness: 2, color: Colors.grey),
                );
              }
            }),
          ),
        ),
      ],
    );
  }
}
