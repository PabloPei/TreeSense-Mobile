import 'package:treesense/features/tree/domain/entities/tree.dart';

class TreeImpl implements Tree {
  @override
  String specie;

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
    required this.specie,
    required this.height,
    required this.diameter,
    required this.age,
    this.imagePath,
    required this.createdAt,
  });

  static TreeImpl fromJson(Map<String, dynamic> item) {
    return TreeImpl(
      specie: item['specie'] ?? '',
      height: (item['height'] as num).toDouble(),
      diameter: (item['diameter'] as num).toDouble(),
      age: item['age'] ?? 0,
      createdAt: DateTime.parse(
        item['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  void setSpecie(String specie) => this.specie = specie;
  void setHeight(double height) => this.height = height;
  void setDiameter(double diameter) => this.diameter = diameter;
  void setAge(int age) => this.age = age;
  void setImagePath(String? imagePath) => this.imagePath = imagePath;
  void setCreatedAt(DateTime createdAt) => this.createdAt = createdAt;

  TreeImpl copyWith({
    String? specie,
    double? height,
    double? diameter,
    int? age,
    String? imagePath,
    DateTime? createdAt,
  }) {
    return TreeImpl(
      specie: specie ?? this.specie,
      height: height ?? this.height,
      diameter: diameter ?? this.diameter,
      age: age ?? this.age,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
