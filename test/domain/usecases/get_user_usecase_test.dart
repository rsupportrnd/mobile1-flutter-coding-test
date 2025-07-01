import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/user_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/user_repository.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_users_usecase.dart';

// 가짜 UserRepository
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
  test('GetUsersUseCase', () async {
    final repository = FakeUserRepository();
    final useCase = GetUsersUseCase(repository);

    final users = await useCase.call();

    expect(users, isA<List<UserEntity>>());
    expect(users.length, 1);
    expect(users.first.userId, 'user1');
  });
}
