import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:treesense/config/api_config.dart';

abstract class AuthDatasource {
  Future<Map<String, dynamic>> login(String email, String password);
}

class AuthDatasourceImpl implements AuthDatasource {
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
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to login. Status: ${response.statusCode}');
    }
  }
}
