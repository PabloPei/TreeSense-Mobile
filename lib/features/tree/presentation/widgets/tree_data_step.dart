import 'package:flutter/material.dart';
import 'package:treesense/features/tree/presentation/state/tree_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class TreeDataStep extends ConsumerWidget {
  final GlobalKey<FormState> formKey;

  TreeDataStep({required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Especie'),
            onSaved: (value) =>
                ref.read(treeCensusControllerProvider.notifier).setSpecies(value!),
            validator: (value) => value?.isEmpty ?? true ? 'Requerido' : null,
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(labelText: 'Altura Estimada (m)'),
            keyboardType: TextInputType.number,
            onSaved: (value) => ref
                .read(treeCensusControllerProvider.notifier)
                .setHeight(double.tryParse(value ?? '') ?? 0.0),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(labelText: 'Diámetro Estimado (m)'),
            keyboardType: TextInputType.number,
            onSaved: (value) => ref
                .read(treeCensusControllerProvider.notifier)
                .setDiameter(double.tryParse(value ?? '')?? 0.0),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(labelText: 'Edad Estimada (años)'),
            keyboardType: TextInputType.number,
            onSaved: (value) => ref
                .read(treeCensusControllerProvider.notifier)
                .setAge(int.tryParse(value ?? '') ?? 0),
          ),
        ],
      ),
    );
  }
}
