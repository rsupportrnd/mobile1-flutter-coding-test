import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/app_user.dart';

class UserRepository {
  UserRepository(this._dio);

  final Dio _dio;
}
