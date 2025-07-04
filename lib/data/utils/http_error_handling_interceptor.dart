import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';

class ErrorHandlingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    late final DioException customError;
    if (statusCode == 401) {
      customError = err.copyWith(error: const UnauthorizedException());
    } else if (statusCode == 500) {
      customError = err.copyWith(error: const ServerException());
    } else if (statusCode == null) {
      customError = err.copyWith(error: const NetworkException());
    } else {
      customError = err.copyWith(error: UnKnownException(err.message));
    }

    return handler.reject(customError); // 에러를 그대로 전달
  }
}
