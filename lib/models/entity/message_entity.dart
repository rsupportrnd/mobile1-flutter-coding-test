import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'message_entity.g.dart';

@Entity()
@JsonSerializable()
class MessageEntity {
  @Id()
  int id;
  String roomId;
  String messageId;
  String sender;
  String content;

  @Property(type: PropertyType.date)
  DateTime timestamp;

  MessageEntity({
    this.id = 0,
    required this.roomId,
    required this.messageId,
    required this.sender,
    required this.content,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  MessageEntity.fromMessageModel(messageModel) :
        id = 0,
        roomId = messageModel.roomId,
        messageId = messageModel.messageId,
        sender = messageModel.sender,
        content = messageModel.content,
        timestamp = DateTime.parse(messageModel.timestamp);

  factory MessageEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MessageEntityToJson(this);
}
