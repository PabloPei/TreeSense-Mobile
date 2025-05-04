import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/config/api_config.dart';
import 'package:treesense/features/auth/infrastructure/storage/auth_storage.dart';

class TreeDatasource {
  final AuthStorage _authStorage = AuthStorage(); 

  Future<String> saveTree(Tree data) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/tree');

    // Obtener el token de acceso
    final accessToken = await _authStorage.getAccessToken();

    if (accessToken == null) {
      throw Exception('Token de acceso no disponible.');
    }

    // Crear el cuerpo de la solicitud
    final body = jsonEncode({
      "specie": data.species,
      "latitude": 20.20,
      "longitude": 20.20,
      "state": 'Healthy',
      "antique": data.age,
      "height": data.height,
      "diameter": data.diameter,
      "photoUrl": 'https://example.com/tree-photo.jpg',
      "description": 'test',
    });

    // Hacer la solicitud HTTP con el token de acceso en el encabezado Authorization
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken', // Agregar el token en el encabezado
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return 'Árbol guardado correctamente';
    } else {
      throw Exception('Fallo al guardar árbol. ${response.statusCode}: ${response.body}');
    }
  }
}
