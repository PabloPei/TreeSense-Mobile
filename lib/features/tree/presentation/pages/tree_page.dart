import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/features/tree/presentation/widgets/tree_data_step.dart';
import 'package:treesense/features/tree/presentation/widgets/tree_image_step.dart';
import 'package:treesense/features/tree/presentation/widgets/tree_summary_step.dart';
import 'package:treesense/features/tree/presentation/state/tree_controller.dart';
import 'package:treesense/features/tree/presentation/state/tree_state.dart';
import 'package:treesense/shared/utils/app_utils.dart';

class TreeCensusForm extends ConsumerStatefulWidget {
  const TreeCensusForm({super.key});

  @override
  TreeCensusFormState createState() => TreeCensusFormState();
}

class TreeCensusFormState extends ConsumerState<TreeCensusForm> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _continue() async {
    final treeController = ref.read(treeCensusControllerProvider.notifier);
    bool failSavingTree = false;

    if (_formKey.currentState?.validate() ?? false) {
      if (ref.watch(treeCensusControllerProvider).step ==
          TreeCensusFormStep.resume) {
        final saveTreeUseCase = ref.read(treeCensusControllerProvider.notifier);

        String responseMessage;
        try {
          responseMessage = await saveTreeUseCase.saveTree();
        } catch (e) {
          responseMessage = e.toString();
          failSavingTree = true;
        }

        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text(MessageLoader.get("saved_tree_result")),
                content: Text(responseMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (failSavingTree) {
                        context.pop();
                      } else {
                        context.go('/home');
                      }
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
        );
      } else {
        treeController.nextStep();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(MessageLoader.get("save_tree_form_incomplete"))),
      );
    }
  }

  void _cancel() {
    final treeController = ref.read(treeCensusControllerProvider.notifier);
    treeController.previousStep();
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(treeCensusControllerProvider).step;

    return Scaffold(
      appBar: AppBar(title: Text(MessageLoader.get("save_tree"))),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: TreeCensusFormStep.values.indexOf(currentStep),
        onStepTapped: (step) {
          if (step < TreeCensusFormStep.values.indexOf(currentStep)) {
            ref.read(treeCensusControllerProvider.notifier).nextStep();
          }
        },
        onStepContinue: _continue,
        onStepCancel: _cancel,
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: details.onStepCancel,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade600),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      foregroundColor: Colors.grey.shade800,
                    ),
                    child: Text(
                      MessageLoader.get("save_tree_form_back"),
                      style: AppTextStyles.buttonNegativeTextStyle,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      elevation: 3,
                      shadowColor: Colors.black45,
                    ),
                    child: Text(
                      currentStep == TreeCensusFormStep.resume
                          ? MessageLoader.get("save_tree_form_finish")
                          : MessageLoader.get("save_tree_form_continue"),
                      style: AppTextStyles.bottomTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          );
        },

        steps: [
          Step(
            title: Text(MessageLoader.get("save_tree_form_data")),
            content: TreeDataStep(formKey: _formKey),
          ),
          Step(
            title: Text(MessageLoader.get("save_tree_form_image")),
            content: TreeImageStep(),
          ),
          Step(
            title: Text(MessageLoader.get("save_tree_form_resume")),
            content: TreeSummaryStep(),
          ),
        ],
      ),
    );
  }
}
