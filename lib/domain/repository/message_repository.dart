import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';

abstract class MessageRepository {
  Future<Result<List<Message>>> getMessages();
  Future<Result<List<Message>>> selectMessages();
  Future<Result<List<Message>>> selectMessagesByRoomId(
      {required String roomId});
  Future<Result<Message>> insertMessage({required Message message});
  Future<Result<void>> insertMessages({required List<Message> messages});
}
