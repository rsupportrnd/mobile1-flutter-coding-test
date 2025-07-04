import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Log {
  late Logger _logger;

  static Logger to = _instance._logger;
  factory Log() => _instance;
  static final Log _instance = Log._internal();
  Log._internal() {
    // initCode
    _logger = Logger(
        output: ConsoleOutput(),
        printer: PrettyPrinter(
          methodCount: 2, // number of method calls to be displayed
          errorMethodCount:
              8, // number of method calls if stacktrace is provided
          lineLength: 100, // width of the output
          colors: true, // Colorful log messages
          printEmojis: true, // Print an emoji for each log message
          // dateTimeFormat: true // Should each log print contain a timestamp
        ),
        level: kDebugMode ? Level.trace : Level.off);
  }

  static void t(dynamic message) {
    to.t(message);
  }

  static void d(dynamic message) {
    to.d(message);
  }

  static void i(dynamic message) {
    to.i(message);
  }

  static void w(dynamic message) {
    to.w(message);
  }

  static void e(dynamic message) {
    to.e(message);
  }

  static void f(dynamic message) {
    to.f(message);
  }
}
