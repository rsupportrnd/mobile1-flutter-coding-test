import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rsupport/data_sources/remote_data_source.dart';
import 'package:rsupport/models/user.dart';
import 'package:rsupport/models/room.dart';
import 'package:rsupport/models/message.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('원격 데이터 소스 테스트', () {
    late MockHttpClient mockHttpClient;
    late UserRemoteDataSourceImpl userDataSource;

    setUp(() {
      mockHttpClient = MockHttpClient();
      userDataSource = UserRemoteDataSourceImpl(client: mockHttpClient);
    });

    group('UserRemoteDataSource 기본 테스트', () {
      test('HTTP 클라이언트 생성 테스트', () {
        // Given & When
        final dataSource = UserRemoteDataSourceImpl();
        
        // Then
        expect(dataSource, isNotNull);
      });

      test('모킹된 HTTP 응답 처리 테스트', () async {
        // Given
        final mockData = {
          'users': [
            {
              'id': 'test_user',
              'name': 'Test User',
              'email': 'test@example.com',
              'profilePicture': null,
              'status': 'online',
              'role': 'user',
            }
          ]
        };

        // 구체적인 URL로 모킹
        when(() => mockHttpClient.get(
          Uri.parse('https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/users.json')
        )).thenAnswer((_) async => http.Response(json.encode(mockData), 200));

        // When
        final users = await userDataSource.fetchUsers();

        // Then
        expect(users.length, 1);
        expect(users[0].name, 'Test User');
        expect(users[0].isOnline, true);
      });

      test('HTTP 오류 응답 처리 테스트', () async {
        // Given
        when(() => mockHttpClient.get(
          Uri.parse('https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/users.json')
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        // When & Then
        expect(
          () => userDataSource.fetchUsers(),
          throwsA(isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('서버 응답 오류'),
          )),
        );
      });
    });

    group('RoomRemoteDataSource 기본 테스트', () {
      late RoomRemoteDataSourceImpl roomDataSource;

      setUp(() {
        roomDataSource = RoomRemoteDataSourceImpl(client: mockHttpClient);
      });

      test('회의실 목록 조회 기본 테스트', () async {
        // Given
        final mockData = {
          'chatRooms': [
            {
              'id': 'test_room',
              'name': 'Test Room',
              'description': 'Test Description',
              'creator': 'test_user',
              'participants': ['user1', 'user2'],
              'createdAt': null,
              'lastMessage': null,
              'thumbnailImage': null,
            }
          ]
        };

        when(() => mockHttpClient.get(
          Uri.parse('https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/rooms.json')
        )).thenAnswer((_) async => http.Response(json.encode(mockData), 200));

        // When
        final List<Room> rooms = await roomDataSource.fetchRooms();

        // Then
        expect(rooms.length, 1);
        final Room firstRoom = rooms[0];
        expect(firstRoom.name, 'Test Room');
        expect(firstRoom.participantCount, 2);
      });
    });

    group('MessageRemoteDataSource 기본 테스트', () {
      late MessageRemoteDataSourceImpl messageDataSource;

      setUp(() {
        messageDataSource = MessageRemoteDataSourceImpl(client: mockHttpClient);
      });

      test('메시지 전송 성공 테스트', () async {
        // Given
        final message = Message(
          id: 'test_msg',
          roomId: 'test_room',
          userId: 'test_user',
          userName: 'Test User',
          content: 'Hello World',
          timestamp: DateTime.now(),
        );

        when(() => mockHttpClient.post(
          Uri.parse('https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/messages.json'),
          headers: {'Content-Type': 'application/json'},
          body: any(named: 'body'),
        )).thenAnswer((_) async => http.Response('{"status": "success"}', 200));

        // When & Then (예외가 발생하지 않으면 성공)
        await expectLater(
          messageDataSource.sendMessage(message),
          completes,
        );
      });
    });
  });
} 