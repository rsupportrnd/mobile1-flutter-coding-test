import 'dart:convert';
import 'package:dio/dio.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';
import '../sources/user_api_service.dart';
import '../models/user_list_response.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiService _apiService;
  final Dio _dio;

  UserRepositoryImpl(this._apiService, this._dio);

  @override
  Future<List<User>> getUsers() async {
    try {
      final response = await _apiService.getUsers();
      return response.users;
    } catch (e) {
      // GitHub raw 파일은 text/plain으로 오므로 수동 파싱 시도
      try {
        final rawResponse = await _dio.get('/users.json');

        // String으로 받은 데이터를 JSON으로 파싱
        final Map<String, dynamic> jsonData;
        if (rawResponse.data is String) {
          jsonData = jsonDecode(rawResponse.data);
        } else {
          jsonData = rawResponse.data;
        }

        final userListResponse = UserListResponse.fromJson(jsonData);
        return userListResponse.users;
      } catch (fallbackError) {
        throw Exception('Failed to fetch users: $e, Fallback error: $fallbackError');
      }
    }
  }
}