import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/presentation.dart';
import 'package:mocktail/mocktail.dart';

class _MockMeetingRoomUseCase extends Mock implements MeetingRoomUseCase {}

class _MockMessageUseCase extends Mock implements MessageUseCase {}

void main() {
  group('MeetingRoomListProvider', () {
    late ProviderContainer container;
    late _MockMeetingRoomUseCase mockUseCase;
    late _MockMessageUseCase mockMessageUseCase;

    final DateTime testDateTime = DateTime.now();
    setUp(() {
      mockUseCase = _MockMeetingRoomUseCase();
      mockMessageUseCase = _MockMessageUseCase();
      container = ProviderContainer(overrides: [
        meetingRoomUseCaseProvider.overrideWithValue(mockUseCase),
        messageUseCaseProvider.overrideWithValue(mockMessageUseCase),
      ]);
    });

    tearDown(() => container.dispose());

    MeetingRoomEntity roomOld = MeetingRoomEntity(
      roomId: 'old',
      roomName: 'old',
      creator: 'c',
      participants: const <String>[],
      createdAt: testDateTime,
      lastMessage: LastMessageEntity(
        sender: 'a',
        content: 'old',
        timestamp: testDateTime,
      ),
      thumbnailImage: 't1',
    );
    MeetingRoomEntity roomNew = MeetingRoomEntity(
      roomId: 'new',
      roomName: 'new',
      creator: 'c',
      participants: const <String>[],
      createdAt: testDateTime,
      lastMessage: LastMessageEntity(
        sender: 'b',
        content: 'new',
        timestamp: testDateTime,
      ),
      thumbnailImage: 't2',
    );
    MeetingRoomListResponseEntity entity =
        MeetingRoomListResponseEntity(meetingRooms: [roomOld, roomNew]);

    test('build sorts rooms by recent message', () async {
      when(() => mockUseCase.getMeetingRoomList())
          .thenAnswer((_) async => entity);
      when(() =>
              mockMessageUseCase.getLocalMessages(roomId: any(named: 'roomId')))
          .thenAnswer((_) async => <MessageEntity>[]);

      final MeetingRoomListResponseEntity result =
          await container.read(meetingRoomListProvider.future);

      expect(result.meetingRooms.last.roomId, roomNew.roomId);
      verify(() => mockUseCase.getMeetingRoomList()).called(1);
      verify(() => mockMessageUseCase.getLocalMessages(roomId: roomOld.roomId))
          .called(1);
      verify(() => mockMessageUseCase.getLocalMessages(roomId: roomNew.roomId))
          .called(1);
    });

    test('updateLastMessage updates existing room', () async {
      when(() => mockUseCase.getMeetingRoomList())
          .thenAnswer((_) async => entity);
      when(() =>
              mockMessageUseCase.getLocalMessages(roomId: any(named: 'roomId')))
          .thenAnswer((_) async => <MessageEntity>[]);

      await container.read(meetingRoomListProvider.future);

      final MessageEntity message = MessageEntity(
        roomId: roomOld.roomId,
        messageId: 'm',
        sender: 's',
        content: 'c',
        timestamp: testDateTime,
      );

      container
          .read(meetingRoomListProvider.notifier)
          .updateLastMessage(messageEntity: message);

      final MeetingRoomListResponseEntity updated =
          container.read(meetingRoomListProvider).requireValue;

      expect(updated.meetingRooms.first.roomId, roomOld.roomId);
      expect(updated.meetingRooms.first.lastMessage.sender, message.sender);
    });
  });
}
