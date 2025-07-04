import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';
import 'package:mobile1_flutter_coding_test/data/remote/rsupport_api_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/message_datasource_impl.dart';
import 'package:mobile1_flutter_coding_test/data/model/response.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';

// mock 클래스 생성
class MockRSupportApiService extends Mock implements RSupportApiService {}

void main() {
  late MockRSupportApiService mockRSupportApiService;
  late MessageDataSourceImpl dataSource;

  setUp(() {
    mockRSupportApiService = MockRSupportApiService();
    dataSource = MessageDataSourceImpl(service: mockRSupportApiService);
  });

  test('getMessages returns MessageResponse when API loads successfully',
      () async {
    // given
    final fakeResponse = MessageResponse(messages: [
      MessageModel(
        messageId: 'msg1',
        roomId: 'room1',
        sender: 'user1',
        content: 'Hello',
        timestamp: DateTime.now().toIso8601String(),
      ),
      MessageModel(
        messageId: 'msg2',
        roomId: 'room2',
        sender: 'user2',
        content: 'Hello2',
        timestamp: DateTime.now().toIso8601String(),
      )
    ]);

    when(() => mockRSupportApiService.getMessages())
        .thenAnswer((_) async => fakeResponse);

    // when
    final result = await dataSource.getMessages();

    // then
    expect(result, isA<MessageResponse>());
    expect(result.messages, isNotEmpty);
    expect(result.messages.first.messageId, 'msg1');
  });

  test('getMessages rethrows NetworkException on loading error', () async {
    // given
    when(() => mockRSupportApiService.getMessages())
        .thenThrow(const NetworkException());

    // then
    expect(() => dataSource.getMessages(), throwsA(isA<CustomException>()));
  });
}
