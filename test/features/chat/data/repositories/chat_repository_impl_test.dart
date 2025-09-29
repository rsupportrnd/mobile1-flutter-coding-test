import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/sources/chat_api_service.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_room.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_room_list_response.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/last_message.dart';

import 'chat_repository_impl_test.mocks.dart';

@GenerateMocks([ChatApiService])
void main() {
  group('ChatRepositoryImpl Tests', () {
    late ChatRepositoryImpl repository;
    late MockChatApiService mockApiService;
    late Dio mockDio;

    setUp(() {
      mockApiService = MockChatApiService();
      mockDio = Dio();
      repository = ChatRepositoryImpl(mockApiService, mockDio);
    });

    group('getChatRooms', () {
      test('success, return chat room list', () async {
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

        when(mockApiService.getChatRooms()).thenAnswer(
          (_) async => ChatRoomListResponse(chatRooms: testChatRooms),
        );

        // When
        final result = await repository.getChatRooms();

        // Then
        expect(result, testChatRooms);
        verify(mockApiService.getChatRooms()).called(1);
      });

      test('exception, throw exception', () async {
        // Given
        when(mockApiService.getChatRooms()).thenThrow(Exception('Network error'));

        // When & Then
        expect(
          () async => await repository.getChatRooms(),
          throwsA(isA<Exception>()),
        );
        verify(mockApiService.getChatRooms()).called(1);
      });

      test('empty list, return empty list', () async {
        // Given
        when(mockApiService.getChatRooms()).thenAnswer(
          (_) async => const ChatRoomListResponse(chatRooms: []),
        );

        // When
        final result = await repository.getChatRooms();

        // Then
        expect(result, isEmpty);
        verify(mockApiService.getChatRooms()).called(1);
      });
    });

    group('Integration Tests with Real API', () {
      test('fetch and parse real chat rooms api', () async {
        // Given
        final dio = Dio();
        const apiUrl = 'https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/rooms.json';

        // When
        final response = await dio.get(apiUrl);
        final jsonData = jsonDecode(response.data);
        final chatRoomListResponse = ChatRoomListResponse.fromJson(jsonData);
        final result = chatRoomListResponse.chatRooms;

        // Then
        expect(result, isNotEmpty);

        // Verify all chat rooms have valid data
        for (final room in result) {
          expect(room.roomId, isNotEmpty);
          expect(room.roomName, isNotEmpty);
          expect(room.creator, isNotEmpty);
          expect(room.participants, isNotEmpty);
          expect(room.createdAt, isA<DateTime>());
          expect(room.lastMessage, isA<LastMessage>());
          expect(room.thumbnailImage, isNotEmpty);

          // Verify lastMessage structure
          expect(room.lastMessage.sender, isNotEmpty);
          expect(room.lastMessage.content, isNotEmpty);
          expect(room.lastMessage.timestamp, isA<DateTime>());
        }
      });

      test('network error, throw exception', () async {
        // Given
        final dio = Dio();
        dio.options.connectTimeout = const Duration(milliseconds: 100);
        dio.options.receiveTimeout = const Duration(milliseconds: 100);

        // When & Then
        expect(
          () async => await dio.get('https://nonexistent-domain-that-should-fail.com/api'),
          throwsA(isA<DioException>()),
        );
      });
    });
  });
}