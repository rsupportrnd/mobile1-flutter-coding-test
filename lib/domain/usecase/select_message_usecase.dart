import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/message_repository.dart';

class SelectMessageUseCase {
  SelectMessageUseCase({required MessageRepository repository})
      : _repository = repository;
  final MessageRepository _repository;

  Future<Result<List<Message>>> call({required String roomId}) async =>
      await _repository.selectMessages(roomId: roomId);
}
