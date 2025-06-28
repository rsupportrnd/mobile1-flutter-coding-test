import 'package:mobile1_flutter_coding_test/app/index.dart';

abstract class MessageRepository {
  Future<List<Message>> fetchMessages();
  Future<void> saveMessage(Message message);
  Future<List<Message>> getLocalMessagesByRoom(String roomId);
}
