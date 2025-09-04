import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/core/network/response_codes.dart';
import 'package:mobile1_flutter_coding_test/core/network/response_result.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/room_message_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/room_message_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'room_message_repository_impl.g.dart';

@riverpod
RoomMessageRepository roomMessageRepository(Ref ref) {
  final roomMessageDatasource = RoomMessageDatasource();
  return RoomMessageRepositoryImpl(
      roomMessageDatasource: roomMessageDatasource);
}

class RoomMessageRepositoryImpl implements RoomMessageRepository {
  final RoomMessageDatasource roomMessageDatasource;

  RoomMessageRepositoryImpl({required this.roomMessageDatasource});

  @override

  /// 채팅방 메세지 조회
  Future<ResponseResult<Map<String, List<Message>>>> getRoomMessages() async {
    final hasMessages = await roomMessageDatasource.hasMessages();
    if (hasMessages) {
      final messages = await roomMessageDatasource.getRoomMeesagesByStorage();
      return ResponseResult(
          code: ResponseCodes.success, data: _convertToEntity(messages));
    }

    final response = await roomMessageDatasource.getRoomMessages();
    if (response.code != ResponseCodes.success) {
      throw Exception('실패 에러 코드 : ${response.code}');
    }
    final messagesMap = <String, List<Message>>{};
    final localMessagesMap = <String, List<Map<String, dynamic>>>{};
    for (MessageModel message in response.data?.messages ?? []) {
      final messageJson = message.toJson();
      messagesMap[message.roomId] = [
        ...messagesMap[message.roomId] ?? [],
        Message.fromJson(messageJson)
      ];
      localMessagesMap[message.roomId] = [
        ...localMessagesMap[message.roomId] ?? [],
        messageJson
      ];
    }

    await roomMessageDatasource.saveRoomMeesagesToStorage(
      localMessagesMap,
    );

    return ResponseResult(code: response.code, data: messagesMap);
  }

  @override

  /// 여러 메세지 추가(로컬)
  Future<void> saveRoomMessagesToStorage(
      Map<String, List<Map<String, dynamic>>> messages) {
    return roomMessageDatasource.saveRoomMeesagesToStorage(messages);
  }

  @override

  /// 하나의 메세지 추가(로컬)
  Future<void> addMessageToStorage(String roomId, Message message) {
    return roomMessageDatasource.addMessageToStorage(roomId, message);
  }

  /// 메세지 엔티티 변환
  Map<String, List<Message>> _convertToEntity(
      Map<String, List<Map<String, dynamic>>> messages) {
    return messages.map((key, value) =>
        MapEntry(key, value.map((e) => Message.fromJson(e)).toList()));
  }
}
