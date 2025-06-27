import '../models/message.dart';

abstract class MessageRepository {
  Future<List<Message>> fetchMessages();
  Future<void> saveMessage(Message message);
  Future<List<Message>> getLocalMessagesByRoom(String roomId);
}
