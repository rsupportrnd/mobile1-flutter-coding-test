import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobile1_flutter_coding_test/layers/data/entity/meeting_room_dto.dart';

import '../../entity/chat_message_dto.dart';
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

  Future<List<MeetingRoomDTO>> fetchMeetingRoom() async {
    try {
      // JSON 파일을 읽고 데이터를 디코딩합니다.
      final response = await rootBundle.loadString('assets/api/rooms.json');

      // JSON 문자열을 디코딩하여 'chatRooms' 키에서 리스트를 추출
      List<dynamic> jsonList = json.decode(response)['chatRooms'];

      return MeetingRoomDTO.jsonList(jsonList);
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<List<ChatMessageDTO>> fetchChatMessage() async {
    try {
      // JSON 파일을 읽고 데이터를 디코딩합니다.
      final response = await rootBundle.loadString('assets/api/messages.json');

      // JSON 문자열을 디코딩하여 'messages' 키에서 리스트를 추출
      List<dynamic> jsonList = json.decode(response)['messages'];

      return ChatMessageDTO.jsonList(jsonList);
    } catch (e) {
      throw Exception('$e');
    }
  }
}
