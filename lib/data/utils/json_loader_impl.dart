import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobile1_flutter_coding_test/data/utils/json_loader.dart';

class JsonLoader implements IJsonLoader {
  @override
  Future<Map<String, dynamic>> loadJson(String path) async {
    final jsonStr = await rootBundle.loadString(path);
    return jsonDecode(jsonStr);
  }

  @override
  Future<List<dynamic>> loadJsonList(String path) async {
    final jsonStr = await rootBundle.loadString(path);
    return jsonDecode(jsonStr) as List<dynamic>;
  }
}
