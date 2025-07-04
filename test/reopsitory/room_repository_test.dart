import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/room_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/model/response.dart';
import 'package:mobile1_flutter_coding_test/data/model/room_model.dart';
import 'package:mobile1_flutter_coding_test/data/repository/room_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/room.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/local_database_datasource.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';

// mock 클래스 생성
class MockRoomDataSource extends Mock implements RoomDataSource {}

class MockLocalDatabaseDataSource extends Mock
    implements LocalDatabaseDataSource {}

void main() {
  late MockRoomDataSource mockRoomDataSource;
  late MockLocalDatabaseDataSource mockLocalDatabaseDataSource;
  late RoomRepositoryImpl repository;

  // 각 테스트 실행 직전 실행
  setUp(() {
    mockRoomDataSource = MockRoomDataSource();
    mockLocalDatabaseDataSource = MockLocalDatabaseDataSource();
    repository = RoomRepositoryImpl(
      dataSource: mockRoomDataSource,
      localDatabaseDataSource: mockLocalDatabaseDataSource,
    );
  });

  final sampleRoomModel = ChatRoomModel(
      roomId: 'room1',
      roomName: 'roomName',
      creator: 'user1',
      participants: ['user1', 'user2', 'user3'],
      createdAt: DateTime.now().toIso8601String(),
      lastMessage: LastMessageModel(
          sender: "user3",
          content: "content3",
          timestamp: DateTime.now().toIso8601String()),
      thumbnailImage: 'url');

  final sampleRoomEntity = ChatRoom(
      roomId: 'room1',
      roomName: 'roomName',
      creator: 'user1',
      participants: ['user1', 'user2', 'user3'],
      createdAt: DateTime.now().toIso8601String(),
      lastMessage: LastMessage(
          sender: "user3",
          content: "content3",
          timestamp: DateTime.now().toIso8601String()),
      thumbnailImage: 'url');

  group('getRooms', () {
    test('성공 시 회의실 리스트 반환하고 insertRooms 호출', () async {
      when(() => mockRoomDataSource.getRooms()).thenAnswer(
          (_) async => ChatRoomResponse(chatRooms: [sampleRoomModel]));
      when(() => mockLocalDatabaseDataSource.insertRooms(
          rooms: any(named: 'rooms'))).thenAnswer((_) async => Future.value());

      final result = await repository.getRooms();

      switch (result) {
        case Success(:final data):
          expect(data, isNotEmpty); // 리스트가 비어있지 않은지 검사
        case Failure(:final error):
          fail('Result is failure: $error');
      }
      verify(() => mockRoomDataSource.getRooms()).called(1);
      verify(() => mockLocalDatabaseDataSource.insertRooms(
              rooms: any(named: 'rooms')))
          .called(1); // any: insertRooms 메서드의 rooms 파라미터는 패스
    });

    test('실패 시 Result 실패 반환', () async {
      when(() => mockRoomDataSource.getRooms())
          .thenThrow(const UnKnownException('fail'));

      final result = await repository.getRooms();

      expect(result, isA<Failure>());
      verify(() => mockRoomDataSource.getRooms()).called(1);
    });
  });

  group('selectRooms', () {
    test('성공 시 DB 회의실 리스트 반환', () async {
      when(() => mockLocalDatabaseDataSource.selectRooms())
          .thenAnswer((_) async => [sampleRoomModel]);

      final result = await repository.selectRooms();

      switch (result) {
        case Success(:final data):
          expect(data, isNotEmpty); // 리스트가 비어있지 않은지 검사
        case Failure(:final error):
          fail('Result is failure: $error');
      }
      verify(() => mockLocalDatabaseDataSource.selectRooms()).called(1);
    });
  });

  group('insertRooms', () {
    test('성공 시 여러 회의실 저장', () async {
      when(() => mockLocalDatabaseDataSource.insertRooms(
          rooms: any(named: 'rooms'))).thenAnswer((_) async => Future.value());

      final rooms = [sampleRoomEntity, sampleRoomEntity];

      final result = await repository.insertRooms(rooms: rooms);

      expect(result, isA<Success>());
      verify(() => mockLocalDatabaseDataSource.insertRooms(
          rooms: any(named: 'rooms'))).called(1);
    });
  });
}
