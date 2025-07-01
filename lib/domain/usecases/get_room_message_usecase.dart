import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/message_repository.dart';

class GetRoomMessageUseCase {
  final MessageRepository repository;

  GetRoomMessageUseCase(this.repository);

  Future<List<MessageEntity>> call({required String roomId}) async {
    final messages = await repository.getMessages();
    return messages.where((item) => item.roomId == roomId).toList();
  }
}
