import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/features/tree/domain/usecases/save_tree.dart';

class TreeCensusState {
  final int step;
  final Tree? treeData;
  final File? image;
  final bool isLoading;
  final String species;
  final double height;
  final double diameter;
  final int age;

  TreeCensusState({
    this.step = 0,
    this.treeData,
    this.image,
    this.isLoading = false,
    this.species = '', // Valor predeterminado de cadena vacía si no se pasa
    this.height = 0.0, // Valor predeterminado 0.0 si no se pasa
    this.diameter = 0.0, // Valor predeterminado 0.0 si no se pasa
    this.age = 0, // Valor predeterminado 0 si no se pasa
  });

  TreeCensusState copyWith({
    int? step,
    Tree? treeData,
    File? image,
    bool? isLoading,
    String? species,
    double? height,
    double? diameter,
    int? age,
  }) {
    return TreeCensusState(
      step: step ?? this.step,
      treeData: treeData ?? this.treeData,
      image: image ?? this.image,
      isLoading: isLoading ?? this.isLoading,
      species: species ?? this.species,
      height: height ?? this.height,
      diameter: diameter ?? this.diameter,
      age: age ?? this.age,
    );
  }
}

class TreeCensusController extends StateNotifier<TreeCensusState> {
  final SaveTree saveTreeData;

  TreeCensusController(this.saveTreeData) : super(TreeCensusState());

  String get getSpecies => state.species; // No puede ser nulo
  File? get getImage => state.image;
  double get getHeight => state.height; // No puede ser nulo
  double get getDiameter => state.diameter; // No puede ser nulo
  int get getAge => state.age; // No puede ser nulo

  void nextStep() {
    if (state.step < 2) {
      state = state.copyWith(step: state.step + 1);
    }
  }

  void previousStep() {
    if (state.step > 0) {
      state = state.copyWith(step: state.step - 1);
    }
  }

  void setImage(File image) {
    state = state.copyWith(image: image);
  }

  void setTreeData(Tree data) {
    state = state.copyWith(treeData: data);
  }

  // Setters para los campos del formulario
  void setSpecies(String species) {
    state = state.copyWith(species: species);
  }

  void setHeight(double height) {
    state = state.copyWith(height: height);
  }

  void setDiameter(double diameter) {
    state = state.copyWith(diameter: diameter);
  }

  void setAge(int age) {
    state = state.copyWith(age: age);
  }

  Future<String> saveTree() async {
    if (state.treeData == null) return 'No tree data available';

    state = state.copyWith(isLoading: true);
    try {
      final responseMessage = await saveTreeData(state.treeData!); // Llamamos al use case
      state = state.copyWith(isLoading: false);

      return responseMessage; // Aquí podrías actualizar el estado con el mensaje o pasarlo a la UI
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return 'Error al guardar árbol: ${e.toString()}';
    }
  }
}
