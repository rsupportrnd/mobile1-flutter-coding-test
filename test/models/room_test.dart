import 'package:flutter_test/flutter_test.dart';
import 'package:rsupport/models/room.dart';

void main() {
  group('Room 모델 테스트', () {
    final testRoom = Room(
      id: 'room123',
      name: '개발팀 회의실',
      description: '개발팀 전용 회의실',
      creator: 'user123',
      participants: ['user123', 'user456', 'user789'],
      createdAt: DateTime.parse('2023-01-01T10:00:00Z'),
      lastMessage: {
        'content': '안녕하세요!',
        'timestamp': '2023-01-01T11:00:00Z',
      },
      thumbnailImage: 'thumbnail.jpg',
    );

    final testRoomJson = {
      'id': 'room123',
      'name': '개발팀 회의실',
      'description': '개발팀 전용 회의실',
      'creator': 'user123',
      'participants': ['user123', 'user456', 'user789'],
      'createdAt': '2023-01-01T10:00:00.000Z',
      'lastMessage': {
        'content': '안녕하세요!',
        'timestamp': '2023-01-01T11:00:00Z',
      },
      'thumbnailImage': 'thumbnail.jpg',
    };

    test('JSON에서 Room 객체 생성 테스트', () {
      final room = Room.fromJson(testRoomJson);
      
      expect(room.id, 'room123');
      expect(room.name, '개발팀 회의실');
      expect(room.description, '개발팀 전용 회의실');
      expect(room.creator, 'user123');
      expect(room.participants.length, 3);
      expect(room.thumbnailImage, 'thumbnail.jpg');
    });

    test('Room 객체에서 JSON 변환 테스트', () {
      final json = testRoom.toJson();
      
      expect(json['id'], 'room123');
      expect(json['name'], '개발팀 회의실');
      expect(json['description'], '개발팀 전용 회의실');
      expect(json['creator'], 'user123');
      expect(json['participants'], ['user123', 'user456', 'user789']);
      expect(json['thumbnailImage'], 'thumbnail.jpg');
    });

    test('참가자 수 확인 테스트', () {
      expect(testRoom.participantCount, 3);
    });

    test('마지막 메시지 내용 확인 테스트', () {
      expect(testRoom.lastMessageContent, '안녕하세요!');
    });

    test('마지막 메시지 시간 확인 테스트', () {
      final lastMessageTime = testRoom.lastMessageTime;
      expect(lastMessageTime, isNotNull);
      expect(lastMessageTime, DateTime.parse('2023-01-01T11:00:00Z'));
    });

    test('회의실 이니셜 확인 테스트', () {
      expect(testRoom.initials, '개');
      
      const emptyNameRoom = Room(
        id: 'room456',
        name: '',
        creator: 'user123',
        participants: [],
      );
      expect(emptyNameRoom.initials, '회');
    });

    test('활성 상태 확인 테스트', () {
      // 최근 메시지가 있는 경우 (1시간 이내)
      final activeRoom = Room(
        id: 'room1',
        name: '활성 회의실',
        creator: 'user123',
        participants: ['user123'],
        lastMessage: {
          'content': '최근 메시지',
          'timestamp': DateTime.now().subtract(const Duration(minutes: 30)).toIso8601String(),
        },
      );

      // 오래된 메시지가 있는 경우 (1시간 이상)
      final inactiveRoom = Room(
        id: 'room2',
        name: '비활성 회의실',
        creator: 'user123',
        participants: ['user123'],
        lastMessage: {
          'content': '오래된 메시지',
          'timestamp': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
        },
      );

      expect(activeRoom.isActive, true);
      expect(inactiveRoom.isActive, false);
    });
  });
} 