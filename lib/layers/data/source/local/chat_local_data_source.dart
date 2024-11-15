

import 'package:hive/hive.dart';

import '../../../../common/common.dart';
import '../../../domain/model/chat_message.dart';
import '../../data.dart';

class ChatLocalDataSource {
  final Box<ChatMessageDAO> _box;

  ChatLocalDataSource([Box<ChatMessageDAO>? box]) : _box = box ?? locator();

  Future<void> addMessage(ChatMessage message) async {
    await _box.add(ChatMessageDAO(
      roomId: message.roomId,
      messageId: message.messageId,
      sender: message.sender,
      content: message.content,
      timestamp: Etc.timestampFormatDate(message.timestamp),
    ));
  }

  /// 모든 메시지를 한 번에 저장
  Future<void> addMessages(List<ChatMessage> messages) async {
    for (var message in messages) {
      await addMessage(message);
    }
  }

  List<ChatMessageDAO> getAllMessages() {
    return _box.values.toList();
  }
}