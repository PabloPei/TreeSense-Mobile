import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/auth/infrastructure/auth_repository_impl.dart';
import '/features/auth/domain/auth_repository.dart';
import '/features/auth/domain/user.dart';


final loginUserProvider = Provider<LoginUser>((ref) {
  final repo = AuthRepositoryImpl();
  return LoginUser(repo);
});


class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<User> call(String email, String password) {
    return repository.login(email, password);
  }
}
