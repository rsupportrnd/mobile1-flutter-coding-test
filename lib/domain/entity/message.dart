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

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        roomId: json['roomId'],
        messageId: json['messageId'],
        sender: json['sender'],
        content: json['content'],
        timestamp: json['timestamp'],
      );

  toJson() => {
        'roomId': roomId,
        'messageId': messageId,
        'sender': sender,
        'content': content,
        'timestamp': timestamp,
      };
}
