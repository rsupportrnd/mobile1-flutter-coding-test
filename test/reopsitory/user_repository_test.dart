// import 'package:flutter_test/flutter_test.dart';
// import 'package:mobile1_flutter_coding_test/data/datasource/user_datasource.dart';
// import 'package:mobile1_flutter_coding_test/data/model/response.dart';
// import 'package:mobile1_flutter_coding_test/data/model/user_model.dart';
// import 'package:mobile1_flutter_coding_test/data/repository/user_repository_impl.dart';
// import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
// import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:mobile1_flutter_coding_test/data/datasource/local_database_datasource.dart';
// import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';

// // mock 클래스 생성
// class MockUserDataSource extends Mock implements UserDataSource {}

// class MockLocalDatabaseDataSource extends Mock
//     implements LocalDatabaseDataSource {}

// void main() {
//   late MockUserDataSource mockUserDataSource;
//   late MockLocalDatabaseDataSource mockLocalDatabaseDataSource;
//   late UserRepositoryImpl repository;

//   // 각 테스트 실행 직전 실행
//   setUp(() {
//     mockUserDataSource = MockUserDataSource();
//     mockLocalDatabaseDataSource = MockLocalDatabaseDataSource();
//     repository = UserRepositoryImpl(
//       dataSource: mockUserDataSource,
//       localDatabaseDataSource: mockLocalDatabaseDataSource,
//     );
//   });

//   const sampleUserModel = UserModel(
//       userId: 'user1',
//       name: 'userName1',
//       email: 'user1@example.com',
//       profilePicture: 'url',
//       status: 'online',
//       role: 'member');

//   const sampleUserEntity = User(
//       userId: 'user1',
//       name: 'userName1',
//       email: 'user1@example.com',
//       profilePicture: 'url',
//       status: 'online',
//       role: 'member');

//   group('getUsers', () {
//     test('성공 시 유저 리스트 반환하고 insertUsers 호출', () async {
//       when(() => mockUserDataSource.getUsers()).thenAnswer(
//           (_) async => const UserResponse(users: [sampleUserModel]));
//       when(() => mockLocalDatabaseDataSource.insertUsers(
//           users: any(named: 'users'))).thenAnswer((_) async => Future.value());

//       final result = await repository.getUsers();

//       switch (result) {
//         case Success(:final data):
//           expect(data, isNotEmpty); // 리스트가 비어있지 않은지 검사
//         case Failure(:final error):
//           fail('Result is failure: $error');
//       }
//       verify(() => mockUserDataSource.getUsers()).called(1);
//       verify(() => mockLocalDatabaseDataSource.insertUsers(
//               users: any(named: 'users')))
//           .called(1); // any: insertUsers 메서드의 users 파라미터는 패스
//     });

//     test('실패 시 Result 실패 반환', () async {
//       when(() => mockUserDataSource.getUsers())
//           .thenThrow(const JsonLoadException('fail'));

//       final result = await repository.getUsers();

//       expect(result, isA<Failure>());
//       verify(() => mockUserDataSource.getUsers()).called(1);
//     });
//   });

//   group('selectUsers', () {
//     test('성공 시 DB 유저 리스트 반환', () async {
//       when(() => mockLocalDatabaseDataSource.selectUsers())
//           .thenAnswer((_) async => [sampleUserModel]);

//       final result = await repository.selectUsers();

//       switch (result) {
//         case Success(:final data):
//           expect(data, isNotEmpty); // 리스트가 비어있지 않은지 검사
//         case Failure(:final error):
//           fail('Result is failure: $error');
//       }
//       verify(() => mockLocalDatabaseDataSource.selectUsers()).called(1);
//     });
//   });

//   group('insertUsers', () {
//     test('성공 시 여러 회의실 저장', () async {
//       when(() => mockLocalDatabaseDataSource.insertUsers(
//           users: any(named: 'users'))).thenAnswer((_) async => Future.value());

//       final users = [sampleUserEntity, sampleUserEntity];

//       final result = await repository.insertUsers(users: users);

//       expect(result, isA<Success>());
//       verify(() => mockLocalDatabaseDataSource.insertUsers(
//           users: any(named: 'users'))).called(1);
//     });
//   });
// }
