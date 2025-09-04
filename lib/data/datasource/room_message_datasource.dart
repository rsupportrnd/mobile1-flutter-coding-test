import 'package:flutter/foundation.dart';
import 'package:mobile1_flutter_coding_test/core/network/request_api.dart';
import 'package:mobile1_flutter_coding_test/core/storage/hive_storage.dart';
import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/shared/const/api_endpoints.dart';
import 'package:mobile1_flutter_coding_test/shared/const/hive_boxs.dart';

class RoomMessageDatasource {
  /// 로컬 데이터 메세지 존재 여부
  Future<bool> hasMessages() async {
    final hasMessages =
        await HiveStorage.instance.get<bool>(HiveBoxKey.hasMessages);
    return hasMessages ?? false;
  }

  /// 채팅방 메세지 불러오기
  Future<ResponseResult<MessageListModel>> getRoomMessages() async {
    final response = await RequestApi.request(ApiEndpoints.messages,
        fromJson: MessageListModel.fromJson);

    return response;
  }

  /// 로컬 데이터 메세지 불러오기
  Future<Map<String, List<Map<String, dynamic>>>>
      getRoomMeesagesByStorage() async {
    try {
      final messages = await HiveStorage.instance.get(HiveBoxKey.messageList);

      if (messages == null) return {};

      final result = <String, List<Map<String, dynamic>>>{};

      for (final entry in messages.entries) {
        final roomId = entry.key.toString();
        final messageList = entry.value;

        if (messageList is List) {
          final convertedMessages = <Map<String, dynamic>>[];
          for (final message in messageList) {
            if (message is Map) {
              final convertedMessage = <String, dynamic>{};
              for (final msgEntry in message.entries) {
                convertedMessage[msgEntry.key.toString()] = msgEntry.value;
              }
              convertedMessages.add(convertedMessage);
            }
          }
          result[roomId] = convertedMessages;
        }
      }

      return result;
    } catch (e) {
      return {};
    }
  }

  /// 기존 메시지가 있으면 이어서 저장, 없으면 새로 저장
  Future<void> saveRoomMeesagesToStorage(
      Map<String, List<Map<String, dynamic>>> messages) async {
    try {
      final existingMessages = await getRoomMeesagesByStorage();

      final allMessages = <String, List<Map<String, dynamic>>>{};

// 기존 메시지 추가
      for (final entry in existingMessages.entries) {
        allMessages[entry.key] = List.from(entry.value);
      }

// 새 메시지 추가 (같은 키가 있으면 리스트에 추가)
      for (final entry in messages.entries) {
        if (allMessages.containsKey(entry.key)) {
          allMessages[entry.key]!.addAll(entry.value);
        } else {
          allMessages[entry.key] = List.from(entry.value);
        }
      }
      // 중복 제거 (messageId 기준)
      final uniqueMessages = <String, List<Map<String, dynamic>>>{};
      for (final entry in allMessages.entries) {
        final uniqueList = <String, Map<String, dynamic>>{};
        for (final message in entry.value) {
          final messageId = message['messageId']?.toString();
          if (messageId != null) {
            uniqueList[messageId] = message;
          }
        }
        uniqueMessages[entry.key] = uniqueList.values.toList();
      }

      await HiveStorage.instance.put(
        HiveBoxKey.messageList,
        uniqueMessages,
      );
      await setHasMessages(true);
    } catch (e) {
      debugPrint('메세지 저장 중 에러 발생 :  $e');
    }
  }

  /// 하나의 메세지 추가
  Future<void> addMessageToStorage(String roomId, Message message) async {
    await saveRoomMeesagesToStorage({
      roomId: [message.toJson()]
    });
  }

  /// 로컬 데이터 메세지 존재 여부 설정
  Future<void> setHasMessages(bool hasMessages) async {
    await HiveStorage.instance.put(
      HiveBoxKey.hasMessages,
      hasMessages,
    );
  }
}
