import 'package:flutter/material.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/features/tree/presentation/widgets/census_progress_header.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/features/tree/presentation/state/tree_state.dart';
import 'package:treesense/shared/widgets/button_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/presentation/state/tree_controller.dart';
import 'package:treesense/shared/widgets/dialogs/error_messages.dart';

class TreeCensusCharacteristicsPage extends ConsumerStatefulWidget {
  const TreeCensusCharacteristicsPage({super.key});

  @override
  ConsumerState<TreeCensusCharacteristicsPage> createState() =>
      _TreeCensusCharacteristicsPageState();
}

class _TreeCensusCharacteristicsPageState
    extends ConsumerState<TreeCensusCharacteristicsPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(treeCensusControllerProvider.notifier);
    final speciesAsync = ref.watch(treeSpeciesProvider);
    final selectedSpecies =
        ref.watch(treeCensusControllerProvider).treeData?.species;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CensusProgressHeader(
              currentStep: TreeCensusFormStep.characteristics,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      speciesAsync.when(
                        data: (speciesList) {
                          return DropdownButtonFormField<String>(
                            value:
                                speciesList.contains(selectedSpecies)
                                    ? selectedSpecies
                                    : null,
                            decoration: InputDecoration(
                              labelText: MessageLoader.get(
                                "save_tree_form_species",
                              ),
                            ),
                            items:
                                speciesList.map((species) {
                                  return DropdownMenuItem<String>(
                                    value: species,
                                    child: Text(species),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.updateTreeData(species: value);
                              }
                            },
                            validator:
                                (value) =>
                                    value == null
                                        ? MessageLoader.get(
                                          'save_tree_form_species_required',
                                        )
                                        : null,
                          );
                        },
                        loading:
                            () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        error:
                            (error, _) => WarningMessage(
                              title: MessageLoader.get(
                                'error_retrieve_species',
                              ),
                              message: error.toString(),
                            ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: MessageLoader.get("save_tree_form_height"),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) return null;
                          final regex = RegExp(r'^\d*\.?\d*$');
                          return regex.hasMatch(value)
                              ? null
                              : MessageLoader.get(
                                "incorrect_numeric_format_msg",
                              );
                        },
                        onChanged: (value) {
                          controller.updateTreeData(
                            height: double.tryParse(value) ?? 0.0,
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: MessageLoader.get(
                            "save_tree_form_diameter",
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) return null;
                          final regex = RegExp(r'^\d*\.?\d*$');
                          return regex.hasMatch(value)
                              ? null
                              : MessageLoader.get(
                                "incorrect_numeric_format_msg",
                              );
                        },
                        onChanged: (value) {
                          controller.updateTreeData(
                            diameter: double.tryParse(value) ?? 0.0,
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: MessageLoader.get("save_tree_form_age"),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) return null;
                          final regex = RegExp(r'^\d+$');
                          return regex.hasMatch(value)
                              ? null
                              : MessageLoader.get(
                                "incorrect_numeric_format_msg",
                              );
                        },
                        onChanged: (value) {
                          controller.updateTreeData(
                            age: int.tryParse(value) ?? 0,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ButtonWidget(
              text: MessageLoader.get('save_tree_form_continue'),
              color: primarySeedColor,
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  context.push('/tree-census/defects');
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
