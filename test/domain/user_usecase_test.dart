import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/data/data.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:mocktail/mocktail.dart';

class _MockUserRepository extends Mock implements UserRepository {}

void main() {
  late ProviderContainer container;
  late _MockUserRepository mockRepo;

  setUp(() {
    mockRepo = _MockUserRepository();
    container = ProviderContainer(overrides: <Override>[
      userRepositoryProvider.overrideWithValue(mockRepo),
    ]);
  });

  tearDown(() => container.dispose());

  group('UserUseCase', () {
    test('getUserList returns entity on success', () async {
      const UserListResponseEntity dummyEntity = UserListResponseEntity(users: []);

      when(() => mockRepo.getUserList()).thenAnswer((_) async => dummyEntity);

      final UserUseCase useCase = container.read(userUseCaseProvider);
      final UserListResponseEntity result = await useCase.getUserList();

      expect(result, dummyEntity);
      verify(() => mockRepo.getUserList()).called(1);
    });

    test('getUserList throws when repository fails', () async {
      final Exception exception = Exception('Repo error');
      when(() => mockRepo.getUserList()).thenThrow(exception);

      final UserUseCase useCase = container.read(userUseCaseProvider);

      expect(
        () => useCase.getUserList(),
        throwsA(same(exception)),
      );
      verify(() => mockRepo.getUserList()).called(1);
    });
  });
}
