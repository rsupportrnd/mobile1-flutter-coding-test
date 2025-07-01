import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';

abstract class MessageRepository {
  Future<List<MessageEntity>> getMessages();
  Future<MessageEntity> postMessage(MessageEntity message);
}
