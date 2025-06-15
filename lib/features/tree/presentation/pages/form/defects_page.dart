import 'package:flutter/material.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/features/tree/presentation/widgets/census_progress_header.dart';
import 'package:treesense/features/tree/presentation/widgets/goToCensusStep';
import 'package:treesense/features/tree/presentation/widgets/numeric_field.dart';
import 'package:treesense/features/tree/presentation/widgets/option_selector_field.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/features/tree/presentation/state/tree_state.dart';
import 'package:treesense/shared/widgets/button_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/presentation/state/tree_controller.dart';
import 'package:treesense/shared/widgets/dialogs/error_messages.dart';

class TreeCensusDefectsPage extends ConsumerStatefulWidget {
  const TreeCensusDefectsPage({super.key});

  @override
  ConsumerState<TreeCensusDefectsPage> createState() => _TreeCensusDefectsPageState();
}

class _TreeCensusDefectsPageState extends ConsumerState<TreeCensusDefectsPage> {
  bool? cortezaIncluida;
  String? inclinacionFuste;
  bool? chupones;
  bool? descortezamiento;
  String? pudriciones;
  String? grietas;
  bool? cancros;
  bool? heridasMecanicas;

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(treeCensusControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            CensusProgressHeader(
              currentStep: TreeCensusFormStep.defects,
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
             NumericField(
              label: 'Inclinación del Fuste (Grados)',
                initialValue: inclinacionFuste,
                onChanged: (val) => setState(() => inclinacionFuste = val),
            ),

            const SizedBox(height: 12),
            OptionSelector<bool>(
              label: "¿Corteza incluida?",
              options: const [true, false],
              selected: cortezaIncluida,
              onChanged: (val) => setState(() => cortezaIncluida = val),
              optionLabel: (b) => b ? 'Sí' : 'No',
            ),
            const SizedBox(height: 12),
            
           
            OptionSelector<bool>(
              label: "¿Chupones?",
              options: const [true, false],
              selected: chupones,
              onChanged: (val) => setState(() => chupones = val),
              optionLabel: (b) => b ? 'Sí' : 'No',
            ),
            const SizedBox(height: 12),
            OptionSelector<bool>(
              label: "¿Descortezamiento?",
              options: const [true, false],
              selected: descortezamiento,
              onChanged: (val) => setState(() => descortezamiento = val),
              optionLabel: (b) => b ? 'Sí' : 'No',
            ),
            const SizedBox(height: 12),
            OptionSelector<String>(
              label: "Pudriciones",
              options: const ['Leve', 'Moderada', 'Severa'],
              selected: pudriciones,
              onChanged: (val) => setState(() => pudriciones = val),
              optionLabel: (s) => s,
            ),
            const SizedBox(height: 12),
            OptionSelector<String>(
              label: "Grietas",
              options: const ['Leve', 'Moderada', 'Severa'],
              selected: grietas,
              onChanged: (val) => setState(() => grietas = val),
              optionLabel: (s) => s,
            ),
            const SizedBox(height: 12),
            OptionSelector<bool>(
              label: "¿Cancros?",
              options: const [true, false],
              selected: cancros,
              onChanged: (val) => setState(() => cancros = val),
              optionLabel: (b) => b ? 'Sí' : 'No',
            ),
            const SizedBox(height: 12),
            OptionSelector<bool>(
              label: "¿Heridas mecánicas?",
              options: const [true, false],
              selected: heridasMecanicas,
              onChanged: (val) => setState(() => heridasMecanicas = val),
              optionLabel: (b) => b ? 'Sí' : 'No',
            ),
            const Spacer(),
            ButtonWidget(
              text: MessageLoader.get('save_tree_form_continue'),
              color: primarySeedColor,
              onPressed: () {
                final isValid = true; // TODO: Agregar validaciones reales
                if (isValid) {
                  context.push('/tree-census/photo');
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
