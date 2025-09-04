import 'package:mobile1_flutter_coding_test/core/network/response_codes.dart';
import 'package:mobile1_flutter_coding_test/data/model/response_result.dart';
import 'package:dio/dio.dart';

class RequestApi {
  static Future<ResponseResult<T>> request<T>(String url,
      {required T? Function(Map<String, dynamic>) fromJson}) async {
    try {
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        return ResponseResult(
          code: ResponseCodes.success,
          data: fromJson(response.data),
        );
      }
      return ResponseResult(
          code: ResponseCodes.fromCode(response.statusCode.toString()));
    } catch (e) {
      return ResponseResult(
        code: ResponseCodes.unkownError,
      );
    }
  }
}
