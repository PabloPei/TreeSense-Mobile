import 'package:flutter/material.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/features/tree/presentation/widgets/census_progress_header.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/features/tree/presentation/state/tree_state.dart';
import 'package:treesense/shared/widgets/button_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/presentation/state/tree_controller.dart';
import 'package:treesense/shared/widgets/dialogs/error_messages.dart';

class TreeCensusSummaryPage extends ConsumerWidget {
  const TreeCensusSummaryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(treeCensusControllerProvider.notifier);
    return Scaffold(
      body: Column(
        children: [
          CensusProgressHeader(
            currentStep: TreeCensusFormStep.summary,
            steps: [
              MessageLoader.get('step_one'),
              MessageLoader.get('step_two'),
              MessageLoader.get('step_three'),
              MessageLoader.get('step_four'),
              MessageLoader.get('step_five'),
              MessageLoader.get('step_six'),
              MessageLoader.get('step_seven'),
            ],
          ),
          const Spacer(),
          ButtonWidget(
            text: MessageLoader.get('save_tree_form_finish'),
            color: primarySeedColor,
            onPressed: () async {
              try {
                final msg = await controller.saveTree();
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(msg)));
                  context.go('/home');
                }
              } catch (e) {
                if (context.mounted) {
                  BlockErrorDialog.showErrorDialog(
                    context,
                    MessageLoader.get("error_title"),
                    e.toString(),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
