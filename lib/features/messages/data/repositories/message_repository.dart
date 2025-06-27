import '../models/message.dart';

abstract class MessageRepository {
  Future<List<Message>> fetchMessages();
}
