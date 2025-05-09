import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/features/tree/domain/usecases/save_tree.dart';
import 'package:treesense/features/tree/presentation/state/tree_provider.dart';
import 'package:treesense/features/tree/infrastructure/models/tree_impl.dart';
import 'package:treesense/features/tree/presentation/state/tree_state.dart';

final treeCensusControllerProvider =
    StateNotifierProvider.autoDispose<TreeCensusController, TreeCensusState>((
      ref,
    ) {
      final saveTreeUseCase = ref.read(saveTreeUseCaseProvider);
      return TreeCensusController(saveTreeUseCase);
    });

final treeSpeciesProvider = AutoDisposeFutureProvider<List<String>>((
  ref,
) async {
  final getSpeciesUseCase = ref.read(getSpeciesUseCaseProvider);
  return await getSpeciesUseCase();
});

final treeUploadedByUser = AutoDisposeFutureProvider<List<Tree>>((ref) async {
  final getUploadedTreeByUserUseCase = ref.read(getTreesUploadedByUser);
  return await getUploadedTreeByUserUseCase();
});

class TreeCensusController extends StateNotifier<TreeCensusState> {
  final SaveTree saveTreeData;

  TreeCensusController(this.saveTreeData) : super(TreeCensusState());

  void nextStep() {
    final nextIndex = TreeCensusFormStep.values.indexOf(state.step) + 1;
    if (nextIndex < TreeCensusFormStep.values.length) {
      state = state.copyWith(step: TreeCensusFormStep.values[nextIndex]);
    }
  }

  void previousStep() {
    final prevIndex = TreeCensusFormStep.values.indexOf(state.step) - 1;
    if (prevIndex >= 0) {
      state = state.copyWith(step: TreeCensusFormStep.values[prevIndex]);
    }
  }

  void setTreeData(TreeImpl data) {
    state = state.copyWith(treeData: data);
  }

  void setStep(TreeCensusFormStep step) {
    state = state.copyWith(step: step);
  }

  void updateTreeData({
    String? specie,
    double? height,
    double? diameter,
    int? age,
    String? imagePath,
    DateTime? createdAt,
  }) {
    final current = state.treeData;
    if (current != null) {
      if (specie != null) current.setSpecie(specie);
      if (height != null) current.setHeight(height);
      if (diameter != null) current.setDiameter(diameter);
      if (age != null) current.setAge(age);
      if (imagePath != null) current.setImagePath(imagePath);
      if (createdAt != null) current.setCreatedAt(createdAt);
      state = state.copyWith(treeData: current);
    } else {
      final newTree = TreeImpl(
        specie: specie ?? '',
        height: height ?? 0.0,
        diameter: diameter ?? 0.0,
        age: age ?? 0,
        imagePath: imagePath,
        createdAt: createdAt ?? DateTime.now(),
      );
      state = state.copyWith(treeData: newTree);
    }
  }

  Future<String> saveTree() async {
    try {
      final responseMessage = await saveTreeData(state.treeData!);
      return responseMessage;
    } catch (e) {
      return e.toString();
    }
  }
}
