import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/auth/presentation/Widgets/Login_button.dart';
import 'package:treesense/features/auth/presentation/Widgets/email_field.dart';
import 'package:treesense/features/auth/presentation/Widgets/password_field.dart';
import 'package:treesense/features/auth/presentation/state/auth_controller.dart';
import 'package:treesense/shared/utils/app_utils.dart';
import 'package:treesense/core/theme/font_conf.dart';
import 'package:treesense/core/theme/app_theme.dart';


class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(loginControllerProvider);

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '<  Back',
                  style: TextStyle(fontSize: 16),
                ),
              ),
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
              EmailField(_emailCtrl),
              const SizedBox(height: 20),
              LoginPassword(_passwordCtrl),
              const SizedBox(height: 24),
              LoginButton(emailController: _emailCtrl, passwordController: _passwordCtrl),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
    
  }
}
