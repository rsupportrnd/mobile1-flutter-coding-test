import 'dart:convert';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/sources/chat_api_service.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/sources/chat_local_service.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_message.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_messages_response.dart';

import 'chat_messages_repository_test.mocks.dart';

/// 채팅 메시지 Repository 테스트
@GenerateMocks([ChatApiService, ChatLocalService])
void main() {
  group('ChatRepositoryImpl - Messages Tests', () {
    late ChatRepositoryImpl repository;
    late MockChatApiService mockApiService;
    late MockChatLocalService mockLocalService;
    late Dio mockDio;

    setUp(() {
      mockApiService = MockChatApiService();
      mockLocalService = MockChatLocalService();
      mockDio = Dio();
      repository = ChatRepositoryImpl(mockApiService, mockLocalService, mockDio);
    });

    group('getMessagesForRoom', () {
      test('success, return messages for specific room only', () async {
        // Given - 전체 메시지 목록 (여러 방의 메시지 포함)
        final allMessages = [
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
            roomId: 'room2',
            messageId: 'msg3',
            sender: 'user4',
            content: '개발 진행 상황 공유드립니다.',
            timestamp: DateTime.parse('2024-01-16T09:00:00Z'),
          ),
          ChatMessage(
            roomId: 'room1',
            messageId: 'msg4',
            sender: 'user3',
            content: '회의 자료를 공유드렸습니다.',
            timestamp: DateTime.parse('2024-01-15T10:02:00Z'),
          ),
          ChatMessage(
            roomId: 'room3',
            messageId: 'msg5',
            sender: 'user6',
            content: '디자인 피드백 반영했습니다.',
            timestamp: DateTime.parse('2024-01-17T14:00:00Z'),
          ),
        ];

        // 로컬 DB 조회 결과 설정 (빈 결과로 설정)
        when(mockLocalService.getMessagesForRoom('room1'))
            .thenAnswer((_) async => []);
        when(mockLocalService.convertToModelList([]))
            .thenReturn([]);
        when(mockApiService.getMessages()).thenAnswer(
          (_) async => ChatMessagesResponse(messages: allMessages),
        );
        when(mockLocalService.insertMessages(any))
            .thenAnswer((_) async {});

        // When - room1의 메시지만 요청
        final result = await repository.getMessagesForRoom('room1');

        // Then
        expect(result.length, 3); // room1 메시지만 3개여야 함

        // 모든 반환된 메시지가 room1에 속하는지 확인
        for (final message in result) {
          expect(message.roomId, 'room1');
        }

        // 메시지 ID로 정확한 메시지가 반환되었는지 확인
        final messageIds = result.map((m) => m.messageId).toList();
        expect(messageIds, containsAll(['msg1', 'msg2', 'msg4']));
        expect(messageIds, isNot(contains('msg3'))); // room2 메시지는 포함되지 않아야 함
        expect(messageIds, isNot(contains('msg5'))); // room3 메시지는 포함되지 않아야 함

        verify(mockApiService.getMessages()).called(1);
      });

      test('different room, return different messages', () async {
        // Given
        final allMessages = [
          ChatMessage(
            roomId: 'room1',
            messageId: 'msg1',
            sender: 'user1',
            content: '프로젝트 A 메시지',
            timestamp: DateTime.parse('2024-01-15T10:00:00Z'),
          ),
          ChatMessage(
            roomId: 'room2',
            messageId: 'msg2',
            sender: 'user4',
            content: '개발팀 메시지',
            timestamp: DateTime.parse('2024-01-16T09:00:00Z'),
          ),
          ChatMessage(
            roomId: 'room2',
            messageId: 'msg3',
            sender: 'user5',
            content: '버그 수정 완료',
            timestamp: DateTime.parse('2024-01-16T09:01:00Z'),
          ),
        ];

        // 로컬 DB 조회 결과 설정
        when(mockLocalService.getMessagesForRoom('room2'))
            .thenAnswer((_) async => []);
        when(mockLocalService.convertToModelList([]))
            .thenReturn([]);
        when(mockApiService.getMessages()).thenAnswer(
          (_) async => ChatMessagesResponse(messages: allMessages),
        );
        when(mockLocalService.insertMessages(any))
            .thenAnswer((_) async {});

        // When - room2의 메시지만 요청
        final result = await repository.getMessagesForRoom('room2');

        // Then
        expect(result.length, 2); // room2 메시지만 2개여야 함

        // 모든 반환된 메시지가 room2에 속하는지 확인
        for (final message in result) {
          expect(message.roomId, 'room2');
        }

        final messageIds = result.map((m) => m.messageId).toList();
        expect(messageIds, containsAll(['msg2', 'msg3']));
        expect(messageIds, isNot(contains('msg1'))); // room1 메시지는 포함되지 않아야 함

        verify(mockApiService.getMessages()).called(1);
      });

      test('room not exists, return empty list', () async {
        // Given
        final allMessages = [
          ChatMessage(
            roomId: 'room1',
            messageId: 'msg1',
            sender: 'user1',
            content: '메시지',
            timestamp: DateTime.parse('2024-01-15T10:00:00Z'),
          ),
        ];

        // 로컬 DB 조회 결과 설정
        when(mockLocalService.getMessagesForRoom('nonexistent_room'))
            .thenAnswer((_) async => []);
        when(mockLocalService.convertToModelList([]))
            .thenReturn([]);
        when(mockApiService.getMessages()).thenAnswer(
          (_) async => ChatMessagesResponse(messages: allMessages),
        );
        when(mockLocalService.insertMessages(any))
            .thenAnswer((_) async {});

        // When - 존재하지 않는 방의 메시지 요청
        final result = await repository.getMessagesForRoom('nonexistent_room');

        // Then
        expect(result, isEmpty);
        verify(mockApiService.getMessages()).called(1);
      });

      test('exception, throw exception', () async {
        // Given
        when(mockLocalService.getMessagesForRoom('room1'))
            .thenAnswer((_) async => []);
        when(mockLocalService.convertToModelList([]))
            .thenReturn([]);
        when(mockApiService.getMessages()).thenThrow(Exception('Network error'));

        // When & Then
        expect(
          () async => await repository.getMessagesForRoom('room1'),
          throwsA(isA<Exception>()),
        );
        verify(mockApiService.getMessages()).called(1);
      });

      test('empty messages list, return empty list', () async {
        // Given
        when(mockLocalService.getMessagesForRoom('room1'))
            .thenAnswer((_) async => []);
        when(mockLocalService.convertToModelList([]))
            .thenReturn([]);
        when(mockApiService.getMessages()).thenAnswer(
          (_) async => const ChatMessagesResponse(messages: []),
        );
        when(mockLocalService.insertMessages(any))
            .thenAnswer((_) async {});

        // When
        final result = await repository.getMessagesForRoom('room1');

        // Then
        expect(result, isEmpty);
        verify(mockApiService.getMessages()).called(1);
      });
    });

    group('Integration Tests with Real API', () {
      test('fetch and parse real messages api, filter by room', () async {
        // Given
        final dio = Dio();
        const apiUrl = 'https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/messages.json';

        // When
        final response = await dio.get(apiUrl);
        final jsonData = jsonDecode(response.data);
        final chatMessagesResponse = ChatMessagesResponse.fromJson(jsonData);
        final allMessages = chatMessagesResponse.messages;

        // Then
        expect(allMessages, isNotEmpty);

        // 각 방별로 메시지가 올바르게 필터링되는지 확인
        final room1Messages = allMessages.where((m) => m.roomId == 'room1').toList();
        final room2Messages = allMessages.where((m) => m.roomId == 'room2').toList();
        final room3Messages = allMessages.where((m) => m.roomId == 'room3').toList();

        // 각 방에 메시지가 있는지 확인
        expect(room1Messages, isNotEmpty);
        expect(room2Messages, isNotEmpty);
        expect(room3Messages, isNotEmpty);

        // 각 방의 모든 메시지가 해당 방에만 속하는지 확인
        for (final message in room1Messages) {
          expect(message.roomId, 'room1');
          expect(message.messageId, isNotEmpty);
          expect(message.sender, isNotEmpty);
          expect(message.content, isNotEmpty);
          expect(message.timestamp, isA<DateTime>());
        }

        for (final message in room2Messages) {
          expect(message.roomId, 'room2');
        }

        for (final message in room3Messages) {
          expect(message.roomId, 'room3');
        }

        // 전체 메시지 수가 각 방의 메시지 합과 같은지 확인
        final totalByRooms = room1Messages.length + room2Messages.length + room3Messages.length;
        expect(allMessages.length, totalByRooms);
      });
    });
  });
}