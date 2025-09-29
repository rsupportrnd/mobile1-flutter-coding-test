import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:mobile1_flutter_coding_test/features/user/domain/repositories/user_repository.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/models/user_model.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/models/user_status.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/models/user_role.dart';
import 'package:mobile1_flutter_coding_test/features/user/presentation/controllers/user_list_provider.dart';

import 'user_list_provider_test.mocks.dart';

/// UserListProvider 상태 변화 테스트
@GenerateMocks([UserRepository])
void main() {
  group('UserListProvider Tests', () {
    late MockUserRepository mockRepository;
    late ProviderContainer container;

    setUp(() {
      mockRepository = MockUserRepository();
      container = ProviderContainer(
        overrides: [
          userRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    group('UserListState', () {
      test('init state, loading', () {
        // When
        final usersAsync = container.read(userListControllerProvider);

        // Then
        expect(usersAsync, isA<AsyncLoading<List<User>>>());
      });

      test('call succees, return users', () async {
        // Given
        final testUsers = [
          const User(
            userId: 'user1',
            name: 'Alice Kim',
            email: 'alice.kim@example.com',
            profilePicture: 'https://picsum.photos/id/1011/200/200',
            status: UserStatus.online,
            role: UserRole.admin,
          ),
          const User(
            userId: 'user2',
            name: 'Bob Lee',
            email: 'bob.lee@example.com',
            profilePicture: 'https://picsum.photos/id/1012/200/200',
            status: UserStatus.offline,
            role: UserRole.member,
          ),
        ];

        when(mockRepository.getUsers()).thenAnswer((_) async => testUsers);

        // When
        final usersAsync = await container.read(userListControllerProvider.future);

        // Then
        expect(usersAsync, testUsers);
        verify(mockRepository.getUsers()).called(1);
      });

      test('empty list, return empty list', () async {
        // Given
        when(mockRepository.getUsers()).thenAnswer((_) async => []);

        // When
        final usersAsync = await container.read(userListControllerProvider.future);

        // Then
        expect(usersAsync, isEmpty);
        verify(mockRepository.getUsers()).called(1);
      });

      test('refresh, call succees', () async {
        // Given
        final initialUsers = [
          const User(
            userId: 'user1',
            name: 'Alice Kim',
            email: 'alice.kim@example.com',
            profilePicture: 'https://picsum.photos/id/1011/200/200',
            status: UserStatus.online,
            role: UserRole.admin,
          ),
        ];

        final refreshedUsers = [
          const User(
            userId: 'user1',
            name: 'Alice Kim Updated',
            email: 'alice.kim@example.com',
            profilePicture: 'https://picsum.photos/id/1011/200/200',
            status: UserStatus.offline,
            role: UserRole.admin,
          ),
        ];

        // Setup initial mock
        when(mockRepository.getUsers()).thenAnswer((_) async => initialUsers);

        // When - Initial load
        final initialResult = await container.read(userListControllerProvider.future);
        expect(initialResult, initialUsers);

        // Reset mock for second call
        when(mockRepository.getUsers()).thenAnswer((_) async => refreshedUsers);

        // When - Refresh
        await container.read(userListControllerProvider.notifier).refresh();
        final refreshedResult = await container.read(userListControllerProvider.future);

        // Then
        expect(refreshedResult, refreshedUsers);
        verify(mockRepository.getUsers()).called(2);
      });

    });
  });
}