import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/auth/application/auth_service.dart';
import '/features/auth/domain/user.dart';

final loginControllerProvider = StateNotifierProvider<LoginController, AsyncValue<User>>((ref) {
  final loginUseCase = ref.read(loginUserProvider);
  return LoginController(loginUseCase);
});

class LoginController extends StateNotifier<AsyncValue<User>> {
  final LoginUser loginUser;

  LoginController(this.loginUser) : super(const AsyncValue.loading());

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await loginUser(email, password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
