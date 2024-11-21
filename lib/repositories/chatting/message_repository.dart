import 'package:mobile1_flutter_coding_test/index.dart';

abstract class MessageRepository {
  Future<List<MessageModel>> fetchMessages();
}