import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/presentation/widgets/tree_data_step.dart';
import 'package:treesense/features/tree/infrastructure/models/tree_impl.dart';
import 'package:treesense/features/tree/presentation/widgets/tree_image_step.dart';
import 'package:treesense/features/tree/presentation/widgets/tree_summary_step.dart';
import 'package:treesense/features/tree/presentation/state/tree_provider.dart';

class TreeCensusForm extends ConsumerStatefulWidget {
  const TreeCensusForm({super.key});

  @override
  TreeCensusFormState createState() => TreeCensusFormState();
}

class TreeCensusFormState extends ConsumerState<TreeCensusForm> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  Future<void> _continue() async {
    if (_currentStep == 0) {
      if (_formKey.currentState?.validate() ?? false) {
        _formKey.currentState?.save();

        // Obtener los valores del formulario desde el estado del controlador
        final treeController = ref.read(treeCensusControllerProvider.notifier);
        final species = treeController.getSpecies;
        final height = treeController.getHeight;
        final diameter = treeController.getDiameter;
        final age = treeController.getAge;

        // Crear el objeto Tree con los datos del formulario
        final tree = TreeImpl(
          species: species,
          height: height,
          diameter: diameter,
          age: age,
        );

        // Asignar los datos del árbol al controlador
        treeController.setTreeData(tree);
      } else {
        return; // Si el formulario no es válido, no continuar
      }
    }

    if (_currentStep == 2) {
      final saveTreeUseCase = ref.read(treeCensusControllerProvider.notifier);

      String responseMessage;
      try {
        responseMessage = await saveTreeUseCase.saveTree();
      } catch (e) {
        responseMessage = 'Error al guardar datos: ${e.toString()}';
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Resultado de la Carga'),
          content: Text(responseMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _cancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carga de Datos')),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepTapped: (step) => setState(() => _currentStep = step),
        onStepContinue: _continue,
        onStepCancel: _cancel,
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Container(
            margin: EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      _currentStep == 2 ? 'FINALIZAR' : 'SIGUIENTE',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text('ATRÁS', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: Text('Datos'),
            content: TreeDataStep(formKey: _formKey),
          ),
          Step(
            title: Text('Imagen'),
            content: TreeImageStep(),
          ),
          Step(
            title: Text('Resumen'),
            content: TreeSummaryStep(),
          ),
        ],
      ),
    );
  }
}
