import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile1_flutter_coding_test/layers/data/data.dart';

import '../../../../mock/utils/mock_box.dart';

@GenerateMocks([Box<ChatMessageDAO>])
void main() async {

  late LocalDataSource localDataSource;
  late MockBox<ChatMessageDAO> mockBox;

  setUp(() {
    mockBox = MockBox<ChatMessageDAO>();
    localDataSource = LocalDataSource(mockBox);
  });

  group('LocalDataSource - addMessage Tests', () {

    test('메시지를 성공적으로 추가한다.', () async {
      final message = ChatMessage(
        roomId: 'room1',
        messageId: 'msg1',
        sender: 'user1',
        content: 'Hello, this is a test message',
        timestamp: DateTime.parse('2024-11-01T09:00:00Z'),
      );
      when(mockBox.add(any)).thenAnswer((_) async => 1);

      await localDataSource.addMessage(message);

      // add 메서드가 호출되었는지 확인
      verify(mockBox.add(any)).called(1);
    });


    test('여러 메시지를 성공적으로 추가한다.', () async {
      final messages = [
        ChatMessage(
          roomId: 'room1',
          messageId: 'msg1',
          sender: 'user1',
          content: 'Hello, this is the first message',
          timestamp: DateTime.parse('2024-11-01T09:00:00Z'),
        ),
        ChatMessage(
          roomId: 'room1',
          messageId: 'msg2',
          sender: 'user2',
          content: 'Hello, this is the second message',
          timestamp: DateTime.parse('2024-11-01T09:01:00Z'),
        ),
      ];
      when(mockBox.add(any)).thenAnswer((_) async => 1);

      // 실행: addMessages 호출
      await localDataSource.addMessages(messages);

      // 검증: add 메서드가 두 번 호출되었는지 확인
      verify(mockBox.add(any)).called(2);
    });
  });

  group('LocalDataSource - getAllMessages Tests', () {
    test('모든 메시지를 성공적으로 가져온다.', () {
      final message1 = ChatMessageDAO(
        roomId: 'room1',
        messageId: 'msg1',
        sender: 'user1',
        content: 'Hello, this is a test message',
        timestamp: '2024-11-01T09:00:00Z',
      );
      final message2 = ChatMessageDAO(
        roomId: 'room2',
        messageId: 'msg2',
        sender: 'user2',
        content: 'Hello, this is another test message',
        timestamp: '2024-11-02T10:00:00Z',
      );
      when(mockBox.values).thenReturn([message1, message2]);

      final messages = localDataSource.getAllMessages();

      // 반환된 메시지 확인
      expect(messages, isA<List<ChatMessageDAO>>());
      expect(messages.length, 2);
      expect(messages[0].content, 'Hello, this is a test message');
      expect(messages[1].content, 'Hello, this is another test message');
    });
  });
}
