// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:mobile1_flutter_coding_test/data/datasource/user_datasource_impl.dart';
// import 'package:mobile1_flutter_coding_test/data/utils/json_loader.dart';
// import 'package:mobile1_flutter_coding_test/data/model/response.dart';
// import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';

// // mock 클래스 생성
// class MockJsonLoader extends Mock implements IJsonLoader {}

// void main() {
//   late MockJsonLoader mockJsonLoader;
//   late UserDataSourceImpl dataSource;

//   setUp(() {
//     mockJsonLoader = MockJsonLoader();
//     dataSource = UserDataSourceImpl(jsonLoader: mockJsonLoader);
//   });

//   test('getUsers returns UserResponse when JSON loads successfully', () async {
//     // given
//     final fakeJson = {
//       'users': [
//         {
//           "userId": "user1",
//           "name": "Alice Kim",
//           "email": "alice.kim@example.com",
//           "profilePicture": "https://picsum.photos/id/1011/200/200",
//           "status": "online",
//           "role": "admin"
//         }
//       ]
//     };

//     when(() => mockJsonLoader.loadJson(any()))
//         .thenAnswer((_) async => fakeJson);

//     // when
//     final result = await dataSource.getUsers();

//     // then
//     expect(result, isA<UserResponse>());
//     expect(result.users, isNotEmpty);
//     expect(result.users.first.userId, 'user1');
//   });

//   test('getUsers rethrows JsonLoadException on loading error', () async {
//     // given
//     when(() => mockJsonLoader.loadJson(any()))
//         .thenThrow(const JsonLoadException('Failed to load JSON'));

//     // then
//     expect(() => dataSource.getUsers(), throwsA(isA<JsonLoadException>()));
//   });
// }
