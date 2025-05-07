import 'package:treesense/features/auth/infrastructure/models/auth_user_impl.dart';
import 'package:treesense/features/auth/domain/entities/auth_user.dart';
import 'package:treesense/features/auth/domain/repositories/auth_repository.dart';
import 'package:treesense/features/auth/infrastructure/datasources/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  Future<AuthUser> login(String email, String password) async {
    final json = await datasource.login(email, password);
    return AuthUserImpl.fromJson(json);
  }
}
