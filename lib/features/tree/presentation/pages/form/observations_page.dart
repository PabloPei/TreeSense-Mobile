import 'package:flutter/material.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/features/tree/presentation/widgets/census_progress_header.dart';
import 'package:treesense/features/tree/presentation/widgets/goToCensusStep';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/features/tree/presentation/state/tree_state.dart';
import 'package:treesense/shared/widgets/button_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/presentation/state/tree_controller.dart';
import 'package:treesense/shared/widgets/dialogs/error_messages.dart';

class TreeCensusObservationsPage extends ConsumerStatefulWidget {
  const TreeCensusObservationsPage({super.key});

  @override
  ConsumerState<TreeCensusObservationsPage> createState() => _TreeCensusObservationsPageState();
}

class _TreeCensusObservationsPageState extends ConsumerState<TreeCensusObservationsPage> {
  String? observaciones;

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(treeCensusControllerProvider.notifier);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CensusProgressHeader(
              currentStep: TreeCensusFormStep.observations,
              steps: [
                MessageLoader.get('step_one'),
                MessageLoader.get('step_two'),
                MessageLoader.get('step_three'),
                MessageLoader.get('step_four'),
                MessageLoader.get('step_five'),
                MessageLoader.get('step_six'),
                MessageLoader.get('step_seven'),
              ],
              onStepTapped: (index) => goToCensusStep(context, index),
            ),
            const SizedBox(height: 20),
            const Text("Observaciones"),
            TextFormField(
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Escriba aquí cualquier observación adicional",
              ),
              onChanged: (val) => setState(() => observaciones = val),
            ),
            const Spacer(),
            ButtonWidget(
              text: MessageLoader.get('save_tree_form_continue'),
              color: primarySeedColor,
              onPressed: () {
                final isValid = true; // TODO: Agregar validaciones reales
                if (isValid) {
                  context.push('/tree-census/summary');
                } else {
                  BlockErrorDialog.showErrorDialog(
                    context,
                    MessageLoader.get("error_title"),
                    MessageLoader.get("save_tree_form_incomplete"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}