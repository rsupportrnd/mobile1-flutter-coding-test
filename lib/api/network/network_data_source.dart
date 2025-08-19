import 'dart:convert';
import 'package:dio/dio.dart';

class NetworkDataSource {
  final Dio dio;
  NetworkDataSource(this.dio);

  Future<List<dynamic>> fetchList(String url, {String? rootKey}) async {
    final res =
        await dio.get(url, options: Options(responseType: ResponseType.plain));
    final decoded = jsonDecode(res.data as String);

    if (decoded is List) return decoded;
    if (decoded is Map<String, dynamic>) {
      if (rootKey != null && decoded[rootKey] is List) {
        return List<dynamic>.from(decoded[rootKey] as List);
      }
    }
    throw StateError('Invalid network json shape for $url (rootKey=$rootKey)');
  }
}
