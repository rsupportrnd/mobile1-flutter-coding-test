import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/room_datasource_impl.dart';
import 'package:mobile1_flutter_coding_test/data/utils/json_loader.dart';
import 'package:mobile1_flutter_coding_test/data/model/response.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';

// mock 클래스 생성
class MockJsonLoader extends Mock implements IJsonLoader {}

void main() {
  late MockJsonLoader mockJsonLoader;
  late RoomDataSourceImpl dataSource;

  setUp(() {
    mockJsonLoader = MockJsonLoader();
    dataSource = RoomDataSourceImpl(jsonLoader: mockJsonLoader);
  });

  test('getRooms returns RoomResponse when JSON loads successfully', () async {
    // given
    final fakeJson = {
      'chatRooms': [
        {
          "roomId": "room1",
          "roomName": "프로젝트 A 회의",
          "creator": "user1",
          "participants": ["user1", "user2", "user3"],
          "createdAt": "2024-11-01T09:00:00Z",
          "lastMessage": {
            "sender": "user2",
            "content": "다음 회의는 언제로 할까요?",
            "timestamp": "2024-11-07T15:30:00Z"
          },
          "thumbnailImage": "https://picsum.photos/id/1011/200/200"
        }
      ]
    };

    when(() => mockJsonLoader.loadJson(any()))
        .thenAnswer((_) async => fakeJson);

    // when
    final result = await dataSource.getRooms();

    // then
    expect(result, isA<ChatRoomResponse>());
    expect(result.chatRooms, isNotEmpty);
    expect(result.chatRooms.first.roomId, 'room1');
  });

  test('getRooms rethrows JsonLoadException on loading error', () async {
    // given
    when(() => mockJsonLoader.loadJson(any()))
        .thenThrow(const JsonLoadException('Failed to load JSON'));

    // then
    expect(() => dataSource.getRooms(), throwsA(isA<JsonLoadException>()));
  });
}
