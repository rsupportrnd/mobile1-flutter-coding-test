import 'package:mobile1_flutter_coding_test/src/data/data.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';

final class MessageMapper {
  const MessageMapper._();

  static MessageEntity messageModelToEntity(final MessageModel model) {
    return MessageEntity(
      roomId: model.roomId,
      messageId: model.messageId,
      sender: model.sender,
      content: model.content,
      timestamp: model.timestamp,
    );
  }

  static MessageModel messageEntityToModel(final MessageEntity entity) {
    return MessageModel(
      roomId: entity.roomId,
      messageId: entity.messageId,
      sender: entity.sender,
      content: entity.content,
      timestamp: entity.timestamp,
    );
  }

  static MessageListResponseEntity messageListModelToEntity(
    final MessageListResponseModel model,
  ) {
    return MessageListResponseEntity(
      messages: model.messages.map(messageModelToEntity).toList(),
    );
  }
}
