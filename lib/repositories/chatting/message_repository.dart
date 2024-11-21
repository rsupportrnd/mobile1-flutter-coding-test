import 'package:mobile1_flutter_coding_test/index.dart';
import 'package:http/http.dart' as http;

abstract class MessageRepository {
  Future<List<MessageModel>> fetchMessages();
}