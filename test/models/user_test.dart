import 'package:flutter_test/flutter_test.dart';
import 'package:rsupport/models/user.dart';

void main() {
  group('User 모델 테스트', () {
    const testUser = User(
      id: 'user123',
      name: '홍길동',
      email: 'hong@example.com',
      profilePicture: 'profile.jpg',
      status: 'online',
      role: 'admin',
    );

    const testUserJson = {
      'id': 'user123',
      'name': '홍길동',
      'email': 'hong@example.com',
      'profilePicture': 'profile.jpg',
      'status': 'online',
      'role': 'admin',
    };

    test('JSON에서 User 객체 생성 테스트', () {
      final user = User.fromJson(testUserJson);
      
      expect(user.id, 'user123');
      expect(user.name, '홍길동');
      expect(user.email, 'hong@example.com');
      expect(user.profilePicture, 'profile.jpg');
      expect(user.status, 'online');
      expect(user.role, 'admin');
    });

    test('User 객체에서 JSON 변환 테스트', () {
      final json = testUser.toJson();
      
      expect(json['id'], 'user123');
      expect(json['name'], '홍길동');
      expect(json['email'], 'hong@example.com');
      expect(json['profilePicture'], 'profile.jpg');
      expect(json['status'], 'online');
      expect(json['role'], 'admin');
    });

    test('온라인 상태 확인 테스트', () {
      const onlineUser = User(
        id: 'user1',
        name: '온라인 사용자',
        email: 'online@example.com',
        profilePicture: null,
        status: 'online',
        role: 'user',
      );

      const offlineUser = User(
        id: 'user2',
        name: '오프라인 사용자',
        email: 'offline@example.com',
        profilePicture: null,
        status: 'offline',
        role: 'user',
      );

      expect(onlineUser.isOnline, true);
      expect(offlineUser.isOnline, false);
    });

    test('관리자 권한 확인 테스트', () {
      const adminUser = User(
        id: 'admin1',
        name: '관리자',
        email: 'admin@example.com',
        profilePicture: null,
        status: 'online',
        role: 'admin',
      );

      const normalUser = User(
        id: 'user1',
        name: '일반 사용자',
        email: 'user@example.com',
        profilePicture: null,
        status: 'online',
        role: 'user',
      );

      expect(adminUser.isAdmin, true);
      expect(normalUser.isAdmin, false);
    });
  });
} 