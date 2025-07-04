import 'package:dio/dio.dart';

abstract class DioClient {
  Dio create();
}
