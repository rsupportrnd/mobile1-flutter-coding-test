import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/message_repository.dart';
import 'package:get_it/get_it.dart';
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
  setUp(() {
    GetIt.I.registerSingleton<MessageRepository>(FakeMessageRepository());
    GetIt.I.registerSingleton<PostRoomMessageUseCase>(
        PostRoomMessageUseCase(GetIt.I<MessageRepository>()));
  });

  tearDown(() {
    GetIt.I.reset();
  });

  test('PostMessageUseCase', () async {
    final useCase = GetIt.I<PostRoomMessageUseCase>();

    final testMessage = MessageEntity(
      roomId: 'room1',
      messageId: 'msg100',
      sender: 'user1',
      content: '테스트 메시지',
      timestamp: DateTime(2024, 1, 1, 13, 0, 0),
    );

    final result = await useCase.call(message: testMessage);

    expect(result, isA<MessageEntity>());
    expect(result.roomId, 'room1');
    expect(result.content, '테스트 메시지');

    final repository = GetIt.I<MessageRepository>() as FakeMessageRepository;
    final messages = await repository.getMessages();
    expect(messages.length, 1);
    expect(messages.first.messageId, 'msg100');
  });
}
