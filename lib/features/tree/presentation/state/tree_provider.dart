// providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/infrastructure/datasources/tree_datasource.dart'; 
import 'package:treesense/features/tree/domain/repositories/tree_repository.dart'; 
import 'package:treesense/features/tree/infrastructure/repositories/tree_repository_impl.dart'; 
import 'package:treesense/features/tree/domain/usecases/save_tree.dart'; 
import 'package:treesense/features/tree/presentation/state/tree_controller.dart';

// El provider para el datasource
final treeDatasourceProvider = Provider<TreeDatasource>((ref) {
  return TreeDatasource();
});

// El provider para el repositorio que usa el datasource
final treeRepositoryProvider = Provider<TreeRepository>((ref) {
  final datasource = ref.read(treeDatasourceProvider);
  return TreeRepositoryImpl(datasource);
});

// El provider para el caso de uso SaveTree, que depende del repositorio
final saveTreeUseCaseProvider = Provider<SaveTree>((ref) {
  final repository = ref.read(treeRepositoryProvider);
  return SaveTree(repository);  // Usa la implementación del repositorio
});

// El provider para el controlador de censo de árboles
final treeCensusControllerProvider = StateNotifierProvider<TreeCensusController, TreeCensusState>((ref) {
  final saveTree = ref.read(saveTreeUseCaseProvider);
  return TreeCensusController(saveTree);
});
