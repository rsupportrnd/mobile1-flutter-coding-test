import 'package:rsupport/models/user.dart';
import 'package:rsupport/models/room.dart';
import 'package:rsupport/models/message.dart';

/// 테스트에서 사용할 공통 테스트 데이터
class TestData {
  static const users = [
    User(
      id: 'user1',
      name: '홍길동',
      email: 'hong@example.com',
      profilePicture: null,
      status: 'online',
      role: 'user',
    ),
    User(
      id: 'user2',
      name: '김철수',
      email: 'kim@example.com',
      profilePicture: 'profile.jpg',
      status: 'offline',
      role: 'admin',
    ),
    User(
      id: 'user3',
      name: '이영희',
      email: 'lee@example.com',
      profilePicture: null,
      status: 'online',
      role: 'user',
    ),
  ];

  static const rooms = [
    Room(
      id: 'room1',
      name: '개발팀 회의실',
      description: '개발팀 전용 회의실',
      creator: 'user1',
      participants: ['user1', 'user2'],
    ),
    Room(
      id: 'room2',
      name: '디자인팀 회의실',
      description: '디자인팀 전용 회의실',
      creator: 'user2',
      participants: ['user2', 'user3'],
    ),
  ];

  static final messages = [
    Message(
      id: 'msg1',
      roomId: 'room1',
      userId: 'user1',
      userName: '홍길동',
      content: '안녕하세요! 개발팀 회의실입니다.',
      timestamp: DateTime.parse('2023-01-01T10:00:00Z'),
    ),
    Message(
      id: 'msg2',
      roomId: 'room1',
      userId: 'user2',
      userName: '김철수',
      content: '안녕하세요! 잘 부탁드립니다.',
      timestamp: DateTime.parse('2023-01-01T10:05:00Z'),
    ),
    Message(
      id: 'msg3',
      roomId: 'room2',
      userId: 'user3',
      userName: '이영희',
      content: '디자인팀 회의실 메시지입니다.',
      timestamp: DateTime.parse('2023-01-01T11:00:00Z'),
    ),
  ];

  /// JSON 형태의 API 응답 데이터
  static const userApiResponse = {
    'users': [
      {
        'id': 'user1',
        'name': '홍길동',
        'email': 'hong@example.com',
        'profilePicture': null,
        'status': 'online',
        'role': 'user',
      },
      {
        'id': 'user2',
        'name': '김철수',
        'email': 'kim@example.com',
        'profilePicture': 'profile.jpg',
        'status': 'offline',
        'role': 'admin',
      },
    ],
  };

  static const roomApiResponse = {
    'chatRooms': [
      {
        'id': 'room1',
        'name': '개발팀 회의실',
        'description': '개발팀 전용 회의실',
        'creator': 'user1',
        'participants': ['user1', 'user2'],
        'createdAt': null,
        'lastMessage': null,
        'thumbnailImage': null,
      },
    ],
  };

  static const messageApiResponse = {
    'messages': [
      {
        'messageId': 'msg1',
        'roomId': 'room1',
        'sender': 'user1',
        'content': '안녕하세요!',
        'timestamp': '2023-01-01T10:00:00Z',
      },
    ],
  };
} 