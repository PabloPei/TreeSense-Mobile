import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// TODO: Implement that retrieve the language from the user
class MessageLoader {
  static Map<String, String> _messages = {};

  static Future<void> load() async {
    final String jsonString = await rootBundle.loadString(
      'assets/messages/es.json',
    );
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _messages = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  static String get(String key) {
    return _messages[key] ?? '[$key]';
  }
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    MessageLoader.load(),
    Future.delayed(const Duration(seconds: 3)), // TODO: Eliminar en producción
  ]);
}
