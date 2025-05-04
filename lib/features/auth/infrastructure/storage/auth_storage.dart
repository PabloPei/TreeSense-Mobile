import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Guardar el accessToken y refreshToken
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  // Obtener el accessToken
  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  // Obtener el refreshToken
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refreshToken');
  }

  // Eliminar los tokens (por ejemplo, en el logout)
  Future<void> clearTokens() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
  }
}
