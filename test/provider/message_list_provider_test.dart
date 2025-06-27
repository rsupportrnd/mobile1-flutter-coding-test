import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/message/provider/message_list_provider.dart';
import 'package:mocktail/mocktail.dart';

class _MockMessageUseCase extends Mock implements MessageUseCase {}

void main() {
  group('MessageListProvider', () {
    late ProviderContainer container;
    late _MockMessageUseCase mockUseCase;
    const String roomId = 'room1';

    setUp(() {
      mockUseCase = _MockMessageUseCase();
      container = ProviderContainer(overrides: [
        messageUseCaseProvider.overrideWithValue(mockUseCase),
      ]);
    });

    tearDown(() => container.dispose());

    test('build merges local and remote messages', () async {
      final MessageEntity remote1 = MessageEntity(
        roomId: roomId,
        messageId: 'r1',
        sender: 'a',
        content: 'c1',
        timestamp: DateTime(2025, 1, 1),
      );
      final MessageEntity remote2 = MessageEntity(
        roomId: roomId,
        messageId: 'r2',
        sender: 'b',
        content: 'c2',
        timestamp: DateTime(2025, 1, 2),
      );
      final MessageEntity local2 = MessageEntity(
        roomId: roomId,
        messageId: 'r2',
        sender: 'b',
        content: 'c2-local',
        timestamp: DateTime(2025, 1, 3),
      );
      final MessageEntity local3 = MessageEntity(
        roomId: roomId,
        messageId: 'l3',
        sender: 'c',
        content: 'c3',
        timestamp: DateTime(2025, 1, 4),
      );

      when(() => mockUseCase.getLocalMessages(roomId: roomId))
          .thenAnswer((_) async => <MessageEntity>[local2, local3]);
      when(() => mockUseCase.getMessageList()).thenAnswer(
        (_) async => MessageListResponseEntity(messages: [remote1, remote2]),
      );
      when(() => mockUseCase.saveMessages(
            roomId: roomId,
            messages: any(named: 'messages'),
          )).thenAnswer((_) async {});

      final List<MessageEntity> result =
          await container.read(messageListProvider(roomId).future);

      expect(result.length, 3);
      expect(result[0], local3);
      expect(result[1], local2);
      expect(result[2], remote1);
      verify(() => mockUseCase.getLocalMessages(roomId: roomId)).called(1);
      verify(() => mockUseCase.getMessageList()).called(1);
      verify(() => mockUseCase.saveMessages(roomId: roomId, messages: result))
          .called(1);
    });

    test('sendMessage adds message and saves', () async {
      when(() => mockUseCase.getLocalMessages(roomId: roomId))
          .thenAnswer((_) async => <MessageEntity>[]);
      when(() => mockUseCase.getMessageList()).thenAnswer(
          (_) async => const MessageListResponseEntity(messages: []));
      when(() => mockUseCase.saveMessages(
            roomId: roomId,
            messages: any(named: 'messages'),
          )).thenAnswer((_) async {});

      await container.read(messageListProvider(roomId).future);

      final MessageEntity newMessage = await container
          .read(messageListProvider(roomId).notifier)
          .sendMessage(sender: 'me', content: 'hello');

      final List<MessageEntity>? messages =
          container.read(messageListProvider(roomId)).value;

      expect(messages, isNotNull);
      expect(messages!.contains(newMessage), isTrue);
      verify(() => mockUseCase.saveMessages(
            roomId: roomId,
            messages: any(named: 'messages'),
          )).called(2);
    });
  });
}
