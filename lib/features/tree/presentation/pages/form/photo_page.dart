import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/features/tree/presentation/state/tree_controller.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/shared/widgets/dialogs/error_messages.dart';
import 'package:treesense/shared/widgets/button_widget.dart';
import 'package:treesense/features/tree/presentation/widgets/census_progress_header.dart';
import 'package:treesense/features/tree/presentation/state/tree_state.dart';

class TreeCensusPhotoPage extends ConsumerWidget {
  const TreeCensusPhotoPage({super.key});

  Future<void> _pickImage(BuildContext context, WidgetRef ref) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      ref
          .read(treeCensusControllerProvider.notifier)
          .updateTreeData(imagePath: pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(treeCensusControllerProvider.notifier);
    final imagePath =
        ref.watch(treeCensusControllerProvider).treeData?.imagePath;

    return Scaffold(
      body: Column(
        children: [
          CensusProgressHeader(
            currentStep: TreeCensusFormStep.photo,
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
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _pickImage(context, ref),
            icon: const Icon(Icons.camera_alt),
            label: Text(MessageLoader.get("save_tree_form_image")),
            style: ElevatedButton.styleFrom(
              backgroundColor: primarySeedColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (imagePath != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(
                File(imagePath),
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          const Spacer(),
          ButtonWidget(
            text: MessageLoader.get('save_tree_form_continue'),
            color: primarySeedColor,
            onPressed: () {
              final isValid = true;
              //final isValid = controller.validatePhoto();
              if (isValid) {
                context.push('/tree-census/observations');
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
    );
  }
}
