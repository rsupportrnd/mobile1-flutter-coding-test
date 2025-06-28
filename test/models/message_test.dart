import 'package:flutter_test/flutter_test.dart';
import 'package:rsupport/models/message.dart';

void main() {
  group('Message 모델 테스트', () {
    final testMessage = Message(
      id: 'msg123',
      roomId: 'room123',
      userId: 'user123',
      userName: '홍길동',
      content: '안녕하세요! 테스트 메시지입니다.',
      timestamp: DateTime.parse('2023-01-01T12:00:00Z'),
    );

    final testMessageJson = {
      'id': 'msg123',
      'roomId': 'room123',
      'userId': 'user123',
      'userName': '홍길동',
      'content': '안녕하세요! 테스트 메시지입니다.',
      'timestamp': '2023-01-01T12:00:00.000Z',
    };

    test('JSON에서 Message 객체 생성 테스트', () {
      final message = Message.fromJson(testMessageJson);
      
      expect(message.id, 'msg123');
      expect(message.roomId, 'room123');
      expect(message.userId, 'user123');
      expect(message.userName, '홍길동');
      expect(message.content, '안녕하세요! 테스트 메시지입니다.');
      expect(message.timestamp, DateTime.parse('2023-01-01T12:00:00Z'));
    });

    test('Message 객체에서 JSON 변환 테스트', () {
      final json = testMessage.toJson();
      
      expect(json['id'], 'msg123');
      expect(json['roomId'], 'room123');
      expect(json['userId'], 'user123');
      expect(json['userName'], '홍길동');
      expect(json['content'], '안녕하세요! 테스트 메시지입니다.');
      expect(json['timestamp'], '2023-01-01T12:00:00.000Z');
    });

    test('userName이 null인 경우 테스트', () {
      final messageWithoutUserName = Message(
        id: 'msg456',
        roomId: 'room123',
        userId: 'user123',
        userName: null,
        content: '사용자 이름이 없는 메시지',
        timestamp: DateTime.now(),
      );

      expect(messageWithoutUserName.userName, isNull);
      
      final json = messageWithoutUserName.toJson();
      expect(json['userName'], isNull);
    });
  });
} 