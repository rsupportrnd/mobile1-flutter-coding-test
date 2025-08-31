import 'package:mobile1_flutter_coding_test/communication/response/response_result.dart';
import 'package:dio/dio.dart';

class RequestApi {
  static Future<ResponseResult<T>> request<T>(String url,
      {required T Function(Map<String, dynamic>) fromJson}) async {
    final response = await Dio().get(url);
    return ResponseResult(
      isSuccess: response.statusCode == 200,
      message: response.statusMessage ?? 'Unknown error',
      data: fromJson(response.data),
    );
  }
}
