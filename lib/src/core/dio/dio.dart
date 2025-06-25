import 'dart:async';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/exception/custom_exception.dart';
import 'package:mobile1_flutter_coding_test/src/core/util/logger_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio.g.dart';

@riverpod
Dio dio(Ref ref) {
  final Dio dio = Dio();
  dio.interceptors.add(
    CustomInterceptor(dio: dio),
  );
  return dio;
}

class CustomInterceptor extends Interceptor {
  final Dio dio;

  CustomInterceptor({required this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    logger.d('[REQUEST] ${options.method}] ${options.uri}, ${options.data}');

    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    logger.d(
        '[RESPONSE] ${response.requestOptions.method}] ${response.requestOptions.uri}, ${response.data}');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    logger.e('[ERROR] ${err.requestOptions.method}] ${err.requestOptions.uri} \n'
        '[response] : ${err.response} '
        '[StatusCode]:${err.response?.statusCode}, ${err.message}, ${err.type}');
    final int? statusCode = err.response?.statusCode;
    final RequestOptions options = err.requestOptions;

    late final DioException dioError;

    switch (statusCode) {
      case 401:
        dioError = DioException(
          requestOptions: options,
          response: err.response,
          type: DioExceptionType.badResponse,
          error: const UnauthorizedException(),
        );
        break;
      case 403:
        dioError = DioException(
          requestOptions: options,
          response: err.response,
          type: DioExceptionType.badResponse,
          error: const ForbiddenException(),
        );
        break;
      case 404:
        dioError = DioException(
          requestOptions: options,
          response: err.response,
          type: DioExceptionType.badResponse,
          error: const NotFoundException(),
        );
        break;
      case 500:
        dioError = DioException(
          requestOptions: options,
          response: err.response,
          type: DioExceptionType.badResponse,
          error: const ServerException(),
        );
        break;
      default:
        dioError = DioException(
          requestOptions: options,
          response: err.response,
          type: DioExceptionType.unknown,
          error: const UnknownException(),
        );
        break;
    }

    handler.reject(dioError);
  }
}
