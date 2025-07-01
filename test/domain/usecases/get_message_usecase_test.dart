import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/message_repository.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_room_message_usecase.dart';

class FakeMessageRepository implements MessageRepository {
  @override
  Future<List<MessageEntity>> getMessages() async {
    return [
      MessageEntity(
        roomId: 'room1',
        messageId: 'msg1',
        sender: 'user1',
        content: '안녕하세요, 오늘 회의 시작할까요?',
        timestamp: DateTime(2024, 1, 1, 10, 0, 0),
      ),
      MessageEntity(
        roomId: 'room1',
        messageId: 'msg2',
        sender: 'user2',
        content: '안녕하세요, 오늘 회의 시작할까요?',
        timestamp: DateTime(2024, 1, 1, 10, 0, 0),
      ),
      MessageEntity(
        roomId: 'room3',
        messageId: 'msg3',
        sender: 'user3',
        content: '안녕하세요, 오늘 회의 시작할까요?',
        timestamp: DateTime(2024, 1, 1, 10, 0, 0),
      ),
    ];
  }

  @override
  Future<MessageEntity> postMessage(MessageEntity message) {
    throw UnimplementedError();
  }
}

void main() {
  test('GetRoomMessageUseCase', () async {
    final repository = FakeMessageRepository();
    final useCase = GetRoomMessageUseCase(repository);

    final messages = await useCase.call(roomId: 'room1');

    expect(messages, isA<List<MessageEntity>>());
    expect(messages.every((message) => message.roomId == 'room1'), true);
    expect(messages.length, 2);
  });
}
