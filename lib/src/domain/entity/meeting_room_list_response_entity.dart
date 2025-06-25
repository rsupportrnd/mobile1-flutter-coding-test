import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/meeting_room_list_response_model.dart';

part 'meeting_room_list_response_entity.freezed.dart';
part 'meeting_room_list_response_entity.g.dart';

@freezed
class MeetingRoomListResponseEntity with _$MeetingRoomListResponseEntity {
  const factory MeetingRoomListResponseEntity({
    required List<MeetingRoomEntity> meetingRooms,
  }) = _MeetingRoomListResponseEntity;

  factory MeetingRoomListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$MeetingRoomListResponseEntityFromJson(json);

  factory MeetingRoomListResponseEntity.fromModel(MeetingRoomListResponseModel model) {
    return MeetingRoomListResponseEntity(
        meetingRooms:
            model.meetingRooms.map((roomModel) => MeetingRoomEntity.fromModel(roomModel)).toList());
  }
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

  factory MeetingRoomEntity.fromModel(MeetingRoomModel model) {
    return MeetingRoomEntity(
      roomId: model.roomId,
      roomName: model.roomName,
      creator: model.creator,
      participants: model.participants,
      createdAt: model.createdAt,
      lastMessage: LastMessageEntity.fromModel(model.lastMessage),
      thumbnailImage: model.thumbnailImage,
    );
  }
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

  factory LastMessageEntity.fromModel(LastMessageModel model) {
    return LastMessageEntity(
      sender: model.sender,
      content: model.content,
      timestamp: model.timestamp,
    );
  }
}
