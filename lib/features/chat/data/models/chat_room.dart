import 'package:freezed_annotation/freezed_annotation.dart';
import 'last_message.dart';

part 'chat_room.freezed.dart';
part 'chat_room.g.dart';

@freezed
abstract class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required String roomId,
    required String roomName,
    required String creator,
    required List<String> participants,
    required DateTime createdAt,
    required LastMessage lastMessage,
    required String thumbnailImage,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);
}