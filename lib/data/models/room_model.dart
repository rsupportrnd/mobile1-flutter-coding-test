/*
    {
      "roomId": "room1",
      "roomName": "프로젝트 A 회의",
      "creator": "user1",
      "participants": ["user1", "user2", "user3"],
      "createdAt": "2024-11-01T09:00:00Z",
      "lastMessage": {
        "sender": "user2",
        "content": "다음 회의는 언제로 할까요?",
        "timestamp": "2024-11-07T15:30:00Z"
      },
      "thumbnailImage": "https://picsum.photos/id/1011/200/200"
    },
*/

import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

@freezed
abstract class RoomModel with _$RoomModel {
  const factory RoomModel({
    required String roomId,
    required String roomName,
    required String creator,
    required List<String> participants,
    required DateTime createdAt,
    required LastMessageModel lastMessage,
    required String thumbnailImage,
  }) = _RoomModel;

  factory RoomModel.fromJson(Map<String, dynamic> json) => _$RoomModelFromJson(json);
}

@freezed
abstract class LastMessageModel with _$LastMessageModel {
  const factory LastMessageModel({
    required String sender,
    required String content,
    required DateTime timestamp,
  }) = _LastMessageModel;

  factory LastMessageModel.fromJson(Map<String, dynamic> json) => _$LastMessageModelFromJson(json);
}
