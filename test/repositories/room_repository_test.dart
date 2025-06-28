import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rsupport/models/room.dart';
import 'package:rsupport/repositories/room_repository.dart';

class MockRoomRemoteDataSource extends Mock implements RoomRemoteDataSource {}
class MockRoomLocalDataSource extends Mock implements RoomLocalDataSource {}

void main() {
  group('RoomRepository 테스트', () {
    late MockRoomRemoteDataSource mockRemoteDataSource;
    late MockRoomLocalDataSource mockLocalDataSource;
    late RoomRepositoryImpl roomRepository;

    final testRooms = [
      const Room(
        id: 'room1',
        name: '개발팀 회의실',
        description: '개발팀 전용 회의실',
        creator: 'user1',
        participants: ['user1', 'user2'],
      ),
      const Room(
        id: 'room2',
        name: '디자인팀 회의실',
        description: '디자인팀 전용 회의실',
        creator: 'user2',
        participants: ['user2', 'user3', 'user4'],
      ),
    ];

    setUp(() {
      mockRemoteDataSource = MockRoomRemoteDataSource();
      mockLocalDataSource = MockRoomLocalDataSource();
      roomRepository = RoomRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
      );
    });

    test('회의실 목록 조회 성공 테스트', () async {
      // Given
      when(() => mockRemoteDataSource.fetchRooms())
          .thenAnswer((_) async => testRooms);
      when(() => mockLocalDataSource.saveRooms(any()))
          .thenAnswer((_) async {});

      // When
      final rooms = await roomRepository.getRooms();

      // Then
      expect(rooms.length, 2);
      expect(rooms[0].name, '개발팀 회의실');
      expect(rooms[1].name, '디자인팀 회의실');
      expect(rooms[1].participantCount, 3);
      
      verify(() => mockRemoteDataSource.fetchRooms()).called(1);
      verify(() => mockLocalDataSource.saveRooms(testRooms)).called(1);
    });

    test('원격 실패 시 로컬 데이터 반환 테스트', () async {
      // Given
      when(() => mockRemoteDataSource.fetchRooms())
          .thenThrow(Exception('네트워크 오류'));
      when(() => mockLocalDataSource.getRooms())
          .thenAnswer((_) async => testRooms);

      // When
      final rooms = await roomRepository.getRooms();

      // Then
      expect(rooms.length, 2);
      expect(rooms[0].name, '개발팀 회의실');
      
      verify(() => mockRemoteDataSource.fetchRooms()).called(1);
      verify(() => mockLocalDataSource.getRooms()).called(1);
    });

    test('캐시 동작 테스트', () async {
      // Given
      when(() => mockRemoteDataSource.fetchRooms())
          .thenAnswer((_) async => testRooms);
      when(() => mockLocalDataSource.saveRooms(any()))
          .thenAnswer((_) async {});

      // 첫 번째 호출
      await roomRepository.getRooms();

      // When - 두 번째 호출 (캐시 유효 시간 내)
      final cachedRooms = await roomRepository.getRooms();

      // Then
      expect(cachedRooms.length, 2);
      
      // 원격 데이터 소스는 한 번만 호출되어야 함 (캐시 때문에)
      verify(() => mockRemoteDataSource.fetchRooms()).called(1);
    });
  });
} 