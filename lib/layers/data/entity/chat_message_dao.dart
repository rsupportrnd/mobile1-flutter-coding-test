import 'package:hive/hive.dart';

part 'chat_message_dao.g.dart'; // Hive code generation

@HiveType(typeId: 0)
class ChatMessageDAO extends HiveObject {
  @HiveField(0)
  final String roomId;

  @HiveField(1)
  final String messageId;

  @HiveField(2)
  final String sender;

  @HiveField(3)
  final String content;

  @HiveField(4)
  final String timestamp;

  ChatMessageDAO({
    required this.roomId,
    required this.messageId,
    required this.sender,
    required this.content,
    required this.timestamp,
  });
}
