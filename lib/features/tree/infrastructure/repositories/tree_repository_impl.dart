// tree_repository_impl.dart (Implementación)
import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/features/tree/domain/repositories/tree_repository.dart';
import 'package:treesense/features/tree/infrastructure/datasources/tree_datasource.dart';

class TreeRepositoryImpl implements TreeRepository {
  final TreeDatasource datasource;

  TreeRepositoryImpl(this.datasource);

  @override
  Future<String> saveTree(Tree tree) async {
    return await datasource.saveTree(tree);
  }

  @override
  Future<List<String>> getSpecies() async {
    return await datasource.getSpecies();
  }
}
