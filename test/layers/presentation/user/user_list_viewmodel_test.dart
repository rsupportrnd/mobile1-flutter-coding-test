import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/common/common.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/user_list_viewmodel.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';

import '../../../mock/domain/usecase/mock_fetch_users_usecase.dart';


//@GenerateMocks([FetchUsersUseCase])
void main() {
  late UserListViewModel viewModel;
  late MockFetchUsersUseCase mockFetchUsersUseCase;
  late List<User> mockUsers;

  setUp(() {
    mockFetchUsersUseCase = MockFetchUsersUseCase();
    viewModel = UserListViewModel(mockFetchUsersUseCase);
    mockUsers = [
      User(
        id: '1',
        name: 'Test User',
        email: 'admin@admin.com',
        profilePictureUrl: 'https://test.com1',
        status: UserStatus.online,
        role: UserRole.admin,
      ),
      User(
        id: '2',
        name: 'Test User2',
        email: 'member@member.com',
        profilePictureUrl: 'https://test.com2',
        status: UserStatus.online,
        role: UserRole.member,
      )
    ];
  });

  group('UserListViewModel Tests', () {

    test('초기 상태 값과 fetchUserList 호출 후 상태 변화를 확인합니다.', () async {
      when(mockFetchUsersUseCase.execute()).thenAnswer((_) async => mockUsers);
      // 초기 상태값 확인
      expect(viewModel.isLoading, true);
      expect(viewModel.isError, false);
      expect(viewModel.errorMessage, '');
      expect(viewModel.userList, []);

      await viewModel.fetchUserList();
      // fetchUserList 호출 시 상태가 올바르게 변하는지 확인
      expect(viewModel.isLoading, false);
      expect(viewModel.isError, false);
      expect(viewModel.errorMessage, '');
      expect(viewModel.userList, mockUsers);
    });

    test('fetchUserList 호출 시 에러가 발생하면 에러 상태, 메시지를 출력하는지 확인합니다.', () async {
      when(mockFetchUsersUseCase.execute()).thenThrow(Exception(AppStrings.unexpectedError));

      expect(viewModel.isLoading, true);
      expect(viewModel.isError, false);
      expect(viewModel.errorMessage, '');

      await viewModel.fetchUserList();
      // 에러상태, 메시지 출력되는지 확인
      expect(viewModel.isLoading, false);
      expect(viewModel.isError, true);
      expect(viewModel.errorMessage, AppStrings.unexpectedError);
    });

    test('onRetry 호출 시 사용자 목록을 다시 가져오는지 확인합니다.', () async {
      when(mockFetchUsersUseCase.execute()).thenAnswer((_) async => mockUsers);

      await viewModel.onRetry();
      // 사용자 목록이 다시 로드되는지 확인
      expect(viewModel.isLoading, false);
      expect(viewModel.errorMessage, '');
      expect(viewModel.userList, mockUsers);
    });
  });
}
