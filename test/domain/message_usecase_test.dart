import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/data/data.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

class _MockMessageRepository extends Mock implements MessageRepository {}

void main() {
  late ProviderContainer container;
  late _MockMessageRepository mockRepo;

  setUp(() {
    mockRepo = _MockMessageRepository();
    container = ProviderContainer(overrides: [
      messageRepositoryProvider.overrideWithValue(mockRepo),
    ]);
  });

  tearDown(() => container.dispose());

  group('MessageUseCase', () {
    test('getMessageList returns data on success', () async {
      const MessageListResponseEntity dummyEntity = MessageListResponseEntity(messages: []);
      when(() => mockRepo.getRemoteMessageList()).thenAnswer((_) async => dummyEntity);

      final MessageUseCase useCase = container.read(messageUseCaseProvider);
      final MessageListResponseEntity result = await useCase.getMessageList();

      expect(result, dummyEntity);
      verify(() => mockRepo.getRemoteMessageList()).called(1);
    });

    test('getMessageList throws when repository fails', () async {
      final Exception exception = Exception('Repo error');
      when(() => mockRepo.getRemoteMessageList()).thenThrow(exception);

      final MessageUseCase useCase = container.read(messageUseCaseProvider);

      expect(
        () => useCase.getMessageList(),
        throwsA(same(exception)),
      );
      verify(() => mockRepo.getRemoteMessageList()).called(1);
    });

    test('getLocalMessages returns messages from repository', () async {
      const String roomId = 'room_1';
      const List<MessageEntity> expected = <MessageEntity>[];
      when(() => mockRepo.getLocalMessageList(roomId: roomId)).thenAnswer((_) async => expected);

      final MessageUseCase useCase = container.read(messageUseCaseProvider);
      final List<MessageEntity> result = await useCase.getLocalMessages(roomId: roomId);

      expect(result, expected);
      verify(() => mockRepo.getLocalMessageList(roomId: roomId)).called(1);
    });

    test('getLocalMessages throws when repository fails', () async {
      const String roomId = 'room_1';
      final Exception exception = Exception('Repo error');
      when(() => mockRepo.getLocalMessageList(roomId: roomId)).thenThrow(exception);

      final MessageUseCase useCase = container.read(messageUseCaseProvider);

      expect(
        () => useCase.getLocalMessages(roomId: roomId),
        throwsA(same(exception)),
      );
      verify(() => mockRepo.getLocalMessageList(roomId: roomId)).called(1);
    });

    test('saveMessages delegates to repository', () async {
      const String roomId = 'room_1';
      const List<MessageEntity> messages = <MessageEntity>[];
      when(() => mockRepo.saveMessages(roomId: roomId, messages: messages))
          .thenAnswer((_) async {});

      final MessageUseCase useCase = container.read(messageUseCaseProvider);
      await useCase.saveMessages(roomId: roomId, messages: messages);

      verify(() => mockRepo.saveMessages(roomId: roomId, messages: messages)).called(1);
    });

    test('saveMessages throws when repository fails', () async {
      const String roomId = 'room_1';
      const List<MessageEntity> messages = <MessageEntity>[];
      final Exception exception = Exception('Repo error');
      when(() => mockRepo.saveMessages(roomId: roomId, messages: messages)).thenThrow(exception);

      final MessageUseCase useCase = container.read(messageUseCaseProvider);

      expect(
        () => useCase.saveMessages(roomId: roomId, messages: messages),
        throwsA(same(exception)),
      );
      verify(() => mockRepo.saveMessages(roomId: roomId, messages: messages)).called(1);
    });
  });
}
