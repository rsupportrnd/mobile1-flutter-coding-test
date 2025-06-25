import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/src/data/repository/user_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/src/domain/repository/user_repository.dart';
import 'package:mobile1_flutter_coding_test/src/domain/usecase/user_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/user_list_response_model.dart';

class _MockUserRepository extends Mock implements UserRepository {}

void main() {
  late ProviderContainer container;
  late _MockUserRepository mockRepo;

  setUp(() {
    mockRepo = _MockUserRepository();
    container = ProviderContainer(
      overrides: [
        userRepositoryProvider.overrideWithValue(mockRepo),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('GetUserListUseCase', () {
    test('returns data on success', () async {
      const UserListResponseModel expected = UserListResponseModel(users: []);
      when(() => mockRepo.getUserList()).thenAnswer((_) async => expected);

      final UserListResponseModel result = await container.read(getUserListUseCaseProvider.future);

      expect(result, expected);
      verify(() => mockRepo.getUserList()).called(1);
    });

    test('throws on failure', () async {
      final Exception exception = Exception('Repo error');
      when(() => mockRepo.getUserList()).thenThrow(exception);

      expect(
        () => container.read(getUserListUseCaseProvider.future),
        throwsA(exception),
      );
      verify(() => mockRepo.getUserList()).called(1);
    });
  });
}
