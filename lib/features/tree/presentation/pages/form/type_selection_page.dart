import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/features/tree/presentation/widgets/goToCensusStep';
import 'package:treesense/test/temp_main_form.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/features/tree/presentation/widgets/entry_type_button.dart';
import 'package:treesense/features/tree/presentation/widgets/census_progress_header.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/features/tree/presentation/state/tree_state.dart';

//TODO: importar controller y provider real y usarlos

class TypeSelectionPage extends ConsumerWidget {
  const TypeSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme.surface;
    //final selected = ref.watch(treeTypeProvider);

    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
        child: Column(
          children: [
            CensusProgressHeader(
              currentStep: TreeCensusFormStep.typeSelection, 
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //TODO: buscar mejores fotos para los botones, estas se ven medio pixeladas, ver como disponer los botones en la pantalla
                    EntryTypeButton(
                      name: MessageLoader.get('tree_in_pot'),
                      imagePath: 'assets/icons/tree_in_pot.png',
                      onPressed: () {
                        ref.read(treeTypeProvider.notifier).state =
                            TreeCensusType.arbolConPlantera;
                        context.push('/tree-census/location'); // TODO
                      },
                    ),
                    EntryTypeButton(
                      name: MessageLoader.get('standalone_tree'),
                      imagePath: 'assets/icons/tree_v2.png',
                      onPressed: () {
                        ref.read(treeTypeProvider.notifier).state =
                            TreeCensusType.arbolSinPlantera;
                        context.push('/tree-census/location'); // TODO
                      },
                    ),
                    EntryTypeButton(
                      name: MessageLoader.get('empty_pot'),
                      imagePath: 'assets/icons/plant_pot.png',
                      onPressed: () {
                        ref.read(treeTypeProvider.notifier).state =
                            TreeCensusType.planteraVacia;
                        context.push('/tree-census/location'); // TODO
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
