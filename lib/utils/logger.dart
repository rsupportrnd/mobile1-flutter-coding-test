import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
}

class Logger {
  static const String _name = 'AppLogger';
  static final DateFormat _timeFormatter = DateFormat('HH:mm:ss.SSS');
  
  static bool _enableLogging = kDebugMode;
  
  static void setLoggingEnabled(bool enabled) {
    _enableLogging = enabled;
  }
  
  
  /// 로그 레벨에 따른 문자열 반환
  static String _getLevelString(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 'DEBUG';
      case LogLevel.info:
        return 'INFO';
      case LogLevel.warning:
        return 'WARNING';
      case LogLevel.error:
        return 'ERROR';
    }
  }
  
  static void _log(LogLevel level, String message, {Object? error, StackTrace? stackTrace}) {
    if (!_enableLogging) return;
    
    final now = DateTime.now();
    final timeString = _timeFormatter.format(now);
    final levelString = _getLevelString(level);
    
    final logMessage = '[$timeString] $levelString: $message';
    
    developer.log(
      logMessage,
      name: _name,
      level: _mapLogLevel(level),
      error: error,
      stackTrace: stackTrace,
    );
    
    if (kDebugMode) {
      print(logMessage);
      if (error != null) {
        print('Error: $error');
      }
      if (stackTrace != null) {
        print('StackTrace: $stackTrace');
      }
    }
  }
  
  static int _mapLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
    }
  }
  
  static void debug(String message) {
    _log(LogLevel.debug, message);
  }
  
  static void info(String message) {
    _log(LogLevel.info, message);
  }
  
  static void warning(String message) {
    _log(LogLevel.warning, message);
  }
  
  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, error: error, stackTrace: stackTrace);
  }
  
  static void apiRequest(String method, String url, {Map<String, dynamic>? body}) {
    info('API 요청 시작: $method $url');
    if (body != null && body.isNotEmpty) {
      debug('요청 데이터: $body');
    }
  }
  
  static void apiResponse(String method, String url, int statusCode, {dynamic responseData}) {
    info('API 응답 성공: $method $url (${statusCode}ms)');
    if (responseData != null) {
      debug('응답 데이터: $responseData');
    }
  }
  
  static void apiError(String method, String url, int? statusCode, String errorMessage, {Object? error}) {
    debug('API 응답 실패: $method $url ${statusCode != null ? '($statusCode)' : ''} - $errorMessage');
  }
  
  static Stopwatch startTimer(String operation) {
    debug('시간 측정 시작: $operation');
    return Stopwatch()..start();
  }
  
  static void endTimer(Stopwatch stopwatch, String operation) {
    stopwatch.stop();
    info('시간 측정 완료: $operation (${stopwatch.elapsedMilliseconds}ms)');
  }
  
  static void userAction(String action, {Map<String, dynamic>? details}) {
    info('사용자 액션: $action');
    if (details != null && details.isNotEmpty) {
      debug('액션 상세: $details');
    }
  }
  
  static void navigation(String from, String to) {
    info('화면 이동: $from → $to');
  }
  
  static void cache(String operation, String key, {bool hit = false}) {
    if (hit) {
      debug('캐시 Hit: $operation - $key');
    } else {
      debug('캐시 처리: $operation - $key');
    }
  }
  
  static void lifecycle(String state) {
    info('앱 라이프사이클: $state');
  }
} 