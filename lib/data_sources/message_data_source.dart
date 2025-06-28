import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/message.dart';
import '../config/app_constants.dart';
import '../utils/cache_utils.dart';
import '../utils/logger.dart';
import 'http_client.dart';

/// 메시지 원격 데이터 소스 인터페이스
abstract class MessageRemoteDataSource {
  Future<List<Message>> fetchMessages(String roomId);
  Future<void> sendMessage(Message message);
}

/// 메시지 로컬 데이터 소스 인터페이스
abstract class MessageLocalDataSource {
  Future<List<Message>> getMessages(String roomId);
  Future<Message?> getMessageById(String messageId);
  Future<void> saveMessage(Message message);
  Future<void> clearMessages(String roomId);
  Future<List<Message>> getAllMessages();
  Future<void> clearAllMessages();
}

/// 메시지 원격 데이터 소스 구현체
class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final HttpClient _httpClient;

  MessageRemoteDataSourceImpl({HttpClient? httpClient}) 
      : _httpClient = httpClient ?? HttpClient();

  @override
  Future<List<Message>> fetchMessages(String roomId) async {
    final url = AppConstants.getMessagesUrl();
    
    try {
      Logger.debug('메시지 조회 대상 룸: $roomId');
      
      final jsonResponse = await _httpClient.get(url);
      final List<dynamic> jsonData = jsonResponse['messages'];
      final allMessages = jsonData.map((json) {
        // API 데이터 형태에 맞게 변환
        final messageJson = {
          'id': json['messageId'],
          'roomId': json['roomId'],
          'userId': json['sender'],
          'userName': null, // API에서 제공하지 않음
          'content': json['content'],
          'timestamp': json['timestamp'],
        };
        return Message.fromJson(messageJson);
      }).toList();
      
      // 특정 룸의 메시지만 필터링
      final filteredMessages = allMessages.where((message) => message.roomId == roomId).toList();
      
      Logger.info('룸 $roomId의 메시지 ${filteredMessages.length}개 조회 완료 (전체 ${allMessages.length}개 중)');
      return filteredMessages;
    } catch (e) {
      Logger.error('메시지 목록 조회 실패', error: e);
      throw Exception('${AppConstants.loadingMessagesErrorMessage}: $e');
    }
  }

  @override
  Future<void> sendMessage(Message message) async {
    final url = AppConstants.getMessagesUrl();
    final messageBody = {
      'messageId': message.id,
      'roomId': message.roomId,
      'sender': message.userId,
      'content': message.content,
      'timestamp': message.timestamp.toIso8601String(),
    };
    
    try {
      Logger.debug('전송할 메시지: ${message.content.length > 50 ? '${message.content.substring(0, 50)}...' : message.content}');
      
      await _httpClient.post(url, messageBody);
      Logger.info('메시지 전송 성공: 룸 ${message.roomId}');
    } catch (e) {
      Logger.error('메시지 전송 실패', error: e);
      throw Exception('메시지 전송 실패: $e');
    }
  }

  void dispose() {
    _httpClient.dispose();
  }
}

/// 메시지 로컬 데이터 소스 구현체
class MessageLocalDataSourceImpl implements MessageLocalDataSource {
  static const String _messagesKey = AppConstants.cachedMessagesKey;

  @override
  Future<List<Message>> getMessages(String roomId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final messagesJson = prefs.getStringList(_messagesKey) ?? [];
      
      final allMessages = CacheUtils.jsonListToMessages(messagesJson);
      final roomMessages = allMessages.where((message) => message.roomId == roomId).toList();
      
      Logger.cache('로드', '${_messagesKey}_$roomId', hit: roomMessages.isNotEmpty);
      return roomMessages;
    } catch (e) {
      Logger.error('로컬 메시지 데이터 로드 실패', error: e);
      return [];
    }
  }

  @override
  Future<Message?> getMessageById(String messageId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final messagesJson = prefs.getStringList(_messagesKey) ?? [];
      
      final allMessages = CacheUtils.jsonListToMessages(messagesJson);
      
      for (var message in allMessages) {
        if (message.id == messageId) {
          return message;
        }
      }
      return null;
    } catch (e) {
      Logger.error('메시지 ID로 조회 실패', error: e);
      return null;
    }
  }

  @override
  Future<void> saveMessage(Message message) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final messagesJson = prefs.getStringList(_messagesKey) ?? [];
      
      // 중복 메시지 확인
      final existingMessages = CacheUtils.jsonListToMessages(messagesJson);
      
      final existingIndex = existingMessages.indexWhere((m) => m.id == message.id);
      
      if (existingIndex != -1) {
        // 기존 메시지 업데이트
        messagesJson[existingIndex] = json.encode(message.toJson());
        Logger.cache('업데이트', '${_messagesKey}_${message.id}');
      } else {
        // 새 메시지 추가
        messagesJson.add(json.encode(message.toJson()));
        Logger.cache('저장', '${_messagesKey}_${message.id}');
      }
      
      await prefs.setStringList(_messagesKey, messagesJson);
    } catch (e) {
      Logger.error('메시지 저장 실패', error: e);
    }
  }

  @override
  Future<void> clearMessages(String roomId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final messagesJson = prefs.getStringList(_messagesKey) ?? [];
      
      final allMessages = CacheUtils.jsonListToMessages(messagesJson);
      
      // 해당 룸의 메시지만 제거
      final filteredMessages = allMessages
          .where((message) => message.roomId != roomId)
          .toList();
      
      final filteredJson = CacheUtils.messagesToJsonList(filteredMessages);
      await prefs.setStringList(_messagesKey, filteredJson);
      
      Logger.cache('클리어', '${_messagesKey}_$roomId');
    } catch (e) {
      Logger.error('메시지 클리어 실패', error: e);
    }
  }

  @override
  Future<List<Message>> getAllMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final messagesJson = prefs.getStringList(_messagesKey) ?? [];
      
      final messages = CacheUtils.jsonListToMessages(messagesJson);
      Logger.cache('전체 로드', _messagesKey, hit: messages.isNotEmpty);
      return messages;
    } catch (e) {
      Logger.error('전체 메시지 조회 실패', error: e);
      return [];
    }
  }

  @override
  Future<void> clearAllMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_messagesKey);
      
      Logger.cache('전체 클리어', _messagesKey);
    } catch (e) {
      Logger.error('전체 메시지 클리어 실패', error: e);
    }
  }
} 