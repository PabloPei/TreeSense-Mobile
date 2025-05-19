import 'package:flutter/material.dart';
import 'package:treesense/features/auth/presentation/Widgets/login_button.dart';
import 'package:treesense/features/auth/presentation/Widgets/email_field.dart';
import 'package:treesense/features/auth/presentation/Widgets/password_field.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/theme/font_conf.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final bool isLoading;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/logos/home_logo.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 12),
              Text(
                MessageLoader.get('login_description'),
                style: AppTextStyles.captionTextStyle,
              ),
              const SizedBox(height: 12),
              Text(
                MessageLoader.get('login_title'),
                style: AppTextStyles.titleStyle,
              ),
              const SizedBox(height: 40),
              EmailField(emailController),
              const SizedBox(height: 20),
              LoginPassword(passwordController),
              const SizedBox(height: 24),
              LoginButton(onPressed: onLogin, isLoading: isLoading),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
