import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:treesense/features/tree/domain/entities/tree.dart';
import 'package:treesense/config/api_config.dart';
import 'package:treesense/features/auth/infrastructure/storage/auth_storage.dart';
import 'package:treesense/features/tree/infrastructure/models/tree_impl.dart';
import 'package:treesense/shared/utils/app_utils.dart';

class TreeDatasource {
  final AuthStorage _authStorage = AuthStorage();

  Future<String> saveTree(Tree data) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/tree');

    final accessToken = await _authStorage.getAccessToken();

    if (accessToken == null) {
      throw Exception(MessageLoader.get('error_access_token'));
    }

    final body = jsonEncode({
      "specie": data.specie,
      "latitude": 20.20,
      "longitude": 20.20,
      "state": 'Healthy',
      "antique": data.age,
      "height": data.height,
      "diameter": data.diameter,
      "photoUrl": 'https://example.com/tree-photo.jpg',
      "description": 'test',
    });

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return MessageLoader.get('tree_saved');
    } else {
      throw Exception(
        "${MessageLoader.get('error_tree_saved')} ${response.statusCode}: ${response.body}",
      );
    }
  }

  Future<List<String>> getSpecies() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/tree/species');

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
      final List<dynamic> jsonList = jsonDecode(response.body);
      final speciesIds =
          jsonList.map((item) => item['treeSpecieId'] as String).toList();

      return speciesIds;
    } else {
      throw Exception(
        "${MessageLoader.get('error_retrieve_species')} ${response.statusCode}: ${response.body}",
      );
    }
  }

  Future<List<Tree>> getUploadedTreeByUser() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/tree');
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
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      final List<dynamic> treeList = responseBody['trees'];

      final trees = treeList.map((item) => TreeImpl.fromJson(item)).toList();

      return trees;
    } else {
      throw Exception(
        "${MessageLoader.get('error_retrieve_species')} ${response.statusCode}: ${response.body}",
      );
    }
  }
}
