import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/shared/utils/app_utils.dart';

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

  @override
  DateTime createdAt;

  TreeImpl({
    required this.species,
    required this.height,
    required this.diameter,
    required this.age,
    this.imagePath,
    required this.createdAt,
  });

  static TreeImpl fromJson(Map<String, dynamic> item) {
    //TODO: chequear robustez ante DateTimes con otro huso horario
    return TreeImpl(
      species: item['species'] ?? '',
      height: (item['height'] as num).toDouble(),
      diameter: (item['diameter'] as num).toDouble(),
      age: item['age'] ?? 0,
      createdAt: parsePreservingLocalTime(
        item['createdAt'] ??
            DateTime.now()
                .toIso8601String(), // Only for visual display – do not use for timezone-aware logic
      ),
    );
  }

  void setSpecies(String species) => this.species = species;
  void setHeight(double height) => this.height = height;
  void setDiameter(double diameter) => this.diameter = diameter;
  void setAge(int age) => this.age = age;
  void setImagePath(String? imagePath) => this.imagePath = imagePath;
  void setCreatedAt(DateTime createdAt) => this.createdAt = createdAt;

  TreeImpl copyWith({
    String? species,
    double? height,
    double? diameter,
    int? age,
    String? imagePath,
    DateTime? createdAt,
  }) {
    return TreeImpl(
      species: species ?? this.species,
      height: height ?? this.height,
      diameter: diameter ?? this.diameter,
      age: age ?? this.age,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
