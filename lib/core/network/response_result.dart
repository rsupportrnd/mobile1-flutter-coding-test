import 'package:mobile1_flutter_coding_test/core/network/response_codes.dart';

class ResponseResult<T> {
  final ResponseCodes code;

  final T? data;

  ResponseResult({required this.code, this.data});
}
