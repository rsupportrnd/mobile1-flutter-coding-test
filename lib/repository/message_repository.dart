import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chat_message.dart';

class MessageRepository {
  MessageRepository(this._dio);

  final Dio _dio;
}
