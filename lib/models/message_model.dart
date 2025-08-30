import 'package:json_annotation/json_annotation.dart';
import 'package:mobile1_flutter_coding_test/utils/utils.dart';
part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {

  final String roomId;
  final String messageId;
  final String sender;
  final String content;
  @JsonKey(fromJson: dateTimeFromTimestamp, toJson: timestampToInt)
  final DateTime timestamp;

  MessageModel({
    required this.roomId,
    required this.messageId,
    required this.sender,
    required this.content,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}