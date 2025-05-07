import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/domain/usecases/get_species.dart';
import 'package:treesense/features/tree/infrastructure/datasources/tree_datasource.dart';
import 'package:treesense/features/tree/domain/repositories/tree_repository.dart';
import 'package:treesense/features/tree/infrastructure/repositories/tree_repository_impl.dart';
import 'package:treesense/features/tree/domain/usecases/save_tree.dart';

final treeDatasourceProvider = Provider<TreeDatasource>((ref) {
  return TreeDatasource();
});

final treeRepositoryProvider = Provider<TreeRepository>((ref) {
  final datasource = ref.read(treeDatasourceProvider);
  return TreeRepositoryImpl(datasource);
});

final saveTreeUseCaseProvider = Provider<SaveTree>((ref) {
  final repository = ref.read(treeRepositoryProvider);
  return SaveTree(repository);
});

final getSpeciesUseCaseProvider = Provider<GetSpecies>((ref) {
  final repository = ref.read(treeRepositoryProvider);
  return GetSpecies(repository);
});
