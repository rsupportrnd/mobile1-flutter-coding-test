import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/message_repository.dart';

class PostRoomMessageUseCase {
  final MessageRepository repository;

  PostRoomMessageUseCase(this.repository);

  Future<MessageEntity> call({required MessageEntity message}) async {
    return repository.postMessage(message);
  }
}
