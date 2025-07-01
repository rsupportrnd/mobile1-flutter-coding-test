import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/data/models/message_model.dart';

part 'message_entity.freezed.dart';
part 'message_entity.g.dart';

@freezed
abstract class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    required String roomId,
    required String messageId,
    required String sender,
    required String content,
    required DateTime timestamp,
  }) = _MessageEntity;

  factory MessageEntity.fromModel(MessageModel model) => MessageEntity(
        roomId: model.roomId,
        messageId: model.messageId,
        sender: model.sender,
        content: model.content,
        timestamp: model.timestamp,
      );
  factory MessageEntity.fromJson(Map<String, dynamic> json) => _$MessageEntityFromJson(json);
}
