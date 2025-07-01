import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/message_repository.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_room_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/post_room_message_usecase.dart';

class FakeMessageRepository implements MessageRepository {
  final List<MessageEntity> messages = [];
  @override
  Future<List<MessageEntity>> getMessages() async {
    return messages;
  }

  @override
  Future<MessageEntity> postMessage(MessageEntity message) async {
    messages.add(message);
    return message;
  }
}

void main() {
  test('PostMessageUseCase', () async {
    final repository = FakeMessageRepository();
    final getRoomMessageUseCase = GetRoomMessageUseCase(repository);
    final postRoomMessageuseCase = PostRoomMessageUseCase(repository);

    final messages = await getRoomMessageUseCase.call(roomId: 'room1');

    expect(messages, isA<List<MessageEntity>>());
    expect(messages.isEmpty, true);

    final testMessage = MessageEntity(
      sender: 'me',
      roomId: 'room1',
      messageId: 'msg100',
      content: '테스트 메시지',
      timestamp: DateTime(2024, 1, 1, 13, 0, 0),
    );

    final result = await postRoomMessageuseCase.call(message: testMessage);
    expect(result, isA<MessageEntity>());
    expect(result.roomId, 'room1');
    expect(result.content, '테스트 메시지');

    final newMessages = await getRoomMessageUseCase.call(roomId: 'room1');
    expect(newMessages, isA<List<MessageEntity>>());
    expect(newMessages.length, 1);
    expect(newMessages.first.content, '테스트 메시지');
  });
}
