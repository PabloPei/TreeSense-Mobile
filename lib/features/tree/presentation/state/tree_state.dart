import 'package:treesense/features/tree/infrastructure/models/tree_impl.dart';

enum TreeCensusFormStep { image, data, resume }

class TreeCensusState {
  final TreeCensusFormStep step;
  final TreeImpl? treeData;

  TreeCensusState({this.step = TreeCensusFormStep.image, this.treeData});

  TreeCensusState copyWith({TreeCensusFormStep? step, TreeImpl? treeData}) {
    return TreeCensusState(
      step: step ?? this.step,
      treeData: treeData ?? this.treeData,
    );
  }
}
