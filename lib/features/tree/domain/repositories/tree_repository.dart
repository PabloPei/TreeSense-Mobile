import 'package:treesense/features/tree/domain/entities/tree.dart';

abstract class TreeRepository {
  Future<String> saveTree(Tree tree);
  Future<List<String>> getSpecies();
  Future<List<Tree>> getUploadedTreeByUser();
}
