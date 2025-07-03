import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';
import 'package:mobile1_flutter_coding_test/data/model/room_model.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';

extension MessageModelToEntityExtension on MessageModel {
  Message toEntity() => Message(
      roomId: roomId,
      messageId: messageId,
      sender: sender,
      content: content,
      timestamp: timestamp);
}

extension MessageEntityToModelExtension on Message {
  MessageModel toModel() => MessageModel(
      roomId: roomId,
      messageId: messageId,
      sender: sender,
      content: content,
      timestamp: timestamp);
}

extension MessageEntityToLastMessageModellExtension on Message {
  LastMessageModel toLastMessageModel() =>
      LastMessageModel(sender: sender, content: content, timestamp: timestamp);
}
