import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';
import 'package:treesense/features/auth/domain/entities/auth_user.dart';
import 'package:treesense/features/auth/domain/usecases/login_user.dart';


final loginControllerProvider = StateNotifierProvider<LoginController, AsyncValue<AuthUser>>((ref) {
  final loginUseCase = ref.read(loginUserProvider);
  return LoginController(loginUseCase);
});

class LoginController extends StateNotifier<AsyncValue<AuthUser>> {
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
