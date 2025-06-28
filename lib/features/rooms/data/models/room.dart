import 'package:mobile1_flutter_coding_test/app/index.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required String roomId,
    required String roomName,
    required String creator,
    required List<String> participants,
    required DateTime createdAt,
    required LastMessage lastMessage,
    required String thumbnailImage,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

@freezed
class LastMessage with _$LastMessage {
  const factory LastMessage({
    required String sender,
    required String content,
    required DateTime timestamp,
  }) = _LastMessage;

  factory LastMessage.fromJson(Map<String, dynamic> json) =>
      _$LastMessageFromJson(json);
}
