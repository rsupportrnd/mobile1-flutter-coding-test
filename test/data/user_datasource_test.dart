import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/exception/custom_exception.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile1_flutter_coding_test/src/data/datasource/user_datasource.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/user_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/repository/user_repository_impl.dart';

class _MockUserDatasource extends Mock implements UserDatasource {}

void main() {
  group('UserRepositoryImpl', () {
    late _MockUserDatasource mockDatasource;
    late UserRepositoryImpl repository;

    setUp(() {
      mockDatasource = _MockUserDatasource();
      repository = UserRepositoryImpl(datasource: mockDatasource);
    });

    test('getUserList returns data on success', () async {
      const UserListResponseModel expected = UserListResponseModel(users: []);
      when(() => mockDatasource.getUserList()).thenAnswer((_) async => expected);

      final UserListResponseModel result = await repository.getUserList();

      expect(result, expected);
      verify(() => mockDatasource.getUserList()).called(1);
    });

    test('getUserList throws when datasource fails', () async {
      final Exception exception = Exception('Datasource error');
      when(() => mockDatasource.getUserList()).thenThrow(exception);

      expect(
        () => repository.getUserList(),
        throwsA(isA<UnknownException>()),
      );
      verify(() => mockDatasource.getUserList()).called(1);
    });
  });
}
