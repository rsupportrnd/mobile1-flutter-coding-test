import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/data/utils/api_config.dart';
import 'package:mobile1_flutter_coding_test/data/utils/http_error_handling_interceptor.dart';
import 'package:mobile1_flutter_coding_test/data/utils/http_interceptor.dart';
import 'dio_client.dart';

class DioClientImpl implements DioClient {
  DioClientImpl();

  @override
  Dio create() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
    ));

    dio.interceptors.add(LoggingInterceptor());
    dio.interceptors.add(ErrorHandlingInterceptor());

    return dio;
  }
}
