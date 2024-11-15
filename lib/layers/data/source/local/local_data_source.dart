import 'package:hive/hive.dart';

import '../../../../common/common.dart';
import '../../../domain/model/chat_message.dart';
import '../../data.dart';

class LocalDataSource {
  final Box<ChatMessageDAO> _box;

  LocalDataSource([Box<ChatMessageDAO>? box]) : _box = box ?? locator();

  Future<void> addMessage(ChatMessage message) async {
    await _box.add(ChatMessageDAO(
      roomId: message.roomId,
      messageId: message.messageId,
      sender: message.sender,
      content: message.content,
      timestamp: Etc.timestampFormatDate(message.timestamp),
    ));
  }

  Future<void> addMessages(List<ChatMessage> messages) async {
    for (var message in messages) {
      await addMessage(message);
    }
  }

  List<ChatMessageDAO> getAllMessages() {
    return _box.values.toList();
  }
}