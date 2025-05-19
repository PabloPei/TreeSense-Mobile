import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:treesense/config/api_config.dart';
import 'package:treesense/features/auth/infrastructure/storage/auth_storage.dart';
import 'package:treesense/features/user/domain/entities/user.dart';
import 'package:treesense/features/user/domain/repositories/user_datasource.dart';
import 'package:treesense/features/user/infrastructure/models/user_impl.dart';
import 'package:treesense/shared/utils/app_utils.dart';

class UserDatasourceImpl implements UserDatasource {
  final AuthStorage _authStorage = AuthStorage();

  @override
  Future<User> getCurrentUser() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/user');
    final accessToken = await _authStorage.getAccessToken();

    if (accessToken == null) {
      throw Exception(MessageLoader.get('error_access_token'));
    }

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      final user = UserImpl.fromJson(responseBody);

      return user;
    } else {
      throw Exception("${response.statusCode}: ${response.body}");
    }
  }
}

//TODO: borrar funcion de prueba
class FakeUserDatasource implements UserDatasource {
  @override
  Future<User> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const UserImpl(
      userName: 'Tomas Ej',
      email: 'tomas@demo.com',
      language: 'ES',
      photo: null,
    );
  }
}
