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
import 'package:treesense/test/temp_main_form.dart';

enum Barrio { centro, norte, sur }
enum Ubicacion_Plantera { Centrada, Esquina, Borde }
enum Forma_Plantera { Circular, Cuadrada, Rectangular }
enum Nivel_Plantera { Raz, Vereda, Elevada }



class TreeCensusLocationPage extends ConsumerStatefulWidget {
  const TreeCensusLocationPage({super.key});

  @override
  ConsumerState<TreeCensusLocationPage> createState() =>
      _TreeCensusLocationPageState();
}

class _TreeCensusLocationPageState extends ConsumerState<TreeCensusLocationPage> {
  Barrio? selectedBarrio;
  String? _altura;
  bool? arbolSeco;
  String? _anchoVereda;

  Ubicacion_Plantera? _ubicacionPlantera;
  Forma_Plantera? _formaPlantera;
  Nivel_Plantera? _nivelPlantera;
  String? _dimensionesPlantera;

  bool get hayPlantera {
    final type = ref.watch(treeTypeProvider);
    return type == TreeCensusType.arbolConPlantera || type == TreeCensusType.planteraVacia;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
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

              if (hayPlantera) ...[
                DropdownField<Ubicacion_Plantera>(
                  label: 'Ubicación de plantera',
                  items: Ubicacion_Plantera.values,
                  selected: _ubicacionPlantera,
                  onChanged: (value) => setState(() => _ubicacionPlantera = value),
                  itemLabel: (u) => u.name,
                ),
                const SizedBox(height: AppSpacing.lg),

                DropdownField<Forma_Plantera>(
                  label: 'Forma de plantera',
                  items: Forma_Plantera.values,
                  selected: _formaPlantera,
                  onChanged: (val) => setState(() => _formaPlantera = val),
                  itemLabel: (f) => f.name,
                ),
                const SizedBox(height: AppSpacing.lg),

                DropdownField<Nivel_Plantera>(
                  label: 'Nivel de plantera',
                  items: Nivel_Plantera.values,
                  selected: _nivelPlantera,
                  onChanged: (values) => setState(() => _nivelPlantera = values),
                  itemLabel: (n) => n.name,
                ),
                const SizedBox(height: AppSpacing.lg),

                NumericField(
                  label: 'Dimensiones de plantera (m²)',
                  initialValue: _dimensionesPlantera,
                  onChanged: (val) => setState(() => _dimensionesPlantera = val),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],

              NumericField(
                label: 'Altura estimada (m)',
                initialValue: _altura,
                onChanged: (val) => setState(() => _altura = val),
              ),

                const SizedBox(height: AppSpacing.lg),

              NumericField(
                label: 'Ancho de vereda (m)',
                initialValue: _anchoVereda,
                onChanged: (val) => setState(() => _anchoVereda = val),
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
                onPressed: () {
                  context.push('/tree-census/characteristics');
                },
              ),
            ],
          
        ),
      ),
    );
  }
}
