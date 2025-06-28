import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rsupport/models/user.dart';
import 'package:rsupport/repositories/user_repository.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}
class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

void main() {
  group('UserRepository 테스트', () {
    late MockUserRemoteDataSource mockRemoteDataSource;
    late MockUserLocalDataSource mockLocalDataSource;
    late UserRepositoryImpl userRepository;

    final testUsers = [
      const User(
        id: 'user1',
        name: '홍길동',
        email: 'hong@example.com',
        profilePicture: null,
        status: 'online',
        role: 'user',
      ),
      const User(
        id: 'user2',
        name: '김철수',
        email: 'kim@example.com',
        profilePicture: 'profile.jpg',
        status: 'offline',
        role: 'admin',
      ),
    ];

    setUp(() {
      mockRemoteDataSource = MockUserRemoteDataSource();
      mockLocalDataSource = MockUserLocalDataSource();
      userRepository = UserRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
      );
    });

    test('첫 번째 사용자 목록 조회 - 원격에서 가져오기', () async {
      // Given
      when(() => mockRemoteDataSource.fetchUsers())
          .thenAnswer((_) async => testUsers);
      when(() => mockLocalDataSource.saveUsers(any()))
          .thenAnswer((_) async {});

      // When
      final users = await userRepository.getUsers();

      // Then
      expect(users.length, 2);
      expect(users[0].name, '홍길동');
      expect(users[1].name, '김철수');
      
      verify(() => mockRemoteDataSource.fetchUsers()).called(1);
      verify(() => mockLocalDataSource.saveUsers(testUsers)).called(1);
    });

    test('캐시된 사용자 목록 반환 테스트', () async {
      // Given - 첫 번째 호출로 캐시 생성
      when(() => mockRemoteDataSource.fetchUsers())
          .thenAnswer((_) async => testUsers);
      when(() => mockLocalDataSource.saveUsers(any()))
          .thenAnswer((_) async {});

      // 첫 번째 호출
      await userRepository.getUsers();

      // When - 두 번째 호출 (캐시에서 반환되어야 함)
      final cachedUsers = await userRepository.getUsers();

      // Then
      expect(cachedUsers.length, 2);
      expect(cachedUsers[0].name, '홍길동');
      
      // 원격 데이터 소스는 한 번만 호출되어야 함
      verify(() => mockRemoteDataSource.fetchUsers()).called(1);
    });

    test('원격 실패 시 로컬 데이터 반환 테스트', () async {
      // Given
      when(() => mockRemoteDataSource.fetchUsers())
          .thenThrow(Exception('네트워크 오류'));
      when(() => mockLocalDataSource.getUsers())
          .thenAnswer((_) async => testUsers);

      // When
      final users = await userRepository.getUsers();

      // Then
      expect(users.length, 2);
      expect(users[0].name, '홍길동');
      
      verify(() => mockRemoteDataSource.fetchUsers()).called(1);
      verify(() => mockLocalDataSource.getUsers()).called(1);
    });

    test('사용자 목록 새로고침 테스트', () async {
      // Given
      when(() => mockRemoteDataSource.fetchUsers())
          .thenAnswer((_) async => testUsers);
      when(() => mockLocalDataSource.saveUsers(any()))
          .thenAnswer((_) async {});

      // 첫 번째 호출로 캐시 생성
      await userRepository.getUsers();

      // When - 새로고침
      await userRepository.refreshUsers();

      // Then - 원격 데이터 소스가 두 번 호출되어야 함 (초기 + 새로고침)
      verify(() => mockRemoteDataSource.fetchUsers()).called(2);
    });

    test('모든 데이터 소스 실패 시 예외 발생 테스트', () async {
      // Given
      when(() => mockRemoteDataSource.fetchUsers())
          .thenThrow(Exception('네트워크 오류'));
      when(() => mockLocalDataSource.getUsers())
          .thenAnswer((_) async => <User>[]);

      // When & Then
      expect(
        () => userRepository.getUsers(),
        throwsA(isA<Exception>()),
      );
    });
  });
} 