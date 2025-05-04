abstract class AuthDatasource {
  Future<Map<String, dynamic>> login(String email, String password);
}

class AuthDatasourceImpl implements AuthDatasource {
  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    // Aquí se simula la llamada a la API
    await Future.delayed(Duration(seconds: 1));
    return {'id': '123', 'email': email}; // Simula una respuesta de la API
  }
}
