import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/data/utils/http_error_handling_interceptor.dart';
import 'package:mobile1_flutter_coding_test/data/utils/http_interceptor.dart';
import 'dio_client.dart';

class DioClientImpl implements DioClient {
  DioClientImpl();

  @override
  Dio create() {
    final dio = Dio(BaseOptions(
      baseUrl:
          "https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api",
    ));

    dio.interceptors.add(ErrorHandlingInterceptor());
    dio.interceptors.add(LoggingInterceptor());

    return dio;
  }
}
