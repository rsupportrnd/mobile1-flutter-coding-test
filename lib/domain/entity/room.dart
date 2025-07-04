import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
abstract class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required String roomId,
    required String roomName,
    required String creator,
    required List<String> participants,
    required String createdAt,
    required LastMessage lastMessage,
    required String thumbnailImage,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
}

@freezed
abstract class LastMessage with _$LastMessage {
  const factory LastMessage({
    required String sender,
    required String content,
    required String timestamp,
  }) = _LastMessage;

  factory LastMessage.fromJson(Map<String, dynamic> json) =>
      _$LastMessageFromJson(json);
}
