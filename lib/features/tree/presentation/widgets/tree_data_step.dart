import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/presentation/state/tree_controller.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/shared/widgets/error_messages.dart';

class TreeDataStep extends ConsumerWidget {
  final GlobalKey<FormState> formKey;

  TreeDataStep({required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speciesAsync = ref.watch(treeSpeciesProvider);
    final selectedSpecies =
        ref.watch(treeCensusControllerProvider).treeData?.specie;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          speciesAsync.when(
            data: (speciesList) {
              return DropdownButtonFormField<String>(
                value:
                    speciesList.contains(selectedSpecies)
                        ? selectedSpecies
                        : null,
                decoration: InputDecoration(
                  labelText: MessageLoader.get("save_tree_form_species"),
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
                    ref
                        .read(treeCensusControllerProvider.notifier)
                        .updateTreeData(specie: value);
                  }
                },
                validator:
                    (value) => value == null ? 'Seleccione una especie' : null,
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) {
              return WarningMessage(
                title: MessageLoader.get('error_retrieve_species'),
                message: error.toString(),
              );
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: MessageLoader.get("save_tree_form_height"),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              ref
                  .read(treeCensusControllerProvider.notifier)
                  .updateTreeData(height: double.tryParse(value) ?? 0.0);
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: MessageLoader.get("save_tree_form_diameter"),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              ref
                  .read(treeCensusControllerProvider.notifier)
                  .updateTreeData(diameter: double.tryParse(value) ?? 0.0);
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: MessageLoader.get("save_tree_form_age"),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              ref
                  .read(treeCensusControllerProvider.notifier)
                  .updateTreeData(age: int.tryParse(value) ?? 0);
            },
          ),
        ],
      ),
    );
  }
}
