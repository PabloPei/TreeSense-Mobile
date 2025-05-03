import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:treesense/core/theme/app_theme.dart';


class TreeCensusForm extends StatefulWidget {
  @override
  _TreeCensusFormState createState() => _TreeCensusFormState();
}

class _TreeCensusFormState extends State<TreeCensusForm> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  String? _species;
  double? _height;
  double? _diameter;
  int? _age;
  File? _imageFile;

  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _continue() {
    if (_currentStep == 0 && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _currentStep += 1);
    } else if (_currentStep < 2) {
      setState(() => _currentStep += 1);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Carga Finalizada'),
          content: Text('Datos guardados correctamente.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _cancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carga de Datos')),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepTapped: (step) => setState(() => _currentStep = step),
        onStepContinue: _continue,
        onStepCancel: _cancel,
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Container(
            margin: EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      _currentStep == 2 ? 'FINALIZAR' : 'SIGUIENTE',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text('ATRÁS', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          );
        },

        steps: [
          Step(
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            title: Text('Datos'),
            isActive: _currentStep >= 0,
            content: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Especie',
                      contentPadding: const EdgeInsets.only(left: 30),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onSaved: (value) => _species = value,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Requerido' : null,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Altura Estimada (m)',
                      contentPadding: const EdgeInsets.only(left: 30),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _height = double.tryParse(value!),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Diámetro Estimado (m)',
                      contentPadding: const EdgeInsets.only(left: 30),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _diameter = double.tryParse(value!),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Edad Estimada (años)',
                      contentPadding: const EdgeInsets.only(left: 30),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _age = int.tryParse(value!),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Step(
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            title: Text('Imagen'),
            isActive: _currentStep >= 1,
            content: Column(
              children: [
                Image.asset(
                  'assets/images/Censo.png',
                  height: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.camera_alt),
                  label: Text('Subir foto'),
                ),
                if (_imageFile != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(_imageFile!),
                  ),
              ],
            ),
          ),
          Step(
            state: StepState.indexed,
            title: Text('Resumen'),
            isActive: _currentStep >= 2,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Especie: $_species'),
                SizedBox(height: 10),
                Text('Altura: ${_height ?? '-'} m'),
                SizedBox(height: 10),
                Text('Diámetro: ${_diameter ?? '-'} m'),
                SizedBox(height: 10),
                Text('Edad: ${_age ?? '-'} años'),
                SizedBox(height: 10),
                _imageFile != null
                    ? Image.file(_imageFile!, height: 100)
                    : Text('No se cargó imagen'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
