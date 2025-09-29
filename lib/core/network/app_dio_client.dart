import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dioClient(Ref ref) {
  final dio = Dio();

  // 환경변수에서 API_BASE_URL 가져오기 (fallback URL 포함)
  final baseUrl = dotenv.env['API_BASE_URL'] ??
      'https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api';

  dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = const Duration(seconds: 15);
  dio.options.receiveTimeout = const Duration(seconds: 15);

  // 환경변수에 따른 로깅 설정
  final debugMode = dotenv.env['DEBUG_MODE'] == 'true';
  if (debugMode) {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
    ));
  }

  return dio;
}

