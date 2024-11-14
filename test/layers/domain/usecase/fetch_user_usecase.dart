
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';

import '../../../mock/domain/repository/mock_user_repository.dart';


//@GenerateMocks([UserRepository])
void main() {
  late FetchUsersUseCase fetchUsersUseCase;
  late MockUserRepository mockUserRepository;
  late List<User> mockUsers;

  setUp(() {
    mockUserRepository = MockUserRepository();
    fetchUsersUseCase = FetchUsersUseCase(mockUserRepository);

    // 테스트용 사용자 목록 생성
    mockUsers = [
      User(
        id: '1',
        name: 'Test User 1',
        email: 'test1@example.com',
        profilePictureUrl: 'https://test.com/1',
        status: UserStatus.online,
        role: UserRole.admin,
      ),
      User(
        id: '2',
        name: 'Test User 2',
        email: 'test2@example.com',
        profilePictureUrl: 'https://test.com/2',
        status: UserStatus.offline,
        role: UserRole.member,
      ),
    ];
  });

  group('FetchUsersUseCase Tests', () {
    test('fetchUser가 성공하면 사용자 목록을 반환을 확인한다.', () async {
      when(mockUserRepository.fetchUsers()).thenAnswer((_) async => mockUsers);

      // 유스케이스 실행
      final result = await fetchUsersUseCase.execute();

      // 결과 확인
      expect(result, mockUsers);
      verify(mockUserRepository.fetchUsers()).called(1);
    });

    test('fetchUser가 예외를 적용할 때 오류를 확인한다.', () async {
      when(mockUserRepository.fetchUsers()).thenThrow(Exception("Failed to fetch users"));

      // 예외 발생 여부 검증
      expect(() => fetchUsersUseCase.execute(), throwsException);
      verify(mockUserRepository.fetchUsers()).called(1);
    });
  });
}
