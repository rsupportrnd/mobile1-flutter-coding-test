import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/common/network/custom_exceptions.dart';

class BaseRequest {
  final Dio dio;

  BaseRequest({required this.dio});

  Future<T> call<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw NetworkException(e.message ?? '잠시 후 다시 시도해주세요.', statusCode: e.response?.statusCode);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  dynamic safeConverter(dynamic response) {
    try {
      if (response is String) {
        return jsonDecode(response);
      }
      return response;
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}
