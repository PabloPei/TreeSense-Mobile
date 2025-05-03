import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/shared/utils/app_utils.dart';
import '/core/theme/font_conf.dart';
import './login_controller.dart';
import '/core/theme/app_theme.dart';

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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  MessageLoader.get('username'),
                  style: AppTextStyles.bodyTextStyle,
                ),
              ),
              TextField(
                controller: _emailCtrl,
                decoration: InputDecoration(
                  hintText: MessageLoader.get('username'),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  MessageLoader.get('password'),
                  style: AppTextStyles.bodyTextStyle,
                ),
              ),
              TextField(
                controller: _passwordCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: MessageLoader.get('password'),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primarySeedColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    ref.read(loginControllerProvider.notifier).login(
                          _emailCtrl.text,
                          _passwordCtrl.text,
                        );
                  },
                  child: Text(
                    MessageLoader.get('login_title'),
                    style: AppTextStyles.BottomTextStyle,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              state.when(
                data: (user) => Text('Bienvenido ${user.email}'),
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text('Error: $e'),
              ),
            ],
          ),
        ),
      ),
    );
    
  }
}
