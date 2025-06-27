import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting_room_list_response_entity.freezed.dart';
part 'meeting_room_list_response_entity.g.dart';

@freezed
class MeetingRoomListResponseEntity with _$MeetingRoomListResponseEntity {
  const factory MeetingRoomListResponseEntity({
    required List<MeetingRoomEntity> meetingRooms,
  }) = _MeetingRoomListResponseEntity;
}

@freezed
class MeetingRoomEntity with _$MeetingRoomEntity {
  const factory MeetingRoomEntity({
    required String roomId,
    required String roomName,
    required String creator,
    required List<String> participants,
    required DateTime createdAt,
    required LastMessageEntity lastMessage,
    required String thumbnailImage,
  }) = _MeetingRoomEntity;

  factory MeetingRoomEntity.fromJson(Map<String, dynamic> json) =>
      _$MeetingRoomEntityFromJson(json);
}

@freezed
class LastMessageEntity with _$LastMessageEntity {
  const factory LastMessageEntity({
    required String sender,
    required String content,
    required DateTime timestamp,
  }) = _LastMessageEntity;

  factory LastMessageEntity.fromJson(Map<String, dynamic> json) =>
      _$LastMessageEntityFromJson(json);
}
