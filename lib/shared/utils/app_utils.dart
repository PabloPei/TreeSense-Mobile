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

/// Use this only for **visual display purposes**.
/// Do NOT use the returned DateTime for time zone-sensitive operations like:
/// - comparisons across time zones
/// - sending data back to the backend
/// - storing time-sensitive records.
DateTime parsePreservingLocalTime(String isoString) {
  final cleaned = isoString.replaceFirst(RegExp(r'(Z|[+-]\d{2}:\d{2})$'), '');
  return DateTime.parse(cleaned);
}
