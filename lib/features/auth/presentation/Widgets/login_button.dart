// ignore_for_file: unused_local_variable
//import 'package:tpp/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:treesense/features/auth/presentation/tree_form.dart';


class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final email = emailController.text;
        final password = passwordController.text;

        if (email.isEmpty || password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("El correo y la contraseña son obligatorios"),
            ),
          );
          return;
        }

                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TreeCensusForm()
                  ),
                );
              
      },
      style: ElevatedButton.styleFrom(
     
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: const Text("Iniciar sesión", style: TextStyle(fontWeight: FontWeight.bold ),),
    );
  }
}
