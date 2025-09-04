import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';

class Message {
  final String? roomId;
  final String? messageId;
  final String sender;
  final String content;
  final String timestamp;

  Message({
    this.roomId,
    this.messageId,
    required this.sender,
    required this.content,
    required this.timestamp,
  });

  factory Message.fromModel(MessageModel model) => Message(
        roomId: model.roomId,
        messageId: model.messageId,
        sender: model.sender,
        content: model.content,
        timestamp: model.timestamp,
      );
}
