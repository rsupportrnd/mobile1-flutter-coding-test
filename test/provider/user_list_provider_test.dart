import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/core.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/presentation.dart';
import 'package:mocktail/mocktail.dart';

class _MockUserUseCase extends Mock implements UserUseCase {}

void main() {
  group('UserListProvider', () {
    late ProviderContainer container;
    late _MockUserUseCase mockUseCase;

    setUp(() {
      mockUseCase = _MockUserUseCase();
      container = ProviderContainer(overrides: [
        userUseCaseProvider.overrideWithValue(mockUseCase),
      ]);
    });

    tearDown(() => container.dispose());

    test('build returns data from usecase', () async {
      const UserEntity user = UserEntity(
        userId: '1',
        name: 'user',
        email: 'email',
        profilePicture: 'pic',
        status: UserStatus.online,
        role: UserRole.member,
      );
      const UserListResponseEntity entity =
          UserListResponseEntity(users: [user]);
      when(() => mockUseCase.getUserList()).thenAnswer((_) async => entity);

      final UserListResponseEntity result =
          await container.read(userListProvider.future);

      expect(result, entity);
      verify(() => mockUseCase.getUserList()).called(1);
    });

    test('getUserList refreshes state', () async {
      const UserListResponseEntity empty = UserListResponseEntity(users: []);

      when(() => mockUseCase.getUserList()).thenAnswer((_) async => empty);

      await container.read(userListProvider.notifier).getUserList();

      final state = container.read(userListProvider);
      expect(state, const AsyncData(empty));

      verify(() => mockUseCase.getUserList()).called(2);
    });
  });
}
