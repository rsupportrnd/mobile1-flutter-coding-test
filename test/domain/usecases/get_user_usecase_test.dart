import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/user_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/user_repository.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_users_usecase.dart';
import 'package:get_it/get_it.dart';

class FakeUserRepository implements UserRepository {
  @override
  Future<List<UserEntity>> getUsers() async {
    return [
      const UserEntity(
        userId: 'user1',
        name: '테스트',
        email: 'test@example.com',
        profilePicture: '',
        status: 'online',
        role: 'admin',
      ),
    ];
  }
}

void main() {
  setUp(() {
    GetIt.I.registerSingleton<UserRepository>(FakeUserRepository());
    GetIt.I.registerSingleton<GetUsersUseCase>(GetUsersUseCase(GetIt.I<UserRepository>()));
  });

  tearDown(() {
    GetIt.I.reset();
  });

  test('GetUsersUseCase', () async {
    final useCase = GetIt.I<GetUsersUseCase>();

    final users = await useCase.call();

    expect(users, isA<List<UserEntity>>());
    expect(users.length, 1);
  });
}
