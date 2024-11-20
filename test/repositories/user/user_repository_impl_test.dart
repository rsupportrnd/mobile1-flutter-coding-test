import 'package:bloc_test/bloc_test.dart';
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

  group('UserRepository_Group', (){
    test('fetchUsers()가 정상적인 결과를 가져온다', () async{
      //when
      when(() => mockUserRepository.fetchUsers()).thenAnswer((_) async => users);
      //act
      final response = await userService.fetUsers();
      //assert
      expect(response, users);
      verify(() => mockUserRepository.fetchUsers()).called(1);
    });

    test('fetchUsers()가 실패해서 에러 결과를 가져온다', () async {
      //when
      when(() => mockUserRepository.fetchUsers()).thenThrow(Exception('Failed to load users'));
      // Act & Assert
      expect(() => userService.fetUsers(), throwsException);
      verify(() => mockUserRepository.fetchUsers()).called(1);
    });
  });
}