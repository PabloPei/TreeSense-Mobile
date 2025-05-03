import 'package:flutter/material.dart';
import 'package:treesense/shared/utils/app_utils.dart';

class EmailField extends StatefulWidget {
  final TextEditingController controller;

  const EmailField(this.controller, {super.key});

  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  String? _errorText;

  void _validateEmail() {
    final email = widget.controller.text;
    // Regex expression for email limitations. Email must have the shape of something@some-email.some-extension
    const emailPattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
    final regex = RegExp(emailPattern);

    setState(() {
      if (email.isEmpty) {
        _errorText = 'El correo electrónico no puede estar vacío';
      } else if (!regex.hasMatch(email)) {
        _errorText = 'Formato de correo electrónico no válido';
      } else {
        _errorText = null; // No error text if the format is valid
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      //style: const TextStyle(color: Color.fromARGB(255, 14, 33, 65)),
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: MessageLoader.get('username'),
       // hintStyle: const TextStyle(
           // color: Color.fromARGB(255, 82, 82, 82)), // Estilo del hintText
       // fillColor: Colors.blueGrey[50],
        filled: true,
        contentPadding: const EdgeInsets.only(left: 30),
        errorText: _errorText,
        //errorStyle: const TextStyle(color: Color.fromARGB(255, 173, 51, 51)),
        enabledBorder: OutlineInputBorder(
         // borderSide: const BorderSide(color: Color.fromARGB(255, 96, 139, 105)),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
         // borderSide: const BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      //onChanged: (_) => _validateEmail(), SI ES EMAIL, PONERLO PARA QUE VALIDE FORMATO
    );
  }
}

