import 'package:mobile1_flutter_coding_test/repositories/room/room_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile1_flutter_coding_test/services/room/room_service.dart';
import 'package:mobile1_flutter_coding_test/models/room/room_model.dart';
import 'package:test/test.dart';

class MockRoomRepository extends Mock implements RoomRepository {}
class MockRoomModel extends Mock implements RoomModel {}

void main() {
  late RoomService roomService;
  late MockRoomRepository mockRoomRepository;

  late MockRoomModel mockRoomModel1;
  late MockRoomModel mockRoomModel2;


  setUp(() {
    mockRoomRepository = MockRoomRepository();
    roomService = RoomService(mockRoomRepository);
    mockRoomModel1 = MockRoomModel();
    when(() => mockRoomModel1.roomId).thenReturn('room1');
    when(() => mockRoomModel1.roomName).thenReturn('room1');
    when(() => mockRoomModel1.createdAt).thenReturn( DateTime.now().toIso8601String());
    mockRoomModel2 = MockRoomModel();
    when(() => mockRoomModel2.roomId).thenReturn('room2');
    when(() => mockRoomModel2.roomName).thenReturn('room2');
    when(() => mockRoomModel1.createdAt).thenReturn( DateTime.now().toIso8601String());
  });

  group('RoomService', () {
    test('fetchRooms로 룸정보를 받아온다.', () async {
      final rooms = [
        mockRoomModel1,
        mockRoomModel2,
      ];

      when(() => mockRoomRepository.fetchRooms()).thenAnswer((_) async => rooms);
      final result = await roomService.fetchRooms();
      expect(result, rooms);
    });

    test('fetchRooms 실패로 exception 발생', () async {
      when(() => mockRoomRepository.fetchRooms()).thenThrow(Exception('Failed to fetch rooms'));

      expect(() async => await roomService.fetchRooms(), throwsA(isA<Exception>()));
    });

    test('convertFormatTimeDiff는 1분 전 타임스탬프에 대해 “Just now”을 반환합니다.', () {
      final timestamp = DateTime.now().subtract(const Duration(seconds: 30)).toIso8601String();
      final result = roomService.convertFormatTimeDiff(timestamp);
      expect(result, 'Just now');
    });

    test('convertFormatTimeDiff는 한시간전 타임스탬프에 대해 “10분전”을 반환합니다.', () {
      final timestamp = DateTime.now().subtract(const Duration(minutes: 10)).toIso8601String();
      final result = roomService.convertFormatTimeDiff(timestamp);
      expect(result, '10분전');
    });

    test('convertFormatTimeDiff는 하루전 타임스탬프에 대해 “5시간전”을 반환합니다.', () {
      final timestamp = DateTime.now().subtract(const Duration(hours: 5)).toIso8601String();
      final result = roomService.convertFormatTimeDiff(timestamp);
      expect(result, '5시간전');
    });

    test('convertFormatTimeDiff는 한달전 타임스탬프에 대해 “20일전”을 반환합니다.', () {
      final timestamp = DateTime.now().subtract(const Duration(days: 20)).toIso8601String();
      final result = roomService.convertFormatTimeDiff(timestamp);
      expect(result, '20일전');
    });

    test('그 외에는 다 옛날', () {
      final timestamp = DateTime.now().subtract(const Duration(days: 40)).toIso8601String();
      final result = roomService.convertFormatTimeDiff(timestamp);
      expect(result, '옛날');
    });
  });
}