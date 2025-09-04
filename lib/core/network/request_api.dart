import 'dart:convert';

import 'package:mobile1_flutter_coding_test/core/network/response_codes.dart';
import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/core/network/response_result.dart';

class RequestApi {
  static const baseUrl =
      "https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/";
  static Future<ResponseResult<T>> request<T>(String endpoint,
      {required T? Function(Map<String, dynamic>) fromJson}) async {
    try {
      final response = await Dio().get("$baseUrl$endpoint");

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.data);
        return ResponseResult(
          code: ResponseCodes.success,
          data: fromJson(json),
        );
      }
      return ResponseResult(
          code: ResponseCodes.fromCode(response.statusCode.toString()));
    } catch (e) {
      return ResponseResult(
        code: ResponseCodes.unkownError,
      );
    }
  }
}
