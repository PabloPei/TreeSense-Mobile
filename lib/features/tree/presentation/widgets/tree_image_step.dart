import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/presentation/state/tree_controller.dart';
import 'package:treesense/shared/utils/app_utils.dart' show MessageLoader;

class TreeImageStep extends ConsumerWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context, WidgetRef ref) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // Usamos el método updateTreeData para actualizar la imagen
      ref
          .read(treeCensusControllerProvider.notifier)
          .updateTreeData(imagePath: pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Image.asset('assets/images/Censo.png', height: 200, fit: BoxFit.cover),
        SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () => _pickImage(context, ref),
          icon: Icon(Icons.camera_alt),
          label: Text(MessageLoader.get("save_tree_form_image")),
        ),
        // Mostramos la imagen seleccionada si está disponible
        ref.watch(treeCensusControllerProvider).treeData?.imagePath != null
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.file(
                File(
                  ref.watch(treeCensusControllerProvider).treeData!.imagePath!,
                ),
              ),
            )
            : Container(),
      ],
    );
  }
}
