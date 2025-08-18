import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/room.dart';

class RoomRepository {
  RoomRepository(this._dio);

  final Dio _dio;
}
