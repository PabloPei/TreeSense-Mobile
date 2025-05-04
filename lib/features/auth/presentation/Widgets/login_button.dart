import 'package:flutter/material.dart';
import 'package:treesense/features/tree/presentation/pages/tree_form.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/core/theme/app_theme.dart';

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
            SnackBar(
              content: Text(MessageLoader.get('error_empty_email_password')),
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
        backgroundColor: primarySeedColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(MessageLoader.get('login_button'), style: AppTextStyles.BottomTextStyle, ),
    );
  }
}
