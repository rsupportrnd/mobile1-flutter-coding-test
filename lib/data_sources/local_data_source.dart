import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/room.dart';
import '../models/message.dart';
import '../repositories/user_repository.dart';
import '../repositories/room_repository.dart';
import '../repositories/message_repository.dart';
import '../config/app_constants.dart';
import '../utils/cache_utils.dart';
import '../utils/logger.dart';

/// 사용자 로컬 데이터 소스 구현체
class UserLocalDataSourceImpl implements UserLocalDataSource {
  static const String _usersKey = AppConstants.cachedUsersKey;
  static const String _lastUpdateKey = AppConstants.usersLastUpdateKey;

  @override
  Future<List<User>> getUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getStringList(_usersKey) ?? [];
      return CacheUtils.jsonListToUsers(usersJson);
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveUsers(List<User> users) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = CacheUtils.usersToJsonList(users);
      
      await prefs.setStringList(_usersKey, usersJson);
      await prefs.setString(_lastUpdateKey, CacheUtils.dateTimeToString(DateTime.now()));
    } catch (e) {
      Logger.error('사용자 저장 실패', error: e);
    }
  }

  @override
  Future<void> clearUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_usersKey);
      await prefs.remove(_lastUpdateKey);
    } catch (e) {
      Logger.error('사용자 캐시 클리어 실패', error: e);
    }
  }
}

/// 회의실 로컬 데이터 소스 구현체
class RoomLocalDataSourceImpl implements RoomLocalDataSource {
  static const String _roomsKey = AppConstants.cachedRoomsKey;
  static const String _lastUpdateKey = AppConstants.roomsLastUpdateKey;

  @override
  Future<List<Room>> getRooms() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final roomsJson = prefs.getStringList(_roomsKey) ?? [];
      return CacheUtils.jsonListToRooms(roomsJson);
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveRooms(List<Room> rooms) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final roomsJson = CacheUtils.roomsToJsonList(rooms);
      
      await prefs.setStringList(_roomsKey, roomsJson);
      await prefs.setString(_lastUpdateKey, CacheUtils.dateTimeToString(DateTime.now()));
    } catch (e) {
      Logger.error('회의실 저장 실패', error: e);
    }
  }

  @override
  Future<void> clearRooms() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_roomsKey);
      await prefs.remove(_lastUpdateKey);
    } catch (e) {
      Logger.error('회의실 캐시 클리어 실패', error: e);
    }
  }

  Future<DateTime?> getLastUpdateTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastUpdateStr = prefs.getString(_lastUpdateKey);
      return CacheUtils.stringToDateTime(lastUpdateStr);
    } catch (e) {
      Logger.error('마지막 업데이트 시간 가져오기 실패', error: e);
      return null;
    }
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
      
      // 특정 룸의 메시지만 필터링
      return allMessages.where((message) => message.roomId == roomId).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Message?> getMessageById(String messageId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final messagesJson = prefs.getStringList(_messagesKey) ?? [];
      
      final allMessages = CacheUtils.jsonListToMessages(messagesJson);
      
      return allMessages.firstWhere((message) => message.id == messageId);
    } catch (e) {
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
      } else {
        // 새 메시지 추가
        messagesJson.add(json.encode(message.toJson()));
      }
      
      await prefs.setStringList(_messagesKey, messagesJson);
    } catch (e) {
      Logger.error('메시지 저장 실패', error: e);
    }
  }
}