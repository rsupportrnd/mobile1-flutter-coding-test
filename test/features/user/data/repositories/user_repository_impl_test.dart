import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/repositories/user_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/sources/user_api_service.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/models/user_model.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/models/user_list_response.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/models/user_status.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/models/user_role.dart';

import 'user_repository_impl_test.mocks.dart';
/// api 요청 테스트 
/// 모델링 유효성 검증 
@GenerateMocks([UserApiService])
void main() {
  group('UserRepositoryImpl Tests', () {
    late UserRepositoryImpl repository;
    late MockUserApiService mockApiService;

    setUp(() {
      mockApiService = MockUserApiService();
      repository = UserRepositoryImpl(mockApiService);
    });

    group('getUsers', () {
      test('succees, return list', () async {
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

        when(mockApiService.getUsers()).thenAnswer(
          (_) async => UserListResponse(users: testUsers),
        );

        // When
        final result = await repository.getUsers();

        // Then
        expect(result, testUsers);
        verify(mockApiService.getUsers()).called(1);
      });

      test('exception, throw exception', () async {
        // Given
        when(mockApiService.getUsers()).thenThrow(Exception('Network error'));

        // When & Then
        expect(
          () async => await repository.getUsers(),
          throwsA(isA<Exception>()),
        );
        verify(mockApiService.getUsers()).called(1);
      });

      test('empty list, return empty list', () async {
        // Given
        when(mockApiService.getUsers()).thenAnswer(
          (_) async => const UserListResponse(users: []),
        );

        // When
        final result = await repository.getUsers();

        // Then
        expect(result, isEmpty);
        verify(mockApiService.getUsers()).called(1);
      });
    });

    group('Integration Tests with Real API', () {
      test('fetch and parse real api', () async {
        // Given
        final dio = Dio();
        const apiUrl = 'https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/users.json';

        // When
        final response = await dio.get(apiUrl);
        final jsonData = jsonDecode(response.data);
        final userListResponse = UserListResponse.fromJson(jsonData);
        final result = userListResponse.users;

        // 테스트를 위한 값이 비어있지 않음을 가정
        expect(result, isNotEmpty);
        // Verify all users have valid data
        for (final user in result) { 
        expect(user.userId, isNotEmpty);
        expect(user.name, isNotEmpty);
        expect(user.email, isNotEmpty);
        expect(user.profilePicture, isNotEmpty);
        expect(user.status, isA<UserStatus>());
        expect(user.role, isA<UserRole>());
        }
      });

      test('network error, throw exception', () async {
        // Given
        final dio = Dio();
        dio.options.connectTimeout = const Duration(milliseconds: 100);
        dio.options.receiveTimeout = const Duration(milliseconds: 100);

        // When & Then
        expect(
          () async => await dio.get('https://nonexistent-domain-that-should-fail.com/api'),
          throwsA(isA<DioException>()),
        );
      });
    });
  });
}