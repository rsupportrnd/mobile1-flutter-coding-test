import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/room_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/room_repository.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_room_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_rooms_usecase.dart';

class FakeRoomRepository implements RoomRepository {
  @override
  Future<List<RoomEntity>> getRooms() async {
    return [
      RoomEntity(
        roomId: 'room1',
        roomName: '테스트 회의실',
        creator: 'user1',
        participants: ['user1', 'user2'],
        createdAt: DateTime(2024, 1, 1, 10, 0, 0),
        lastMessage: LastMessageEntity(
          sender: 'user2',
          content: '마지막 메시지',
          timestamp: DateTime(2024, 1, 1, 11, 0, 0),
        ),
        thumbnailImage: '',
      ),
    ];
  }

  @override
  Future<List<MessageEntity>> getMessages() async {
    return [
      MessageEntity(
        roomId: 'room1',
        messageId: 'msg1',
        sender: 'user1',
        content: '안녕하세요, 오늘 회의 시작할까요?',
        timestamp: DateTime(2024, 1, 1, 10, 0, 0),
      ),
      MessageEntity(
        roomId: 'room1',
        messageId: 'msg2',
        sender: 'user2',
        content: '안녕하세요, 오늘 회의 시작할까요?',
        timestamp: DateTime(2024, 1, 1, 10, 0, 0),
      ),
      MessageEntity(
        roomId: 'room3',
        messageId: 'msg3',
        sender: 'user3',
        content: '안녕하세요, 오늘 회의 시작할까요?',
        timestamp: DateTime(2024, 1, 1, 10, 0, 0),
      ),
    ];
  }
}

void main() {
  test('GetRoomsUseCase', () async {
    final repository = FakeRoomRepository();
    final useCase = GetRoomsUseCase(repository);

    final rooms = await useCase.call();

    expect(rooms, isA<List<RoomEntity>>());
    expect(rooms.length, 1);
    expect(rooms.first.roomId, 'room1');
  });

  test('GetRoomMessageUseCase', () async {
    final repository = FakeRoomRepository();
    final useCase = GetRoomMessageUseCase(repository);

    final messages = await useCase.call(roomId: 'room1');

    expect(messages, isA<List<MessageEntity>>());
    expect(messages.length, 2);
    expect(messages.first.roomId, 'room1');
  });
}
