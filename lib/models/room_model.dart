import 'package:json_annotation/json_annotation.dart';
import 'package:mobile1_flutter_coding_test/util/util.dart';

part 'room_model.g.dart';

@JsonSerializable()
class RoomModel {
  final String roomId;
  final String roomName;
  final String creator;
  final List<String> participants;
  @JsonKey(fromJson: dateTimeFromTimestamp)
  final DateTime createdAt;
  final LastMessageModel lastMessage;
  final String thumbnailImage;

  RoomModel({
    required this.roomId,
    required this.roomName,
    required this.creator,
    required this.participants,
    required this.createdAt,
    required this.lastMessage,
    required this.thumbnailImage,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}

@JsonSerializable()
class LastMessageModel {
  final String sender;
  final String content;
  @JsonKey(fromJson: dateTimeFromTimestamp)
  final DateTime timestamp;

  LastMessageModel({
    required this.sender,
    required this.content,
    required this.timestamp
  });

  factory LastMessageModel.fromJson(Map<String, dynamic> json) => _$LastMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$LastMessageModelToJson(this);
}