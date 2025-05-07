import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:treesense/features/auth/infrastructure/datasources/auth_datasource.dart';
import 'package:treesense/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:treesense/features/auth/domain/repositories/auth_repository.dart';
import 'package:treesense/features/auth/domain/usecases/login_user.dart';

final authDatasourceProvider = Provider<AuthDatasource>((ref) {
  return AuthDatasourceImpl();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final datasource = ref.read(authDatasourceProvider);
  return AuthRepositoryImpl(datasource: datasource);
});

final loginUserProvider = Provider<LoginUser>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return LoginUser(repository: repo);
});
