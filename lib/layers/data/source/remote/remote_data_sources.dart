import 'dart:convert';

import 'package:flutter/services.dart';

import '../../entity/user_dto.dart';

class RemoteDataSources {
  Future<List<UserDTO>> fetchUsers() async {
    try {
      // JSON 파일을 읽고 데이터를 디코딩합니다.
      final response = await rootBundle.loadString('assets/api/users.json');

      // JSON 문자열을 디코딩하여 'users' 키에서 리스트를 추출
      List<dynamic> jsonList = json.decode(response)['users'];

      return UserDTO.jsonList(jsonList);
    } catch (e) {
      throw Exception('$e');
    }
  }
}
