import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/core/network/response_codes.dart';
import 'package:mobile1_flutter_coding_test/core/network/response_result.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/room_message_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'room_message_datasource_test.mocks.dart';

@GenerateMocks([RoomMessageDatasource])
void main() {
  late MockRoomMessageDatasource mockRoomMessageDatasource;

  setUp(() {
    mockRoomMessageDatasource = MockRoomMessageDatasource();
  });

  group('RoomMessageDatasource', () {
    test('getRoomMessages 호출 시 MessageListModel 반환', () async {
      final mockResponse = {
        "messages": [
          {
            "sender": "user1",
            "content": "Hello",
            "timestamp": "2021-01-01T00:00:00Z",
            "roomId": "room1",
            "messageId": "message1",
          }
        ]
      };

      when(mockRoomMessageDatasource.getRoomMessages())
          .thenAnswer((_) async => ResponseResult(
                data: MessageListModel.fromJson(mockResponse),
                code: ResponseCodes.success,
              ));

      final result = await mockRoomMessageDatasource.getRoomMessages();

      expect(result.code, ResponseCodes.success);
      expect(result.data, isA<MessageListModel>());
      expect(result.data?.messages, hasLength(1));
    });

    test('빈 메시지 목록을 받을 때 빈 리스트를 반환', () async {
      final mockResponse = {"messages": []};

      when(mockRoomMessageDatasource.getRoomMessages())
          .thenAnswer((_) async => ResponseResult(
                data: MessageListModel.fromJson(mockResponse),
                code: ResponseCodes.success,
              ));

      final result = await mockRoomMessageDatasource.getRoomMessages();

      expect(result.code, ResponseCodes.success);
      expect(result.data, isA<MessageListModel>());
      expect(result.data?.messages, isEmpty);
    });
  });
}
