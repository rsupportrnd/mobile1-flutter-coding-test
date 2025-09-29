import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:mobile1_flutter_coding_test/features/chat/domain/repositories/chat_repository.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_message.dart';
import 'package:mobile1_flutter_coding_test/features/chat/presentation/controllers/chat_messages_provider.dart';

import 'chat_messages_provider_test.mocks.dart';

/// ChatMessagesController 상태 변화 테스트
@GenerateMocks([ChatRepository])
void main() {
  group('ChatMessagesController Tests', () {
    late MockChatRepository mockRepository;
    late ProviderContainer container;
    const testRoomId = 'room1';

    setUp(() {
      mockRepository = MockChatRepository();
      container = ProviderContainer(
        overrides: [
          chatRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('ChatMessagesState', () {
      test('init state, loading', () {
        // When
        final messagesAsync = container.read(chatMessagesControllerProvider(testRoomId));

        // Then
        expect(messagesAsync, isA<AsyncLoading<List<ChatMessage>>>());
      });

      test('call success, return messages for specific room only', () async {
        // Given - room1에 해당하는 메시지들만 있어야 함
        final testMessages = [
          ChatMessage(
            roomId: 'room1',
            messageId: 'msg1',
            sender: 'user1',
            content: '안녕하세요! 프로젝트 A 회의를 시작하겠습니다.',
            timestamp: DateTime.parse('2024-01-15T10:00:00Z'),
          ),
          ChatMessage(
            roomId: 'room1',
            messageId: 'msg2',
            sender: 'user2',
            content: '네, 준비되었습니다.',
            timestamp: DateTime.parse('2024-01-15T10:01:00Z'),
          ),
          ChatMessage(
            roomId: 'room1',
            messageId: 'msg3',
            sender: 'user3',
            content: '회의 자료를 공유드렸습니다.',
            timestamp: DateTime.parse('2024-01-15T10:02:00Z'),
          ),
        ];

        when(mockRepository.getMessagesForRoom(testRoomId)).thenAnswer((_) async => testMessages);

        // When
        final messagesAsync = await container.read(chatMessagesControllerProvider(testRoomId).future);

        // Then
        expect(messagesAsync, testMessages);
        expect(messagesAsync.length, 3);

        // 모든 메시지가 요청한 roomId와 일치하는지 확인
        for (final message in messagesAsync) {
          expect(message.roomId, testRoomId);
        }

        verify(mockRepository.getMessagesForRoom(testRoomId)).called(1);
      });

      test('different room, return different messages', () async {
        // Given - room2에 해당하는 메시지들
        const room2Id = 'room2';
        final room2Messages = [
          ChatMessage(
            roomId: 'room2',
            messageId: 'msg4',
            sender: 'user4',
            content: '개발 진행 상황 공유드립니다.',
            timestamp: DateTime.parse('2024-01-16T09:00:00Z'),
          ),
          ChatMessage(
            roomId: 'room2',
            messageId: 'msg5',
            sender: 'user5',
            content: '버그 수정 완료했습니다.',
            timestamp: DateTime.parse('2024-01-16T09:01:00Z'),
          ),
        ];

        when(mockRepository.getMessagesForRoom(room2Id)).thenAnswer((_) async => room2Messages);

        // When
        final messagesAsync = await container.read(chatMessagesControllerProvider(room2Id).future);

        // Then
        expect(messagesAsync, room2Messages);
        expect(messagesAsync.length, 2);

        // 모든 메시지가 room2에 해당하는지 확인
        for (final message in messagesAsync) {
          expect(message.roomId, room2Id);
        }

        verify(mockRepository.getMessagesForRoom(room2Id)).called(1);
      });

      test('empty list, return empty list', () async {
        // Given
        when(mockRepository.getMessagesForRoom(testRoomId)).thenAnswer((_) async => []);

        // When
        final messagesAsync = await container.read(chatMessagesControllerProvider(testRoomId).future);

        // Then
        expect(messagesAsync, isEmpty);
        verify(mockRepository.getMessagesForRoom(testRoomId)).called(1);
      });

      test('refresh, call success with updated messages', () async {
        // Given
        final initialMessages = [
          ChatMessage(
            roomId: 'room1',
            messageId: 'msg1',
            sender: 'user1',
            content: '초기 메시지',
            timestamp: DateTime.parse('2024-01-15T10:00:00Z'),
          ),
        ];

        final refreshedMessages = [
          ChatMessage(
            roomId: 'room1',
            messageId: 'msg1',
            sender: 'user1',
            content: '초기 메시지',
            timestamp: DateTime.parse('2024-01-15T10:00:00Z'),
          ),
          ChatMessage(
            roomId: 'room1',
            messageId: 'msg6',
            sender: 'user2',
            content: '새로운 메시지가 추가되었습니다.',
            timestamp: DateTime.parse('2024-01-15T10:05:00Z'),
          ),
        ];

        // Setup initial mock
        when(mockRepository.getMessagesForRoom(testRoomId)).thenAnswer((_) async => initialMessages);

        // When - Initial load
        final initialResult = await container.read(chatMessagesControllerProvider(testRoomId).future);
        expect(initialResult, initialMessages);

        // Reset mock for second call
        when(mockRepository.getMessagesForRoom(testRoomId)).thenAnswer((_) async => refreshedMessages);

        // When - Refresh
        await container.read(chatMessagesControllerProvider(testRoomId).notifier).refresh();
        final refreshedResult = await container.read(chatMessagesControllerProvider(testRoomId).future);

        // Then
        expect(refreshedResult, refreshedMessages);
        expect(refreshedResult.length, 2);

        // 모든 메시지가 같은 roomId인지 확인
        for (final message in refreshedResult) {
          expect(message.roomId, testRoomId);
        }

        verify(mockRepository.getMessagesForRoom(testRoomId)).called(2);
      });

      test('refresh with error, handle gracefully', () async {
        // Given
        final initialMessages = [
          ChatMessage(
            roomId: 'room1',
            messageId: 'msg1',
            sender: 'user1',
            content: '초기 메시지',
            timestamp: DateTime.parse('2024-01-15T10:00:00Z'),
          ),
        ];

        // Setup initial successful mock
        when(mockRepository.getMessagesForRoom(testRoomId)).thenAnswer((_) async => initialMessages);

        // When - Initial load
        final initialResult = await container.read(chatMessagesControllerProvider(testRoomId).future);
        expect(initialResult, initialMessages);

        // Reset mock to throw error on refresh
        when(mockRepository.getMessagesForRoom(testRoomId)).thenThrow(Exception('Refresh failed'));

        // When - Refresh with error
        await container.read(chatMessagesControllerProvider(testRoomId).notifier).refresh();
        final refreshState = container.read(chatMessagesControllerProvider(testRoomId));

        // Then
        expect(refreshState, isA<AsyncError<List<ChatMessage>>>());
        verify(mockRepository.getMessagesForRoom(testRoomId)).called(2);
      });
    });
  });
}