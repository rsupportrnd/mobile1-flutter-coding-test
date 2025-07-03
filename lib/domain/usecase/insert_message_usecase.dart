import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/message_repository.dart';

class InsertMessageUseCase {
  InsertMessageUseCase({required MessageRepository repository})
      : _repository = repository;
  final MessageRepository _repository;

  Future<Result<Message>> insertMessage({required Message message}) async =>
      await _repository.insertMessage(message: message);
}
