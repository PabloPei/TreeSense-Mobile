import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';
import 'package:treesense/features/auth/domain/usecases/login_user.dart';
import 'package:treesense/features/auth/presentation/state/login_state.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
      final loginUseCase = ref.read(loginUserProvider);
      return LoginController(loginUseCase);
    });

class LoginController extends StateNotifier<LoginState> {
  final LoginUser loginUser;

  LoginController(this.loginUser) : super(LoginState.initial());

  Future<void> login(String email, String password) async {
    if (!state.isFormValid) {
      state = state.copyWith(
        status:
            !state.isEmailValid
                ? LoginStatus.invalidEmail
                : LoginStatus.invalidPassword,
      );
      return;
    }

    state = state.copyWith(
      status: LoginStatus.authenticating,
      result: const AsyncValue.loading(),
    );

    try {
      final user = await loginUser(email, password);
      state = state.copyWith(
        status: LoginStatus.authenticated,
        result: AsyncValue.data(user),
      );
    } catch (e, st) {
      state = state.copyWith(
        status: LoginStatus.failure,
        result: AsyncValue.error(e, st),
      );
    }
  }

  void setEmailValid(bool isValid) {
    state = state.copyWith(isEmailValid: isValid, status: LoginStatus.initial);
  }

  void setEmailErrorMessage(String? message) {
    state = state.copyWith(
      emailErrorMessage: (message == null) ? " " : message,
    );
  }

  void setPasswordErrorMessage(String? message) {
    state = state.copyWith(passErrorMessage: (message == null) ? " " : message);
  }

  void setPasswordValid(bool isValid) {
    state = state.copyWith(
      isPasswordValid: isValid,
      status: LoginStatus.initial,
    );
  }
}
