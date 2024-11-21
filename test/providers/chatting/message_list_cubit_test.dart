import 'package:bloc_test/bloc_test.dart';
import 'package:mobile1_flutter_coding_test/models/chatting/message_model.dart';
import 'package:mobile1_flutter_coding_test/services/chatting/message_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:mobile1_flutter_coding_test/providers/chatting/message_list_cubit.dart';

class MockMessageService extends Mock implements MessageService {}

class MockMessageModel extends Mock implements MessageModel {}

void main() {
  late MessageListCubit messageListCubit;
  late MockMessageService mockMessageService;
  late List<MessageModel> dbMessages;
  late List<MessageModel> roomMessages;
  setUp(() {
    mockMessageService = MockMessageService();
    messageListCubit = MessageListCubit(mockMessageService);

    MockMessageModel mockMessageModel1 = MockMessageModel();
    when(() => mockMessageModel1.roomId).thenReturn('room1');
    MockMessageModel mockMessageModel2 = MockMessageModel();
    when(() => mockMessageModel2.roomId).thenReturn('room2');
    MockMessageModel mockMessageModel3 = MockMessageModel();
    when(() => mockMessageModel3.roomId).thenReturn('room1');

    dbMessages = [
      mockMessageModel1,
      mockMessageModel2,
    ];

    roomMessages = [mockMessageModel3];
  });

  tearDown(() {
    messageListCubit.close();
  });

  group('MessageListCubit', () {
    blocTest<MessageListCubit, MessageListState>(
      'MessageListCubit이 정상적으로 loading -> loaded로 변경 함',
      build: () {
        when(() => mockMessageService.fetchAllMessages(
                roomId: any(named: 'roomId')))
            .thenAnswer((_) async => [...dbMessages, ...roomMessages]);
        return messageListCubit;
      },
      act: (cubit) => cubit.fetchMessagesByRoomNumber(roomId: 'room1'),
      expect: () => [
        const MessageListState.loading(),
        MessageListState.loaded([...dbMessages, ...roomMessages]),
      ],
    );

    blocTest<MessageListCubit, MessageListState>(
      'RoomListCubit이 실패시 loading -> error로 변경 함',
      build: () {
        when(() => mockMessageService.fetchAllMessages(
                roomId: any(named: 'roomId')))
            .thenThrow(Exception('Failed to fetch messages'));
        return messageListCubit;
      },
      act: (cubit) => cubit.fetchMessagesByRoomNumber(roomId: 'room1'),
      expect: () => [
        const MessageListState.loading(),
        const MessageListState.error('Exception: Failed to fetch messages'),
      ],
    );

    blocTest<MessageListCubit, MessageListState>(
      'state가 loaded가 아닐때는 createMessage가 생성 안 됨',
      seed: () => MessageListState.loading(),
      build: () => messageListCubit,
      act: (cubit) =>
          cubit.createMessage(roomId: 'room1', content: 'New Message'),
      verify: (cubit) {
        final message =
            cubit.createMessage(roomId: 'room1', content: 'New Message');
        expect(message, isNull);
      },
    );

    blocTest<MessageListCubit, MessageListState>(
      'createMessage returns null when roomId or content is empty',
      build: () => messageListCubit,
      seed: () => MessageListState.loaded([...dbMessages, ...roomMessages]),
      act: (cubit) => cubit.createMessage(roomId: '', content: 'New Message'),
      verify: (cubit) {
        final message = cubit.createMessage(roomId: '', content: 'New Message');
        expect(message, isNull);
      },
    );
  });
}
