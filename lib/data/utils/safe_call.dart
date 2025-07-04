import 'dart:async';

import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/my_error.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';

/// Error Handling Method
/// 정상동작 시 returnType: Result.success
/// 에러 시 returnType: Result.failure
Future<Result<T>> safeCall<T>(Future<T> Function() apiCall) async {
  try {
    final data = await apiCall();
    return Result.success(data);
  } on JsonLoadException catch (e) {
    return Result.failure(MyError(
      type: ErrorType.jsonLoad,
      message: e.message,
    ));
  } catch (e) {
    return Result.failure(MyError(
      type: ErrorType.unknown,
      message: '예기치 못한 오류: ${e.toString()}',
    ));
  }
}
