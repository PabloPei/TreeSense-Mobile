import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/features/tree/presentation/widgets/census_progress_header.dart';
import 'package:treesense/features/tree/presentation/widgets/dropdown_field.dart';
import 'package:treesense/features/tree/presentation/widgets/numeric_field.dart';
import 'package:treesense/features/tree/presentation/widgets/option_selector_field.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/features/tree/presentation/state/tree_state.dart';
import 'package:treesense/shared/widgets/button_widget.dart';
import 'package:treesense/core/theme/app_theme.dart';

enum Barrio { centro, norte, sur }

class TreeCensusLocationPage extends ConsumerStatefulWidget {
  const TreeCensusLocationPage({super.key});

  @override
  ConsumerState<TreeCensusLocationPage> createState() =>
      _TreeCensusLocationPageState();
}

class _TreeCensusLocationPageState
    extends ConsumerState<TreeCensusLocationPage> {
  Barrio? selectedBarrio;
  String? _altura;
  bool? arbolSeco;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CensusProgressHeader(
                currentStep: TreeCensusFormStep.location,
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
              const SizedBox(height: AppSpacing.lg),
              DropdownField<Barrio>(
                label: 'Barrio',
                items: Barrio.values,
                selected: selectedBarrio,
                onChanged: (value) => setState(() => selectedBarrio = value),
                itemLabel: (b) => b.name,
              ),
              const SizedBox(height: AppSpacing.lg),
              NumericField(
                label: 'Altura estimada (m)',
                initialValue: _altura,
                onChanged: (val) {
                  setState(() => _altura = val);
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              OptionSelector<bool>(
                label: '¿Seco en pie?',
                options: const [true, false],
                selected: arbolSeco,
                onChanged: (val) => setState(() => arbolSeco = val),
                optionLabel: (b) => b ? 'Sí' : 'No',
              ),
              const Spacer(),
              ButtonWidget(
                text: MessageLoader.get('save_tree_form_continue'),
                color: primarySeedColor,
                onPressed: () => context.push('/tree-census/characteristics'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
