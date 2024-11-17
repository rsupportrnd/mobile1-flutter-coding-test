import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/layers/data/data.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';
import 'package:mockito/mockito.dart';

import '../../../../mock/data/source/remote/mock_remote_data_source.dart';


void main() {
  late MockRemoteDataSources mockRemoteDataSource;
  late UserRepositoryImp userRepository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSources();
    userRepository = UserRepositoryImp(mockRemoteDataSource);
  });

  group('UserRepositoryImp Tests', () {
    test('fetchUsers가 성공적으로 호출되면 사용자 목록 반환결과를 확인합니다.', () async {
      // Mock 데이터를 준비합니다.
      final mockResponse = [
        UserDTO(
            userId: "user1",
            name: "Alice Kim",
            email: "alice.kim@example.com",
            profilePicture: "https://picsum.photos/id/1011/200/200",
            status: "online",
            role: "admin"),
        UserDTO(
            userId: "user2",
            name: "Bob Lee",
            email: "bob.lee@example.com",
            profilePicture: "https://picsum.photos/id/1012/200/200",
            status: "offline",
            role: "member"),
      ];

      when(mockRemoteDataSource.fetchUsers()).thenAnswer((_) async => mockResponse);

      final result = await userRepository.fetchUsers();

      // 결과 검증
      expect(result, isA<List<User>>());
      expect(result.length, 2);
      expect(result[0].name, 'Alice Kim');
      expect(result[1].name, 'Bob Lee');
    });

    test('fetchUsers 실패 시 예외처리를 확인합니다.', () async {
      when(mockRemoteDataSource.fetchUsers()).thenThrow(Exception('Failed to load users'));

      // 실행 및 예외 확인
      expect(() => userRepository.fetchUsers(), throwsException);
    });
  });
}
