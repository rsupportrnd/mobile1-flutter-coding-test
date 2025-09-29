import 'dart:convert';
import 'package:dio/dio.dart';
import '../../domain/repositories/chat_repository.dart';
import '../models/chat_room.dart';
import '../models/chat_message.dart';
import '../sources/chat_api_service.dart';
import '../models/chat_room_list_response.dart';
import '../models/chat_messages_response.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatApiService _apiService;
  final Dio _dio;

  ChatRepositoryImpl(this._apiService, this._dio);

  @override
  Future<List<ChatRoom>> getChatRooms() async {
    try {
      final response = await _apiService.getChatRooms();
      return response.chatRooms;
    } catch (e) {
      // GitHub raw 파일은 text/plain으로 오므로 수동 파싱 시도
      try {
        final rawResponse = await _dio.get('/rooms.json');

        // String으로 받은 데이터를 JSON으로 파싱
        final Map<String, dynamic> jsonData;
        if (rawResponse.data is String) {
          jsonData = jsonDecode(rawResponse.data);
        } else {
          jsonData = rawResponse.data;
        }

        final chatRoomListResponse = ChatRoomListResponse.fromJson(jsonData);
        return chatRoomListResponse.chatRooms;
      } catch (fallbackError) {
        throw Exception('Failed to fetch chat rooms: $e, Fallback error: $fallbackError');
      }
    }
  }

  @override
  Future<List<ChatMessage>> getMessagesForRoom(String roomId) async {
    try {
      final response = await _apiService.getMessages();
      // 특정 roomId에 해당하는 메시지만 필터링
      return response.messages.where((message) => message.roomId == roomId).toList();
    } catch (e) {
      // GitHub raw 파일은 text/plain으로 오므로 수동 파싱 시도
      try {
        final rawResponse = await _dio.get('/messages.json');

        // String으로 받은 데이터를 JSON으로 파싱
        final Map<String, dynamic> jsonData;
        if (rawResponse.data is String) {
          jsonData = jsonDecode(rawResponse.data);
        } else {
          jsonData = rawResponse.data;
        }

        final chatMessagesResponse = ChatMessagesResponse.fromJson(jsonData);
        // 특정 roomId에 해당하는 메시지만 필터링
        return chatMessagesResponse.messages.where((message) => message.roomId == roomId).toList();
      } catch (fallbackError) {
        throw Exception('Failed to fetch messages: $e, Fallback error: $fallbackError');
      }
    }
  }
}