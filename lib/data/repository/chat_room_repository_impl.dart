import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/core/network/response_codes.dart';
import 'package:mobile1_flutter_coding_test/core/network/response_result.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/chat_room_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/model/chat_room_model.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/chat_room.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/chat_room_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_room_repository_impl.g.dart';

@riverpod
ChatRoomRepository chatRoomRepository(Ref ref) {
  final chatRoomDatasource = ChatRoomDatasource();
  return ChatRoomRepositoryImpl(chatRoomDatasource: chatRoomDatasource);
}

class ChatRoomRepositoryImpl implements ChatRoomRepository {
  final ChatRoomDatasource chatRoomDatasource;

  ChatRoomRepositoryImpl({required this.chatRoomDatasource});

  @override
  Future<ResponseResult<List<ChatRoom>>> getChatRooms() async {
    final response = await chatRoomDatasource.getChatRooms();
    if (response.code != ResponseCodes.success) {
      throw Exception('실패 에러 코드 : ${response.code}');
    }
    return ResponseResult(
        code: response.code, data: _convertToEntity(response.data));
  }

  List<ChatRoom> _convertToEntity(ChatRoomListModel? chatRoomList) {
    if (chatRoomList == null) return [];
    return chatRoomList.chatRooms
        .map((chatRoom) => ChatRoom(
              roomId: chatRoom.roomId,
              roomName: chatRoom.roomName,
              creator: chatRoom.creator,
              participants: chatRoom.participants,
              createdAt: chatRoom.createdAt,
              lastMessage: _convertToEntityMessage(chatRoom.lastMessage),
              thumbnailImage: chatRoom.thumbnailImage,
            ))
        .toList();
  }

  Message _convertToEntityMessage(Map<String, dynamic> lastMessage) {
    return Message(
        sender: lastMessage['sender'],
        content: lastMessage['content'],
        timestamp: lastMessage['timestamp']);
  }
}
