import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/message_list_response_model.dart';

part 'message_list_response_entity.freezed.dart';
part 'message_list_response_entity.g.dart';

@freezed
class MessageListResponseEntity with _$MessageListResponseEntity {
  const factory MessageListResponseEntity({
    required List<MessageEntity> messages,
  }) = _MessageListResponseEntity;

  factory MessageListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageListResponseEntityFromJson(json);

  factory MessageListResponseEntity.fromModel(MessageListResponseModel model) =>
      MessageListResponseEntity(
          messages: model.messages.map((e) => MessageEntity.fromModel(e)).toList());
}

@freezed
class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    required String roomId,
    required String messageId,
    required String sender,
    required String content,
    required DateTime timestamp,
  }) = _MessageEntity;

  factory MessageEntity.fromJson(Map<String, dynamic> json) => _$MessageEntityFromJson(json);

  factory MessageEntity.fromModel(MessageModel model) => MessageEntity(
        roomId: model.roomId,
        messageId: model.messageId,
        sender: model.sender,
        content: model.content,
        timestamp: model.timestamp,
      );
}
