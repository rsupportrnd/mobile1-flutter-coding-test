import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_constants.dart';
import '../utils/logger.dart';

/// HTTP 클라이언트 래퍼 클래스
/// API 통신을 위한 공통 기능을 제공
class HttpClient {
  final http.Client _client;

  HttpClient({http.Client? client}) : _client = client ?? http.Client();

  /// GET 요청
  Future<Map<String, dynamic>> get(String url) async {
    final stopwatch = Logger.startTimer('GET 요청');
    
    try {
      Logger.apiRequest('GET', url);
      final uri = Uri.parse(url);
      final response = await _client.get(uri).timeout(AppConstants.requestTimeout);

      Logger.endTimer(stopwatch, 'GET 요청');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        Logger.apiResponse('GET', url, response.statusCode);
        return jsonResponse;
      } else {
        Logger.apiError('GET', url, response.statusCode, '서버 응답 오류');
        throw HttpException('서버 응답 오류: ${response.statusCode}', response.statusCode);
      }
    } catch (e) {
      Logger.endTimer(stopwatch, 'GET 요청');
      
      if (e.toString().contains('TimeoutException')) {
        Logger.apiError('GET', url, null, '요청 시간 초과', error: e);
        throw HttpException('${AppConstants.networkErrorMessage}: 요청 시간 초과');
      }
      
      if (e is HttpException) {
        rethrow;
      }
      
      Logger.apiError('GET', url, null, 'GET 요청 실패', error: e);
      throw HttpException('${AppConstants.unknownErrorMessage}: $e');
    }
  }

  /// POST 요청
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body) async {
    final stopwatch = Logger.startTimer('POST 요청');
    
    try {
      Logger.apiRequest('POST', url, body: body);
      final uri = Uri.parse(url);
      final response = await _client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      ).timeout(AppConstants.requestTimeout);

      Logger.endTimer(stopwatch, 'POST 요청');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        Logger.apiResponse('POST', url, response.statusCode);
        return jsonResponse;
      } else {
        Logger.apiError('POST', url, response.statusCode, '서버 응답 오류');
        throw HttpException('서버 응답 오류: ${response.statusCode}', response.statusCode);
      }
    } catch (e) {
      Logger.endTimer(stopwatch, 'POST 요청');
      
      if (e.toString().contains('TimeoutException')) {
        Logger.apiError('POST', url, null, '요청 시간 초과', error: e);
        throw HttpException('${AppConstants.networkErrorMessage}: 요청 시간 초과');
      }
      
      if (e is HttpException) {
        rethrow;
      }
      
      Logger.apiError('POST', url, null, 'POST 요청 실패', error: e);
      throw HttpException('${AppConstants.unknownErrorMessage}: $e');
    }
  }

  /// 리소스 정리
  void dispose() {
    _client.close();
  }
}

/// HTTP 예외 클래스
class HttpException implements Exception {
  final String message;
  final int? statusCode;

  HttpException(this.message, [this.statusCode]);

  @override
  String toString() => 'HttpException: $message';
} 