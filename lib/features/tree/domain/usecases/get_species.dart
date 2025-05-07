import 'package:treesense/features/tree/domain/repositories/tree_repository.dart';

class GetSpecies {
  final TreeRepository repository;

  GetSpecies(this.repository);

  Future<List<String>> call() async {
    return await repository.getSpecies();
  }
}
