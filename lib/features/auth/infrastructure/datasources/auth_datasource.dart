import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:treesense/config/api_config.dart';
import 'package:treesense/features/auth/infrastructure/storage/auth_storage.dart'; 

abstract class AuthDatasource {
  Future<Map<String, dynamic>> login(String email, String password);
}

class AuthDatasourceImpl implements AuthDatasource {
  final AuthStorage _authStorage = AuthStorage();

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/user/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

      final accessToken = responseBody['accessToken'] as String?;
      final refreshToken = responseBody['refreshToken'] as String?;

      if (accessToken != null && refreshToken != null) {
        await _authStorage.saveTokens(accessToken, refreshToken);
      } else {
        throw Exception('Token de acceso o de refresco no disponible en la respuesta.');
      }

      return responseBody;
    } else {
      throw Exception('Failed to login. Status: ${response.statusCode}');
    }
  }
}
