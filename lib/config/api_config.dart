import 'package:flutter/foundation.dart';

class ApiConfig {
  static final String baseUrl =
      kIsWeb
          ? 'http://localhost:8080/api/v1' // para Web
          : 'http://10.0.2.2:8080/api/v1'; // para Android Emulator
}
