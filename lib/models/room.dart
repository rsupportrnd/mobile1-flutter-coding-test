import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required String roomId,
    required String roomName,
    required String creator,
    required List<String> participants,
    required String createdAt,
    String? thumbnailImage,
    Map<String, dynamic>? lastMessage,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

