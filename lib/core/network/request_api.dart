import 'package:mobile1_flutter_coding_test/core/network/response_result.dart';
import 'package:dio/dio.dart';

class RequestApi {
  static const String baseUrl =
      "https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/";
  static Future<ResponseResult<T>> request<T>(String endPoint,
      {required T Function(Map<String, dynamic>) fromJson}) async {
    final dio = Dio();
    final response = await dio.get("$baseUrl$endPoint");
    return ResponseResult(
      code: response.statusCode ?? 0,
      data: fromJson(response.data),
    );
  }
}
