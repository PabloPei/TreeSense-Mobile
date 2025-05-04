import 'package:treesense/features/tree/domain/entities/tree.dart';

class TreeImpl implements Tree {
  @override
  final String species;
  
  @override
  final double height;
  
  @override
  final double diameter;
  
  @override
  final int age;
  
  @override
  String? imagePath;

  TreeImpl({
    required this.species,
    required this.height,
    required this.diameter,
    required this.age,
    this.imagePath,
  });

  @override
  String toString() {
    return 'Tree(species: $species, height: $height, diameter: $diameter, age: $age, imagePath: $imagePath)';
  }
}
