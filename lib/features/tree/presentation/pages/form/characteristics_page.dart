import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/core/theme/format.dart';
import 'package:treesense/features/tree/presentation/widgets/census_progress_header.dart';
import 'package:treesense/features/tree/presentation/state/tree_state.dart';
import 'package:treesense/features/tree/presentation/state/tree_controller.dart';
import 'package:treesense/features/tree/presentation/widgets/goToCensusStep';
import 'package:treesense/shared/widgets/button_widget.dart';
import 'package:treesense/shared/widgets/dialogs/error_messages.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/features/tree/presentation/widgets/option_selector_field.dart';
import 'package:treesense/features/tree/presentation/widgets/dropdown_field.dart';
import 'package:treesense/features/tree/presentation/widgets/numeric_field.dart';


enum VitalidadEjemplar { Buena, Regular, Mala }
enum VariosFustes { Unico, Doble, Extenso }
enum TipoCopa { Redonda,  Columnar, Extendida, Irregular }
enum ManejoPrevioCopa { Formacion, Mantenimiento, Intervencion }

class TreeCensusCharacteristicsPage extends ConsumerStatefulWidget {
  const TreeCensusCharacteristicsPage({super.key});

  @override
  ConsumerState<TreeCensusCharacteristicsPage> createState() =>
      _TreeCensusCharacteristicsPageState();
}

class _TreeCensusCharacteristicsPageState
    extends ConsumerState<TreeCensusCharacteristicsPage> {
  final _formKey = GlobalKey<FormState>();

  bool? tocon;
  bool? cepa;
  VitalidadEjemplar? vitalidad;
  String? perimetroTallo;
  VariosFustes? variosFustes;
  TipoCopa? tipoCopa;
  String? simetriaCopa;
  ManejoPrevioCopa? manejoCopa;

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
              onStepTapped: (index) => goToCensusStep(context, index),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      // Especie
                      speciesAsync.when(
                        data: (speciesList) {
                          return DropdownButtonFormField<String>(
                            value: speciesList.contains(selectedSpecies)
                                ? selectedSpecies
                                : null,
                            decoration: InputDecoration(
                              labelText:
                                  MessageLoader.get("save_tree_form_species"),
                            ),
                            items: speciesList.map((species) {
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
                            validator: (value) => value == null
                                ? MessageLoader.get(
                                    'save_tree_form_species_required')
                                : null,
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (error, _) => WarningMessage(
                          title: MessageLoader.get('error_retrieve_species'),
                          message: error.toString(),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Altura
                      TextFormField(
                        decoration: InputDecoration(
                          labelText:
                              MessageLoader.get("save_tree_form_height"),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) return null;
                          final regex = RegExp(r'^\d*\.?\d*$');
                          return regex.hasMatch(value)
                              ? null
                              : MessageLoader.get(
                                  "incorrect_numeric_format_msg");
                        },
                        onChanged: (value) {
                          controller.updateTreeData(
                            height: double.tryParse(value) ?? 0.0,
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Diámetro
                      TextFormField(
                        decoration: InputDecoration(
                          labelText:
                              MessageLoader.get("save_tree_form_diameter"),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) return null;
                          final regex = RegExp(r'^\d*\.?\d*$');
                          return regex.hasMatch(value)
                              ? null
                              : MessageLoader.get(
                                  "incorrect_numeric_format_msg");
                        },
                        onChanged: (value) {
                          controller.updateTreeData(
                            diameter: double.tryParse(value) ?? 0.0,
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Edad
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
                                  "incorrect_numeric_format_msg");
                        },
                        onChanged: (value) {
                          controller.updateTreeData(
                            age: int.tryParse(value) ?? 0,
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      
                      // Perímetro del tallo
                      NumericField(
                        label: 'Perímetro del tallo (cm)',
                        initialValue: perimetroTallo,
                        onChanged: (val) =>
                            setState(() => perimetroTallo = val),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Simetría de copa
                      NumericField(
                        label: 'Simetría de copa (%)',
                        initialValue: simetriaCopa,
                        onChanged: (val) =>
                            setState(() => simetriaCopa = val),
                      ),
                      const SizedBox(height: AppSpacing.lg),

              
                      // Vitalidad
                      DropdownField<VitalidadEjemplar>(
                        label: 'Vitalidad del ejemplar',
                        items: VitalidadEjemplar.values,
                        selected: vitalidad,
                        onChanged: (val) => setState(() => vitalidad = val),
                        itemLabel: (val) => val.name,
                      ),
                      const SizedBox(height: AppSpacing.lg),


                      // Varios fustes
                      DropdownField<VariosFustes>(
                        label: 'Número de fustes',
                        items: VariosFustes.values,
                        selected: variosFustes,
                        onChanged: (val) => setState(() => variosFustes = val),
                        itemLabel: (val) => val.name,
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Tipo de copa
                      DropdownField<TipoCopa>(
                        label: 'Tipo de copa',
                        items: TipoCopa.values,
                        selected: tipoCopa,
                        onChanged: (val) => setState(() => tipoCopa = val),
                        itemLabel: (val) => val.name,
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      
                      // Manejo previo de copa
                      DropdownField<ManejoPrevioCopa>(
                        label: 'Manejo previo de copa',
                        items: ManejoPrevioCopa.values,
                        selected: manejoCopa,
                        onChanged: (val) => setState(() => manejoCopa = val),
                        itemLabel: (val) => val.name,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      OptionSelector<bool>(
                        label: '¿Tiene tocón?',
                        options: const [true, false],
                        selected: tocon,
                        onChanged: (val) => setState(() => tocon = val),
                        optionLabel: (val) => val ? 'Sí' : 'No',
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Cepa
                      OptionSelector<bool>(
                        label: '¿Tiene cepa?',
                        options: const [true, false],
                        selected: cepa,
                        onChanged: (val) => setState(() => cepa = val),
                        optionLabel: (val) => val ? 'Sí' : 'No',
                      ),
                      const SizedBox(height: AppSpacing.lg),

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
