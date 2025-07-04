import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Log.d('--> [${options.method}] ${options.uri}');
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.d('<-- [${response.statusCode}] ${response.requestOptions.uri}');

    try {
      final jsonData = jsonDecode(response.data);
      response.data = jsonData;
    } catch (e) {
      throw const FormatException('JSON is not a valid Map');
    }
    handler.next(response);
  }
}
