import 'dart:async';

import 'package:mobile1_flutter_coding_test/data/utils/retry_when.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/my_error.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';

/// Error Handling Method
/// 정상동작 시 returnType: Result.success
/// 에러 시 returnType: Result.failure
Future<Result<T>> safeCall<T>(Future<T> Function() apiCall) async {
  try {
    final data = await (() => apiCall()).retryWhen(
      predicate: (error, retryCount, delay) {
        return Future.value(retryCount < 3); // 3번까지만 재시도
      },
    );
    return Result.success(data);
  } on NetworkException catch (e) {
    return Result.failure(MyError(
      type: ErrorType.network,
      message: e.message,
    ));
  } on UnauthorizedException catch (e) {
    return Result.failure(MyError(
      type: ErrorType.unauthorized,
      message: e.message,
    ));
  } on ServerException catch (e) {
    return Result.failure(MyError(
      type: ErrorType.server,
      message: e.message,
    ));
  } catch (e) {
    return Result.failure(MyError(
      type: ErrorType.unknown,
      message: '예기치 못한 오류: ${e.toString()}',
    ));
  }
}
