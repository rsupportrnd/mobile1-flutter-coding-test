// import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:mobile1_flutter_coding_test/data/utils/json_loader.dart';
// import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';

// class JsonLoader implements IJsonLoader {
//   @override
//   Future<Map<String, dynamic>> loadJson(String path) async {
//     try {
//       final jsonStr = await rootBundle.loadString(path);
//       final decoded = jsonDecode(jsonStr);
//       if (decoded is Map<String, dynamic>) {
//         return decoded;
//       } else {
//         throw const FormatException('JSON is not a valid Map');
//       }
//     } catch (e) {
//       throw JsonLoadException('loadJson 실패: $path\n원인: $e');
//     }
//   }

//   @override
//   Future<List<dynamic>> loadJsonList(String path) async {
//     try {
//       final jsonStr = await rootBundle.loadString(path);
//       final decoded = jsonDecode(jsonStr);
//       if (decoded is List) {
//         return decoded;
//       } else {
//         throw const FormatException('JSON is not a valid List');
//       }
//     } catch (e) {
//       throw JsonLoadException('loadJsonList 실패: $path\n원인: $e');
//     }
//   }
// }
