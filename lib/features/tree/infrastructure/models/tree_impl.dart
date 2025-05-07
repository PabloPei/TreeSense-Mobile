import 'package:treesense/features/tree/domain/entities/tree.dart';

class TreeImpl implements Tree {
  @override
  String species;

  @override
  double height;

  @override
  double diameter;

  @override
  int age;

  @override
  String? imagePath;

  TreeImpl({
    required this.species,
    required this.height,
    required this.diameter,
    required this.age,
    this.imagePath,
  });

  void setSpecies(String species) {
    this.species = species;
  }

  void setHeight(double height) {
    this.height = height;
  }

  void setDiameter(double diameter) {
    this.diameter = diameter;
  }

  void setAge(int age) {
    this.age = age;
  }

  void setImagePath(String? imagePath) {
    this.imagePath = imagePath;
  }

  TreeImpl copyWith({
    String? species,
    double? height,
    double? diameter,
    int? age,
    String? imagePath,
  }) {
    return TreeImpl(
      species: species ?? this.species,
      height: height ?? this.height,
      diameter: diameter ?? this.diameter,
      age: age ?? this.age,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
