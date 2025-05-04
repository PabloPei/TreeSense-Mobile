import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/presentation/state/tree_provider.dart';

class TreeSummaryStep extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(treeCensusControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Especie: ${state.species ?? '-'}'),
        SizedBox(height: 10),
        Text('Altura: ${state.height?.toStringAsFixed(2) ?? '-'} m'),
        SizedBox(height: 10),
        Text('Diámetro: ${state.diameter?.toStringAsFixed(2) ?? '-'} m'),
        SizedBox(height: 10),
        Text('Edad: ${state.age ?? '-'} años'),
        SizedBox(height: 10),
        state.image != null
            ? Image.file(state.image!, height: 100)
            : Text('No se cargó imagen'),
      ],
    );
  }
}

