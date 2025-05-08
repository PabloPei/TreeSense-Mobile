abstract class AuthDatasource {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<void> refreshToken();
}
