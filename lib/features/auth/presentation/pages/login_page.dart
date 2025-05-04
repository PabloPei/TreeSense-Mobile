import 'package:flutter/material.dart';
import 'package:treesense/features/auth/presentation/pages/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: LoginForm(),
      ),
    );
  }
}