import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dioClient(Ref ref) {
  final dio = Dio();

  // 기본 설정 TODO 환경 변수로 업데이트 
  dio.options.baseUrl = dotenv.env['API_BASE_URL']!;
  dio.options.connectTimeout = const Duration(seconds: 15);
  dio.options.receiveTimeout = const Duration(seconds: 15);

  // 인터셉터 추가
  dio.interceptors.add(LogInterceptor());

  return dio;
}

