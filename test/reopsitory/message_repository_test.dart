// import 'package:flutter_test/flutter_test.dart';
// import 'package:mobile1_flutter_coding_test/data/model/response.dart';
// import 'package:mobile1_flutter_coding_test/data/model/room_model.dart';
// import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:mobile1_flutter_coding_test/data/datasource/message_datasource.dart';
// import 'package:mobile1_flutter_coding_test/data/datasource/local_database_datasource.dart';
// import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';
// import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
// import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';
// import 'package:mobile1_flutter_coding_test/data/repository/message_repository_impl.dart';

// // mock 클래스 생성
// class MockMessageDataSource extends Mock implements MessageDataSource {}

// class MockLocalDatabaseDataSource extends Mock
//     implements LocalDatabaseDataSource {}

// // mocktail은 any() 쓸 때 내부적으로 기본값(FallbackValue)을 만들어서 넘겨줘야 하는데,
// // 커스텀 클래스 타입에 대해선 기본값을 모르기 때문에 직접 등록해줘야 함
// class FakeLastMessageModel extends Fake implements LastMessageModel {}

// class FakeMessageModel extends Fake implements MessageModel {}

// void main() {
//   late MockMessageDataSource mockMessageDataSource;
//   late MockLocalDatabaseDataSource mockLocalDatabaseDataSource;
//   late MessageRepositoryImpl repository;

//   // 그룹 안에서 최초 한번만 실행
//   setUpAll(() {
//     registerFallbackValue(FakeLastMessageModel());
//     registerFallbackValue(FakeMessageModel());
//   });

//   // 각 테스트 실행 직전 실행
//   setUp(() {
//     mockMessageDataSource = MockMessageDataSource();
//     mockLocalDatabaseDataSource = MockLocalDatabaseDataSource();
//     repository = MessageRepositoryImpl(
//       dataSource: mockMessageDataSource,
//       localDatabaseDataSource: mockLocalDatabaseDataSource,
//     );
//   });

//   final sampleMessageModel = MessageModel(
//     messageId: 'msg1',
//     roomId: 'room1',
//     sender: 'user1',
//     content: 'Hello',
//     timestamp: DateTime.now().toIso8601String(),
//   );

//   final sampleMessageEntity = Message(
//     messageId: 'msg1',
//     roomId: 'room1',
//     sender: 'user1',
//     content: 'Hello',
//     timestamp: DateTime.now().toIso8601String(),
//   );

//   group('getMessages', () {
//     test('성공 시 메시지 리스트 반환하고 insertMessages 호출', () async {
//       when(() => mockMessageDataSource.getMessages()).thenAnswer(
//           (_) async => MessageResponse(messages: [sampleMessageModel]));

//       when(() => mockLocalDatabaseDataSource.insertMessages(
//               messages: any(named: 'messages')))
//           .thenAnswer((_) async => Future.value());

//       final result = await repository.getMessages();

//       switch (result) {
//         case Success(:final data):
//           expect(data, isNotEmpty); // 리스트가 비어있지 않은지 검사
//         case Failure(:final error):
//           fail('Result is failure: $error');
//       }
//       verify(() => mockMessageDataSource.getMessages()).called(1);
//       verify(() => mockLocalDatabaseDataSource.insertMessages(
//               messages: any(named: 'messages')))
//           .called(1); // any: insertMessages 메서드의 messages파라미터는 패스
//     });

//     test('실패 시 Result 실패 반환', () async {
//       when(() => mockMessageDataSource.getMessages())
//           .thenThrow(const JsonLoadException('fail'));

//       final result = await repository.getMessages();

//       expect(result, isA<Failure>());
//       verify(() => mockMessageDataSource.getMessages()).called(1);
//     });
//   });

//   group('selectMessages', () {
//     test('성공 시 DB 메시지 리스트 반환', () async {
//       when(() => mockLocalDatabaseDataSource.selectMessages())
//           .thenAnswer((_) async => [sampleMessageModel]);

//       final result = await repository.selectMessages();

//       switch (result) {
//         case Success(:final data):
//           expect(data, isNotEmpty); // 리스트가 비어있지 않은지 검사
//         case Failure(:final error):
//           fail('Result is failure: $error');
//       }
//       verify(() => mockLocalDatabaseDataSource.selectMessages()).called(1);
//     });
//   });

//   group('insertMessage', () {
//     test('성공 시 메시지 저장 후 방 정보 업데이트', () async {
//       when(() => mockLocalDatabaseDataSource.insertMessage(
//               message: any(named: 'message')))
//           .thenAnswer((_) async => sampleMessageModel);

//       when(() => mockLocalDatabaseDataSource.updateRoom(
//               roomId: any(named: 'roomId'), message: any(named: 'message')))
//           .thenAnswer((_) async => Future.value());

//       final result =
//           await repository.insertMessage(message: sampleMessageEntity);

//       switch (result) {
//         case Success(:final data):
//           expect(data.messageId, sampleMessageEntity.messageId);
//         case Failure(:final error):
//           fail('Result is failure: $error');
//       }

//       verify(() => mockLocalDatabaseDataSource.insertMessage(
//           message: any(named: 'message'))).called(1);
//       verify(() => mockLocalDatabaseDataSource.updateRoom(
//           roomId: any(named: 'roomId'),
//           message: any(named: 'message'))).called(1);
//     });
//   });

//   group('insertMessages', () {
//     test('성공 시 여러 메시지 저장', () async {
//       when(() => mockLocalDatabaseDataSource.insertMessages(
//               messages: any(named: 'messages')))
//           .thenAnswer((_) async => Future.value());

//       final messages = [sampleMessageEntity, sampleMessageEntity];

//       final result = await repository.insertMessages(messages: messages);

//       expect(result, isA<Success>());
//       verify(() => mockLocalDatabaseDataSource.insertMessages(
//           messages: any(named: 'messages'))).called(1);
//     });
//   });
// }
