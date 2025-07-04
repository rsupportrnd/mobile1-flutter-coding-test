import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/data/model/room_model.dart';
import 'package:mobile1_flutter_coding_test/data/remote/rsupport_api_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/room_datasource_impl.dart';
import 'package:mobile1_flutter_coding_test/data/model/response.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';

// mock 클래스 생성
class MockRSupportApiService extends Mock implements RSupportApiService {}

void main() {
  late MockRSupportApiService mockRSupportApiService;
  late RoomDataSourceImpl dataSource;

  setUp(() {
    mockRSupportApiService = MockRSupportApiService();
    dataSource = RoomDataSourceImpl(service: mockRSupportApiService);
  });

  test('getRooms returns RoomResponse when API loads successfully', () async {
    // given

    final fakeResponse = ChatRoomResponse(chatRooms: [
      ChatRoomModel(
          roomId: 'room1',
          roomName: 'roomName1',
          creator: 'user1',
          participants: ['user1', 'user2', 'user3'],
          createdAt: DateTime.now().toIso8601String(),
          lastMessage: LastMessageModel(
              sender: "user3",
              content: "content3",
              timestamp: DateTime.now().toIso8601String()),
          thumbnailImage: 'url'),
      ChatRoomModel(
          roomId: 'room2',
          roomName: 'roomName2',
          creator: 'user2',
          participants: ['user2', 'user3', 'user6'],
          createdAt: DateTime.now().toIso8601String(),
          lastMessage: LastMessageModel(
              sender: "user2",
              content: "content2",
              timestamp: DateTime.now().toIso8601String()),
          thumbnailImage: 'url')
    ]);

    when(() => mockRSupportApiService.getRooms())
        .thenAnswer((_) async => fakeResponse);

    // when
    final result = await dataSource.getRooms();

    // then
    expect(result, isA<ChatRoomResponse>());
    expect(result.chatRooms, isNotEmpty);
    expect(result.chatRooms.first.roomId, 'room1');
  });

  test('getRooms rethrows UnKnownException on loading error', () async {
    // given
    when(() => mockRSupportApiService.getRooms())
        .thenThrow(const UnKnownException('Failed to load JSON'));

    // then
    expect(() => dataSource.getRooms(), throwsA(isA<CustomException>()));
  });
}
