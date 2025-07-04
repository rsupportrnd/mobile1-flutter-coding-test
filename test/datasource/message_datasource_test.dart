// import 'package:flutter_test/flutter_test.dart';
// import 'package:mobile1_flutter_coding_test/data/remote/rsupport_api_service.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:mobile1_flutter_coding_test/data/datasource/message_datasource_impl.dart';
// import 'package:mobile1_flutter_coding_test/data/utils/json_loader.dart';
// import 'package:mobile1_flutter_coding_test/data/model/response.dart';
// import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';

// // mock 클래스 생성
// class MockRSupportApiService extends Mock implements RSupportApiService {}

// void main() {
//   late MockRSupportApiService mockRSupportApiService;
//   late MessageDataSourceImpl dataSource;

//   setUp(() {
//     mockRSupportApiService = MockRSupportApiService();
//     dataSource = MessageDataSourceImpl(service: mockRSupportApiService);
//   });

//   test('getMessages returns MessageResponse when JSON loads successfully',
//       () async {
//     // given
//     final fakeJson = {
//       'messages': [
//         {
//           "roomId": "room1",
//           "messageId": "msg1",
//           "sender": "user1",
//           "content": "안녕하세요, 오늘 회의 시작할까요?",
//           "timestamp": "2024-11-07T10:00:00Z"
//         }
//       ]
//     };

//     when(() => mockRSupportApiService.loadJson(any()))
//         .thenAnswer((_) async => fakeJson);

//     // when
//     final result = await dataSource.getMessages();

//     // then
//     expect(result, isA<MessageResponse>());
//     expect(result.messages, isNotEmpty);
//     expect(result.messages.first.messageId, 'msg1');
//   });

//   test('getMessages rethrows JsonLoadException on loading error', () async {
//     // given
//     when(() => mockJsonLoader.loadJson(any()))
//         .thenThrow(const JsonLoadException('Failed to load JSON'));

//     // then
//     expect(() => dataSource.getMessages(), throwsA(isA<JsonLoadException>()));
//   });
// }
