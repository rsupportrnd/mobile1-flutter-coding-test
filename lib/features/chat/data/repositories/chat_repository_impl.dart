import 'dart:convert';
import 'package:dio/dio.dart';
import '../../domain/repositories/chat_repository.dart';
import '../models/chat_room.dart';
import '../models/chat_message.dart';
import '../sources/chat_api_service.dart';
import '../sources/chat_local_service.dart';
import '../models/chat_room_list_response.dart';
import '../models/chat_messages_response.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatApiService _apiService;
  final ChatLocalService _localService;
  final Dio _dio;

  ChatRepositoryImpl(this._apiService, this._localService, this._dio);

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
      // 1. 로컬 DB와 API를 병렬로 호출
      final results = await Future.wait([
        _getMessagesFromLocal(roomId),
        _getMessagesFromApi(roomId),
      ]);

      final localMessages = results[0];
      final apiMessages = results[1];

      // 2. API와 로컬 메시지를 병합 (API 우선, messageId 기준 중복 제거)
      final mergedMessages = _mergeMessages(localMessages, apiMessages);

      // 3. 새로운 API 메시지가 있으면 로컬 DB에 저장
      final newApiMessages = _getNewApiMessages(localMessages, apiMessages);
      if (newApiMessages.isNotEmpty) {
        await _localService.insertMessages(newApiMessages);
      }

      return mergedMessages;
    } catch (e) {
      // API 실패시 로컬 데이터라도 반환
      final localMessages = await _getMessagesFromLocal(roomId);
      if (localMessages.isNotEmpty) {
        return localMessages;
      }
      rethrow;
    }
  }

  // 로컬 DB에서 메시지 조회
  Future<List<ChatMessage>> _getMessagesFromLocal(String roomId) async {
    try {
      final localMessageData = await _localService.getMessagesForRoom(roomId);
      return _localService.convertToModelList(localMessageData);
    } catch (e) {
      // 로컬 DB 조회 실패시 빈 리스트 반환
      return [];
    }
  }

  // API에서 메시지 조회
  Future<List<ChatMessage>> _getMessagesFromApi(String roomId) async {
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

  // 로컬과 API 메시지를 병합 (API 우선, messageId 기준 중복 제거)
  List<ChatMessage> _mergeMessages(
    List<ChatMessage> localMessages,
    List<ChatMessage> apiMessages,
  ) {
    final Map<String, ChatMessage> messageMap = {};

    // 1. 먼저 로컬 메시지를 맵에 추가
    for (final message in localMessages) {
      messageMap[message.messageId] = message;
    }

    // 2. API 메시지로 덮어쓰기 (API 우선)
    for (final message in apiMessages) {
      messageMap[message.messageId] = message;
    }

    // 3. timestamp 기준으로 정렬하여 반환
    final mergedList = messageMap.values.toList();
    mergedList.sort((a, b) => b.timestamp.compareTo(a.timestamp)); // 최신 순
    return mergedList;
  }

  // 로컬에 없는 새로운 API 메시지만 찾기
  List<ChatMessage> _getNewApiMessages(
    List<ChatMessage> localMessages,
    List<ChatMessage> apiMessages,
  ) {
    final localMessageIds = localMessages.map((m) => m.messageId).toSet();
    return apiMessages.where((message) => !localMessageIds.contains(message.messageId)).toList();
  }

  @override
  Future<ChatMessage> sendMessage({
    required String roomId,
    required String sender,
    required String content,
  }) async {
    try {
      // 로컬 DB에 메시지 저장 (msgId 자동 생성)
      final savedMessage = await _localService.insertUserMessage(
        roomId: roomId,
        sender: sender,
        content: content,
      );

      // TODO: 추후 실제 서버로 메시지 전송 API 구현
      // await _apiService.sendMessage(savedMessage);

      return savedMessage;
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}