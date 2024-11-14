import 'package:json_annotation/json_annotation.dart';

part 'meeting_room_dto.g.dart'; // 생성될 파일을 지정

@JsonSerializable()
class MeetingRoomDTO {
  final String roomId;
  final String roomName;
  final String creator;
  final List<String> participants;
  final DateTime createdAt;
  final LastMessageDTO lastMessage;
  final String thumbnailImage;

  MeetingRoomDTO({
    required this.roomId,
    required this.roomName,
    required this.creator,
    required this.participants,
    required this.createdAt,
    required this.lastMessage,
    required this.thumbnailImage,
  });

  factory MeetingRoomDTO.fromJson(Map<String, dynamic> json)=>
      _$MeetingRoomDTOFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MeetingRoomDTOToJson(this);

  /// JSON 데이터 리스트를 MeetingRoomDTO 리스트로 변환
  static List<MeetingRoomDTO> jsonList(List<dynamic> json) {
    return json
        .map((item) => MeetingRoomDTO.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

@JsonSerializable()
class LastMessageDTO {
  final String sender;
  final String content;
  final DateTime timestamp;

  LastMessageDTO({
    required this.sender,
    required this.content,
    required this.timestamp,
  });

  factory LastMessageDTO.fromJson(Map<String, dynamic> json) =>
      _$LastMessageDTOFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LastMessageDTOToJson(this);
}

