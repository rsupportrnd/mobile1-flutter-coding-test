import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting_room_list_response_model.freezed.dart';
part 'meeting_room_list_response_model.g.dart';

@freezed
class MeetingRoomListResponseModel with _$MeetingRoomListResponseModel {
  const factory MeetingRoomListResponseModel({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'chatRooms') required List<MeetingRoomModel> meetingRooms,
  }) = _MeetingRoomListResponseModel;

  factory MeetingRoomListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingRoomListResponseModelFromJson(json);
}

@freezed
class MeetingRoomModel with _$MeetingRoomModel {
  const factory MeetingRoomModel({
    required String roomId,
    required String roomName,
    required String creator,
    required List<String> participants,
    required DateTime createdAt,
    required LastMessageModel lastMessage,
    required String thumbnailImage,
  }) = _MeetingRoomModel;

  factory MeetingRoomModel.fromJson(Map<String, dynamic> json) => _$MeetingRoomModelFromJson(json);
}

@freezed
class LastMessageModel with _$LastMessageModel {
  const factory LastMessageModel({
    required String sender,
    required String content,
    required DateTime timestamp,
  }) = _LastMessageModel;

  factory LastMessageModel.fromJson(Map<String, dynamic> json) => _$LastMessageModelFromJson(json);
}
