import 'package:test/test.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/sources/chat_local_service.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_message.dart';

void main() {
  group('ChatLocalService Tests', () {
    late ChatLocalService service;

    setUp(() {
      // 메모리 데이터베이스를 사용하여 테스트
      service = ChatLocalService.memory();
    });

    tearDown(() async {
      // 테스트 후 정리
      await service.close();
    });

    group('generateNextMessageId', () {
      test('no existing messages, return msg1', () async {
        // When
        final result = await service.generateNextMessageId();

        // Then
        expect(result, 'msg1');
      });

      test('existing messages with numeric IDs, return incremented ID', () async {
        // Given - 기존 메시지들 추가
        final existingMessages = [
          ChatMessage(
            roomId: 'room1',
            messageId: 'msg1',
            sender: 'user1',
            content: 'First message',
            timestamp: DateTime.now(),
          ),
          ChatMessage(
            roomId: 'room2',
            messageId: 'msg5',
            sender: 'user2',
            content: 'Fifth message',
            timestamp: DateTime.now(),
          ),
          ChatMessage(
            roomId: 'room1',
            messageId: 'msg3',
            sender: 'user3',
            content: 'Third message',
            timestamp: DateTime.now(),
          ),
        ];

        for (final message in existingMessages) {
          await service.insertMessage(message);
        }

        // When
        final result = await service.generateNextMessageId();

        // Then - 가장 큰 ID(5) + 1 = 6
        expect(result, 'msg6');
      });

      test('mixed ID formats, return incremented from highest numeric ID', () async {
        // Given - 다양한 형태의 메시지 ID들
        final existingMessages = [
          ChatMessage(
            roomId: 'room1',
            messageId: 'msg10',
            sender: 'user1',
            content: 'Message',
            timestamp: DateTime.now(),
          ),
          ChatMessage(
            roomId: 'room1',
            messageId: 'custom-id',
            sender: 'user2',
            content: 'Message',
            timestamp: DateTime.now(),
          ),
          ChatMessage(
            roomId: 'room1',
            messageId: 'msg2',
            sender: 'user3',
            content: 'Message',
            timestamp: DateTime.now(),
          ),
        ];

        for (final message in existingMessages) {
          await service.insertMessage(message);
        }

        // When
        final result = await service.generateNextMessageId();

        // Then - 숫자 형태 ID 중 가장 큰 값(10) + 1 = 11
        expect(result, 'msg11');
      });
    });

    group('insertUserMessage', () {
      test('success, save message with auto-generated ID', () async {
        // When
        final result = await service.insertUserMessage(
          roomId: 'test_room',
          sender: 'test_user',
          content: 'Hello, World!',
        );

        // Then
        expect(result.roomId, 'test_room');
        expect(result.sender, 'test_user');
        expect(result.content, 'Hello, World!');
        expect(result.messageId, 'msg1'); // 첫 번째 메시지이므로 msg1
        expect(result.timestamp, isA<DateTime>());

        // 실제로 DB에 저장되었는지 확인
        final messages = await service.getMessagesForRoom('test_room');
        expect(messages.length, 1);
        expect(messages.first.messageId, 'msg1');
      });

      test('multiple messages, verify auto-increment ID generation', () async {
        // When - 여러 메시지 순차적으로 저장
        final message1 = await service.insertUserMessage(
          roomId: 'room1',
          sender: 'user1',
          content: 'First message',
        );

        final message2 = await service.insertUserMessage(
          roomId: 'room2',
          sender: 'user2',
          content: 'Second message',
        );

        final message3 = await service.insertUserMessage(
          roomId: 'room1',
          sender: 'user1',
          content: 'Third message',
        );

        // Then
        expect(message1.messageId, 'msg1');
        expect(message2.messageId, 'msg2');
        expect(message3.messageId, 'msg3');

        // 각 방에 메시지가 정확히 저장되었는지 확인
        final room1Messages = await service.getMessagesForRoom('room1');
        final room2Messages = await service.getMessagesForRoom('room2');

        expect(room1Messages.length, 2);
        expect(room2Messages.length, 1);
      });

      test('verify function execution without actual DB validation', () async {
        // Given
        const roomId = 'mock_room';
        const sender = 'mock_user';
        const content = 'Mock message';

        // When - 함수가 실행되는지만 확인
        final result = await service.insertUserMessage(
          roomId: roomId,
          sender: sender,
          content: content,
        );

        // Then - 함수가 ChatMessage 객체를 반환하는지만 확인
        expect(result, isA<ChatMessage>());
        expect(result.roomId, roomId);
        expect(result.sender, sender);
        expect(result.content, content);
        expect(result.messageId, isNotNull);
        expect(result.timestamp, isA<DateTime>());
      });
    });
  });
}