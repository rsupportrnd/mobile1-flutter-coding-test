import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile1_flutter_coding_test/local_database/objectbox.dart';
import 'package:mobile1_flutter_coding_test/models/chatting/message_model.dart';
import 'package:mobile1_flutter_coding_test/repositories/chatting/message_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile1_flutter_coding_test/services/chatting/message_service.dart';

class MockMessageRepository extends Mock implements MessageRepository {}
class MockObjectBox extends Mock implements ObjectBox {}

void main() {
  final GetIt sl = GetIt.instance;

  setUp(() {
    final mockObjectBox = MockObjectBox();
    sl.registerSingleton<ObjectBox>(mockObjectBox);
    when(() => mockObjectBox.fetchMessages(any()))
        .thenAnswer((_) => Stream.value([
      // MessageEntity(
      //   roomId: 'room10',
      //   content: 'DB Message 1',
      //   messageId: 'msg1',
      //   sender: 'user1',
      //   timestamp: DateTime.parse('2023-01-01T12:00:00'),
      // ),
      // MessageEntity(
      //   roomId: 'room3',
      //   content: 'DB Message 1',
      //   messageId: 'msg2',
      //   sender: 'user2',
      //   timestamp: DateTime.parse('2023-01-02T12:00:00'),
      // ),
    ]));

    final mockMessageRepository = MockMessageRepository();
    sl.registerSingleton<MessageRepository>(mockMessageRepository);

    final messageService = MessageService(mockMessageRepository);
    sl.registerSingleton<MessageService>(messageService);
  });

  tearDown(() {
    sl.reset();
  });

  group('MessageService', () {
    test('fetchAllMessages는 timestamp별로 정렬된 메시지 목록을 반환합니다.', () async {
      final dbMessages = [
        const MessageModel(
          roomId: 'room1',
          content: 'DB Message 1',
          messageId: 'msg1',
          sender: 'user1',
          timestamp: '2023-01-01T12:00:00',
        ),
        const MessageModel(
          roomId: 'room1',
          content: 'DB Message 2',
          messageId: 'msg1',
          sender: 'user1',
          timestamp: '2023-01-01T12:03:00',
        ),
      ];
      final roomMessages = [
        const MessageModel(
          roomId: 'room3',
          content: 'Room Message 1',
          messageId: 'msg2',
          sender: 'user2',
          timestamp: '2023-01-01T12:01:00',
        ),
      ];
      when(() => sl<MessageRepository>().fetchMessages())
          .thenAnswer((_) async => [...dbMessages, ...roomMessages]);
      final result = await sl<MessageService>().fetchAllMessages(roomId: 'room1');

      expect(result, isA<List<MessageModel>>());
      expect(result.length, 2);
      expect(result[0].timestamp, '2023-01-01T12:00:00');
      expect(result[1].timestamp, '2023-01-01T12:03:00');
    });

    test('fetchMessages가 실패할 때 예외 발생.', () async {
      when(() => sl<MessageRepository>().fetchMessages())
          .thenThrow(Exception('Failed to fetch messages'));
      expect(
            () async => await sl<MessageService>().fetchAllMessages(roomId: 'room1'),
        throwsA(isA<Exception>()),
      );
    });

    test('생성된 메시지는 msg id값을 하나씩 올림', () {
      final list = [
        const MessageModel(
          roomId: 'room1',
          content: 'Message 1',
          messageId: 'msg100',
          sender: 'user1',
          timestamp: '2023-01-01T12:00:00',
        ),
      ];

      final newMessage = sl<MessageService>().createMessage(
        roomId: 'room1',
        content: 'New Message',
        list: list,
      );
      expect(newMessage!.messageId, 'msg101');
    });
  });
}