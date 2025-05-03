import 'package:flutter/material.dart';
import 'package:treesense/shared/utils/app_utils.dart';

class LoginPassword extends StatefulWidget {
  final TextEditingController controller;

  const LoginPassword(this.controller, {super.key});

  @override
  _LoginPasswordState createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<LoginPassword> {
  bool _obscureText = true;
  late IconData _icon;

  @override
  void initState() {
    super.initState();
    _icon = Icons.visibility_off_outlined;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
      _icon = _obscureText
          ? Icons.visibility_off_outlined
          : Icons.visibility_outlined;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelText: MessageLoader.get('password'),
            suffixIcon: GestureDetector(
              onLongPress: _toggleVisibility,
              onLongPressUp: _toggleVisibility,
              child: Icon(_icon),
            ),
            fillColor: Colors.blueGrey[50],
            filled: true,
            contentPadding: const EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(height: 8),
        
      ],
    );
  }
}
