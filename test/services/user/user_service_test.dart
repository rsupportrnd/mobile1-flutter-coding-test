import 'package:mobile1_flutter_coding_test/constants/enums.dart';
import 'package:mobile1_flutter_coding_test/models/user/user_model.dart';
import 'package:mobile1_flutter_coding_test/repositories/user/user_repository.dart';
import 'package:mobile1_flutter_coding_test/services/user/user_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockUserModel extends Mock implements UserModel {}

void main() {
  late UserService userService;
  late MockUserRepository mockUserRepository;

  late UserModel mockUserModel1;
  late UserModel mockUserModel2;
  late UserModel mockUserModel3;

  setUp(() {
    mockUserRepository = MockUserRepository();
    userService = UserService(mockUserRepository);
    mockUserModel1 = MockUserModel();
    when(() => mockUserModel1.status).thenReturn(UserStatus.offline.name);
    mockUserModel2 = MockUserModel();
    when(() => mockUserModel2.status).thenReturn(UserStatus.away.name);
    mockUserModel3 = MockUserModel();
    when(() => mockUserModel3.status).thenReturn(UserStatus.away.name);
  });

  group('UserService', () {
    test('fetchUsers userStatus -> all 값 정상으로 가져옴', () async {
      final users = [mockUserModel1, mockUserModel2, mockUserModel3];

      when(() => mockUserRepository.fetchUsers())
          .thenAnswer((_) async => users);

      final result = await userService.fetUsers(UserStatus.all);

      expect(result, users);
    });

    test('fetchUsers userStatus ->away 값 정상으로 가져옴', () async {
      final users = [mockUserModel1, mockUserModel2, mockUserModel3];

      when(() => mockUserRepository.fetchUsers())
          .thenAnswer((_) async => users);

      final result = await userService.fetUsers(UserStatus.away);

      expect(result, [users[1], users[2]]);
    });

    test('fetchUser에서 userStatus가 맞지 않으면 빈 리스트를 반환합니다.',
        () async {
          final users = [mockUserModel1, mockUserModel2, mockUserModel3];

      when(() => mockUserRepository.fetchUsers())
          .thenAnswer((_) async => users);

      final result = await userService.fetUsers(UserStatus.online);

      expect(result, []);
    });

    test('fetchUsers 실패시 예외 발생', () async {
      when(() => mockUserRepository.fetchUsers())
          .thenThrow(Exception('Failed to fetch users'));

      expect(() async => await userService.fetUsers(UserStatus.all),
          throwsA(isA<Exception>()));
    });
  });
}
