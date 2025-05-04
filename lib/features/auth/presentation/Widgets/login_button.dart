import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/tree/presentation/pages/tree_form.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/core/theme/app_theme.dart';
import 'package:treesense/features/auth/presentation/state/auth_controller.dart';

class LoginButton extends ConsumerWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginControllerProvider);
    final loginController = ref.read(loginControllerProvider.notifier);

    return ElevatedButton(
      onPressed: loginState is AsyncLoading
          ? null // Desactiva el botón cuando esté en carga
          : () async {
              final email = emailController.text.trim();
              final password = passwordController.text;

              if (email.isEmpty || password.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(MessageLoader.get('error_empty_email_password')),
                  ),
                );
                return;
              }

              await loginController.login(email, password);

              final result = ref.read(loginControllerProvider);

              if (result.hasError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Login failed: ${result.error}'),
                  ),
                );
              } else if (result.hasValue) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TreeCensusForm(),
                  ),
                );
              }
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: primarySeedColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: loginState is AsyncLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
              MessageLoader.get('login_button'),
              style: AppTextStyles.BottomTextStyle,
            ),
    );
  }
}
