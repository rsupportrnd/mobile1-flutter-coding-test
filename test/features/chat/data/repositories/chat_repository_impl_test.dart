import 'dart:convert';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/sources/chat_api_service.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/sources/chat_local_service.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_room.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_room_list_response.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_message.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_messages_response.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/last_message.dart';

import 'chat_repository_impl_test.mocks.dart';

@GenerateMocks([ChatApiService, ChatLocalService])
void main() {
  group('ChatRepositoryImpl Tests', () {
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

    group('getMessagesForRoom', () {
      test('merge local and API messages with API priority', () async {
        // Given
        const roomId = 'room1';
        final baseTime = DateTime.now();

        final localMessages = [
          ChatMessage(
            roomId: roomId,
            messageId: 'msg1',
            sender: 'user1',
            content: 'Local message 1',
            timestamp: baseTime.subtract(Duration(minutes: 2)),
          ),
          ChatMessage(
            roomId: roomId,
            messageId: 'msg2',
            sender: 'user2',
            content: 'Local message 2',
            timestamp: baseTime.subtract(Duration(minutes: 1)),
          ),
        ];

        final allApiMessages = [
          ChatMessage(
            roomId: roomId,
            messageId: 'msg1', // 중복 - API 우선
            sender: 'user1',
            content: 'Updated API message 1',
            timestamp: baseTime.subtract(Duration(minutes: 2)),
          ),
          ChatMessage(
            roomId: roomId,
            messageId: 'msg3', // 새로운 메시지
            sender: 'user3',
            content: 'New API message 3',
            timestamp: baseTime,
          ),
          ChatMessage(
            roomId: 'room2', // 다른 방 메시지 - 필터링됨
            messageId: 'msg4',
            sender: 'user4',
            content: 'Other room message',
            timestamp: baseTime,
          ),
        ];

        final apiResponse = ChatMessagesResponse(messages: allApiMessages);

        when(mockLocalService.getMessagesForRoom(roomId))
            .thenAnswer((_) async => []);
        when(mockLocalService.convertToModelList(any))
            .thenReturn(localMessages);
        when(mockApiService.getMessages())
            .thenAnswer((_) async => apiResponse);
        when(mockLocalService.insertMessages(any))
            .thenAnswer((_) async {});

        // When
        final result = await repository.getMessagesForRoom(roomId);

        // Then
        // API 메시지가 우선되어야 함 (msg1의 content가 'Updated API message 1')
        expect(result.length, 3);

        // 최신 순으로 정렬되어야 함
        expect(result[0].messageId, 'msg3'); // 가장 최근
        expect(result[1].messageId, 'msg2'); // 로컬만 있는 메시지
        expect(result[2].messageId, 'msg1'); // API로 업데이트된 메시지
        expect(result[2].content, 'Updated API message 1'); // API 내용이 우선

        verify(mockLocalService.getMessagesForRoom(roomId)).called(1);
        verify(mockApiService.getMessages()).called(1);
        verify(mockLocalService.insertMessages(any)).called(1);
      });

      test('only API messages, save all to local', () async {
        // Given
        const roomId = 'room1';
        final apiMessages = [
          ChatMessage(
            roomId: roomId,
            messageId: 'msg1',
            sender: 'user1',
            content: 'API message',
            timestamp: DateTime.now(),
          ),
        ];
        final apiResponse = ChatMessagesResponse(messages: apiMessages);

        when(mockLocalService.getMessagesForRoom(roomId))
            .thenAnswer((_) async => []);
        when(mockLocalService.convertToModelList([]))
            .thenReturn([]);
        when(mockApiService.getMessages())
            .thenAnswer((_) async => apiResponse);
        when(mockLocalService.insertMessages(any))
            .thenAnswer((_) async {});

        // When
        final result = await repository.getMessagesForRoom(roomId);

        // Then
        expect(result, apiMessages);
        verify(mockLocalService.getMessagesForRoom(roomId)).called(1);
        verify(mockApiService.getMessages()).called(1);
        verify(mockLocalService.insertMessages(apiMessages)).called(1); // 모든 API 메시지 저장
      });

      test('API fails, throw exception when no local data', () async {
        // Given
        const roomId = 'room1';

        when(mockLocalService.getMessagesForRoom(roomId))
            .thenAnswer((_) async => []);
        when(mockLocalService.convertToModelList([]))
            .thenReturn([]);
        when(mockApiService.getMessages())
            .thenThrow(Exception('Network error'));

        // When & Then - API 실패하고 로컬에도 데이터가 없으면 예외 발생
        expect(
          () async => await repository.getMessagesForRoom(roomId),
          throwsA(isA<Exception>()),
        );
      });

      test('insert only new API messages to local DB', () async {
        // Given
        const roomId = 'room1';
        final baseTime = DateTime.now();

        final localMessages = [
          ChatMessage(
            roomId: roomId,
            messageId: 'msg1',
            sender: 'user1',
            content: 'Existing local message',
            timestamp: baseTime.subtract(Duration(minutes: 1)),
          ),
        ];

        final allApiMessages = [
          ChatMessage(
            roomId: roomId,
            messageId: 'msg1', // 이미 로컬에 있음 - 저장하지 않음
            sender: 'user1',
            content: 'Updated from API',
            timestamp: baseTime.subtract(Duration(minutes: 1)),
          ),
          ChatMessage(
            roomId: roomId,
            messageId: 'msg2', // 새로운 메시지 - 저장해야 함
            sender: 'user2',
            content: 'New API message',
            timestamp: baseTime,
          ),
          ChatMessage(
            roomId: 'room2', // 다른 방 메시지 - 필터링됨
            messageId: 'msg3',
            sender: 'user3',
            content: 'Other room message',
            timestamp: baseTime,
          ),
        ];

        final apiResponse = ChatMessagesResponse(messages: allApiMessages);

        when(mockLocalService.getMessagesForRoom(roomId))
            .thenAnswer((_) async => []);
        when(mockLocalService.convertToModelList(any))
            .thenReturn(localMessages);
        when(mockApiService.getMessages())
            .thenAnswer((_) async => apiResponse);
        when(mockLocalService.insertMessages(any))
            .thenAnswer((_) async {});

        // When
        final result = await repository.getMessagesForRoom(roomId);

        // Then
        expect(result.length, 2);
        expect(result[0].messageId, 'msg2'); // 새로운 메시지가 최신
        expect(result[1].messageId, 'msg1');
        expect(result[1].content, 'Updated from API'); // API 내용으로 업데이트

        // 새로운 메시지(msg2)만 저장되어야 함
        verify(mockLocalService.insertMessages(argThat(predicate<List<ChatMessage>>((messages) {
          return messages.length == 1 && messages[0].messageId == 'msg2';
        })))).called(1);
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

    group('sendMessage', () {
      test('success, save message to local DB with auto-generated ID', () async {
        // Given
        const roomId = 'room1';
        const sender = 'user1';
        const content = 'Test message';

        final expectedMessage = ChatMessage(
          roomId: roomId,
          messageId: 'msg123', // 예상되는 자동 생성 ID
          sender: sender,
          content: content,
          timestamp: DateTime.now(),
        );

        when(mockLocalService.insertUserMessage(
          roomId: roomId,
          sender: sender,
          content: content,
        )).thenAnswer((_) async => expectedMessage);

        // When
        final result = await repository.sendMessage(
          roomId: roomId,
          sender: sender,
          content: content,
        );

        // Then
        expect(result.roomId, roomId);
        expect(result.sender, sender);
        expect(result.content, content);
        expect(result.messageId, isNotEmpty);

        verify(mockLocalService.insertUserMessage(
          roomId: roomId,
          sender: sender,
          content: content,
        )).called(1);
      });

      test('local service fails, throw exception', () async {
        // Given
        const roomId = 'room1';
        const sender = 'user1';
        const content = 'Test message';

        when(mockLocalService.insertUserMessage(
          roomId: roomId,
          sender: sender,
          content: content,
        )).thenThrow(Exception('Local DB error'));

        // When & Then
        expect(
          () async => await repository.sendMessage(
            roomId: roomId,
            sender: sender,
            content: content,
          ),
          throwsA(isA<Exception>()),
        );

        verify(mockLocalService.insertUserMessage(
          roomId: roomId,
          sender: sender,
          content: content,
        )).called(1);
      });

      test('verify insertUserMessage called with correct parameters', () async {
        // Given
        const roomId = 'test_room';
        const sender = 'test_user';
        const content = 'Hello, World!';

        final mockMessage = ChatMessage(
          roomId: roomId,
          messageId: 'auto_generated_id',
          sender: sender,
          content: content,
          timestamp: DateTime.now(),
        );

        when(mockLocalService.insertUserMessage(
          roomId: anyNamed('roomId'),
          sender: anyNamed('sender'),
          content: anyNamed('content'),
        )).thenAnswer((_) async => mockMessage);

        // When
        await repository.sendMessage(
          roomId: roomId,
          sender: sender,
          content: content,
        );

        // Then - 정확한 파라미터로 호출되었는지만 확인
        verify(mockLocalService.insertUserMessage(
          roomId: roomId,
          sender: sender,
          content: content,
        )).called(1);
      });
    });
  });
}