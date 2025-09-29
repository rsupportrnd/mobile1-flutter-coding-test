import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:mobile1_flutter_coding_test/features/chat/domain/repositories/chat_repository.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_room.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/last_message.dart';
import 'package:mobile1_flutter_coding_test/features/chat/presentation/controllers/chat_list_provider.dart';

import 'chat_list_provider_test.mocks.dart';

/// ChatListController 상태 변화 테스트
@GenerateMocks([ChatRepository])
void main() {
  group('ChatListController Tests', () {
    late MockChatRepository mockRepository;
    late ProviderContainer container;

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

    group('ChatListState', () {
      test('init state, loading', () {
        // When
        final chatRoomsAsync = container.read(chatListControllerProvider);

        // Then
        expect(chatRoomsAsync, isA<AsyncLoading<List<ChatRoom>>>());
      });

      test('call success, return chat rooms', () async {
        // Given
        final testChatRooms = [
          ChatRoom(
            roomId: 'room1',
            roomName: '프로젝트 A 회의',
            creator: 'user1',
            participants: ['user1', 'user2', 'user3'],
            createdAt: DateTime.parse('2024-01-15T10:00:00Z'),
            lastMessage: LastMessage(
              sender: 'user2',
              content: '회의 시간 확정했습니다.',
              timestamp: DateTime.parse('2024-01-15T14:30:00Z'),
            ),
            thumbnailImage: 'https://picsum.photos/200/200?random=1',
          ),
          ChatRoom(
            roomId: 'room2',
            roomName: '개발자 채팅방',
            creator: 'user4',
            participants: ['user4', 'user5'],
            createdAt: DateTime.parse('2024-01-16T09:15:00Z'),
            lastMessage: LastMessage(
              sender: 'user5',
              content: '코드 리뷰 완료했습니다!',
              timestamp: DateTime.parse('2024-01-16T16:45:00Z'),
            ),
            thumbnailImage: 'https://picsum.photos/200/200?random=2',
          ),
        ];

        when(mockRepository.getChatRooms()).thenAnswer((_) async => testChatRooms);

        // When
        final chatRoomsAsync = await container.read(chatListControllerProvider.future);

        // Then
        expect(chatRoomsAsync, testChatRooms);
        verify(mockRepository.getChatRooms()).called(1);
      });

      test('empty list, return empty list', () async {
        // Given
        when(mockRepository.getChatRooms()).thenAnswer((_) async => []);

        // When
        final chatRoomsAsync = await container.read(chatListControllerProvider.future);

        // Then
        expect(chatRoomsAsync, isEmpty);
        verify(mockRepository.getChatRooms()).called(1);
      });


      test('refresh, call success', () async {
        // Given
        final initialChatRooms = [
          ChatRoom(
            roomId: 'room1',
            roomName: '프로젝트 A 회의',
            creator: 'user1',
            participants: ['user1', 'user2'],
            createdAt: DateTime.parse('2024-01-15T10:00:00Z'),
            lastMessage: LastMessage(
              sender: 'user2',
              content: '초기 메시지',
              timestamp: DateTime.parse('2024-01-15T14:30:00Z'),
            ),
            thumbnailImage: 'https://picsum.photos/200/200?random=1',
          ),
        ];

        final refreshedChatRooms = [
          ChatRoom(
            roomId: 'room1',
            roomName: '프로젝트 A 회의',
            creator: 'user1',
            participants: ['user1', 'user2', 'user3'],
            createdAt: DateTime.parse('2024-01-15T10:00:00Z'),
            lastMessage: LastMessage(
              sender: 'user3',
              content: '새로운 메시지가 추가되었습니다.',
              timestamp: DateTime.parse('2024-01-15T15:30:00Z'),
            ),
            thumbnailImage: 'https://picsum.photos/200/200?random=1',
          ),
        ];

        // Setup initial mock
        when(mockRepository.getChatRooms()).thenAnswer((_) async => initialChatRooms);

        // When - Initial load
        final initialResult = await container.read(chatListControllerProvider.future);
        expect(initialResult, initialChatRooms);

        // Reset mock for second call
        when(mockRepository.getChatRooms()).thenAnswer((_) async => refreshedChatRooms);

        // When - Refresh
        await container.read(chatListControllerProvider.notifier).refresh();
        final refreshedResult = await container.read(chatListControllerProvider.future);

        // Then
        expect(refreshedResult, refreshedChatRooms);
        verify(mockRepository.getChatRooms()).called(2);
      });

      test('refresh with error, handle gracefully', () async {
        // Given
        final initialChatRooms = [
          ChatRoom(
            roomId: 'room1',
            roomName: '프로젝트 A 회의',
            creator: 'user1',
            participants: ['user1', 'user2'],
            createdAt: DateTime.parse('2024-01-15T10:00:00Z'),
            lastMessage: LastMessage(
              sender: 'user2',
              content: '초기 메시지',
              timestamp: DateTime.parse('2024-01-15T14:30:00Z'),
            ),
            thumbnailImage: 'https://picsum.photos/200/200?random=1',
          ),
        ];

        // Setup initial successful mock
        when(mockRepository.getChatRooms()).thenAnswer((_) async => initialChatRooms);

        // When - Initial load
        final initialResult = await container.read(chatListControllerProvider.future);
        expect(initialResult, initialChatRooms);

        // Reset mock to throw error on refresh
        when(mockRepository.getChatRooms()).thenThrow(Exception('Refresh failed'));

        // When - Refresh with error
        await container.read(chatListControllerProvider.notifier).refresh();
        final refreshState = container.read(chatListControllerProvider);

        // Then
        expect(refreshState, isA<AsyncError<List<ChatRoom>>>());
        verify(mockRepository.getChatRooms()).called(2);
      });
    });
  });
}