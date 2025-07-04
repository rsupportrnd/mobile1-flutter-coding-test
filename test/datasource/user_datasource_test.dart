import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/data/model/user_model.dart';
import 'package:mobile1_flutter_coding_test/data/remote/rsupport_api_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/user_datasource_impl.dart';
import 'package:mobile1_flutter_coding_test/data/model/response.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';

// mock 클래스 생성
class MockRSupportApiService extends Mock implements RSupportApiService {}

void main() {
  late MockRSupportApiService mockRSupportApiService;
  late UserDataSourceImpl dataSource;

  setUp(() {
    mockRSupportApiService = MockRSupportApiService();
    dataSource = UserDataSourceImpl(service: mockRSupportApiService);
  });

  test('getUsers returns UserResponse when API loads successfully', () async {
    // given

    const fakeResponse = UserResponse(users: [
      UserModel(
          userId: 'user1',
          name: 'userName1',
          email: 'user1@example.com',
          profilePicture: 'url',
          status: 'online',
          role: 'member'),
      UserModel(
          userId: 'user2',
          name: 'userName2',
          email: 'user2@example.com',
          profilePicture: 'url',
          status: 'offline',
          role: 'nobody')
    ]);

    when(() => mockRSupportApiService.getUsers())
        .thenAnswer((_) async => fakeResponse);

    // when
    final result = await dataSource.getUsers();

    // then
    expect(result, isA<UserResponse>());
    expect(result.users, isNotEmpty);
    expect(result.users.first.userId, 'user1');
  });

  test('getUsers rethrows ServerException on loading error', () async {
    // given
    when(() => mockRSupportApiService.getUsers())
        .thenThrow(const ServerException());

    // then
    expect(() => dataSource.getUsers(), throwsA(isA<CustomException>()));
  });
}
