import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const factory Room({
    @Default('111') String roomId,
    @Default('') String roomName,
    @Default('') String creator,
    @Default([]) List<String> participants,
    @Default('') String createdAt,
    String? thumbnailImage,
    Map<String, dynamic>? lastMessage,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
