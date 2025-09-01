import 'package:mobile1_flutter_coding_test/data/model/response_result.dart';
import 'package:dio/dio.dart';

class RequestApi {
  static Future<ResponseResult<T>> request<T>(String url,
      {required T Function(Map<String, dynamic>) fromJson}) async {
    final response = await Dio().get(url);
    return ResponseResult(
      code: response.statusCode ?? 0,
      data: fromJson(response.data),
    );
  }
}
