import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class LocalDataSource {
  Future<List<dynamic>> loadList(String path, {String? rootKey}) async {
    final raw = await rootBundle.loadString(path);
    final decoded = jsonDecode(raw);

    if (decoded is List) return decoded;
    if (decoded is Map<String, dynamic>) {
      if (rootKey != null && decoded[rootKey] is List) {
        return List<dynamic>.from(decoded[rootKey] as List);
      }
    }
    throw StateError('Invalid local json shape for $path (rootKey=$rootKey)');
  }

  Future<List<dynamic>> loadUsers() =>
      loadList('api/users.json', rootKey: 'users');
  Future<List<dynamic>> loadRooms() =>
      loadList('api/rooms.json', rootKey: 'chatRooms');
  Future<List<dynamic>> loadMessages() =>
      loadList('api/messages.json', rootKey: 'messages');
}
