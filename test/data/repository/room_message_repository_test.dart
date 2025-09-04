import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/core/network/response_codes.dart';
import 'package:mobile1_flutter_coding_test/core/network/response_result.dart';
import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';
import 'package:mobile1_flutter_coding_test/data/repository/room_message_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mockito/mockito.dart';

import '../datasource/room_message_datasource_test.mocks.dart';

void main() {
  late RoomMessageRepositoryImpl roomMessageRepositoryImpl;
  late MockRoomMessageDatasource mockRoomMessageDatasource;
  setUp(() {
    mockRoomMessageDatasource = MockRoomMessageDatasource();
    roomMessageRepositoryImpl = RoomMessageRepositoryImpl(
        roomMessageDatasource: mockRoomMessageDatasource);
  });

  group('RoomMessageRepository', () {
    test('getRoomMessages 호출 시 MessageListModel 반환', () async {
      final mockResponse = MessageListModel(messages: [
        MessageModel(
            sender: 'user1',
            content: 'Hello',
            timestamp: '2021-01-01T00:00:00Z',
            roomId: 'room1',
            messageId: 'message1'),
      ]);

      when(mockRoomMessageDatasource.getRoomMessages())
          .thenAnswer((_) async => ResponseResult(
                code: ResponseCodes.success,
                data: mockResponse,
              ));
      when(mockRoomMessageDatasource.hasMessages())
          .thenAnswer((_) async => false);

      final result = await roomMessageRepositoryImpl.getRoomMessages();

      expect(result.code, ResponseCodes.success);
      expect(result.data, isA<Map<String, List<Message>>>());
      expect(result.data?['room1'], hasLength(1));
    });

    test('빈 메시지 목록을 받을 때 빈 리스트를 반환', () async {
      final mockResponse = MessageListModel(messages: []);

      when(mockRoomMessageDatasource.getRoomMessages())
          .thenAnswer((_) async => ResponseResult(
                data: mockResponse,
                code: ResponseCodes.success,
              ));
      when(mockRoomMessageDatasource.hasMessages())
          .thenAnswer((_) async => false);

      final result = await roomMessageRepositoryImpl.getRoomMessages();

      expect(result.code, ResponseCodes.success);
      expect(result.data, isA<Map<String, List<Message>>>());
      expect(result.data?.isEmpty, isTrue);
    });
  });
}
