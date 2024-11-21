import 'package:bloc_test/bloc_test.dart';
import 'package:mobile1_flutter_coding_test/constants/9.constants.dart';
import 'package:mobile1_flutter_coding_test/models/user/user_model.dart';
import 'package:mobile1_flutter_coding_test/providers/user/user_list_cubit.dart';
import 'package:mobile1_flutter_coding_test/repositories/user/user_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/services/user/user_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockUserRepository extends Mock implements UserRepositoryImpl {}
class MockUserModel extends Mock implements UserModel {}

void main() {
  late UserListCubit userListCubit;
  late UserService userService;
  late MockUserRepository mockUserRepository;
  late List<UserModel> users = [];

  setUp(() {
    mockUserRepository = MockUserRepository();
    userService = UserService(mockUserRepository);
    userListCubit = UserListCubit(userService);

    UserModel user1 = MockUserModel();
    UserModel user2 = MockUserModel();
    UserModel user3 = MockUserModel();
    users = [user1, user2, user3];
  });

  tearDown(() {
    userListCubit.close();
  });

  group('UserListCubit_Group', (){
    blocTest<UserListCubit, UserListState>(
      'UserListCubit이 정상적으로 loading -> loaded로 변경 함',
      build: () {
        when(() => mockUserRepository.fetchUsers()).thenAnswer((_) async => users);
        return userListCubit;
      },
      act: (cubit) => cubit.fetchUsers(UserStatus.all),
      expect: () => [
        const UserListState.loading(),
        UserListState.loaded(users),
      ],
    );

    blocTest<UserListCubit, UserListState>(
      'UserListCubit이 실패해서 loading -> error로 변경 함',
      build: () {
        when(() => mockUserRepository.fetchUsers()).thenThrow(Exception('Failed to fetch users'));
        return userListCubit;
      },
      act: (cubit) => cubit.fetchUsers(UserStatus.all),
      expect: () => [
        const UserListState.loading(),
        const UserListState.error('Exception: Failed to fetch users'),
      ],
    );
  });
}