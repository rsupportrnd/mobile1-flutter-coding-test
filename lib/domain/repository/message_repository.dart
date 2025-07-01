import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';

abstract class MessageRepository {
  Future<Result<List<Message>>> getMessages();
}
