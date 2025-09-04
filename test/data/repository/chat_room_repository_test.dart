import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/core/network/response_codes.dart';
import 'package:mobile1_flutter_coding_test/core/network/response_result.dart';
import 'package:mobile1_flutter_coding_test/data/model/chat_room_model.dart';
import 'package:mobile1_flutter_coding_test/data/repository/chat_room_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/chat_room.dart';

import '../datasource/chat_room_datasource_test.mocks.dart';
import 'package:mockito/mockito.dart';

void main() {
  late ChatRoomRepositoryImpl chatRoomRepositoryImpl;
  late MockChatRoomDatasource mockChatRoomDatasource;
  setUp(() {
    mockChatRoomDatasource = MockChatRoomDatasource();
    chatRoomRepositoryImpl =
        ChatRoomRepositoryImpl(chatRoomDatasource: mockChatRoomDatasource);
  });

  group('ChatRoomRepository', () {
    test('getChatRooms 호출 시 ChatRoomListModel 반환', () async {
      final mockResponse = {
        "chatRooms": [
          {
            "roomId": "room1",
            "roomName": "프로젝트 A 회의",
            "creator": "user1",
            "participants": ["user1", "user2", "user3"],
            "createdAt": "2024-11-01T09:00:00Z",
            "lastMessage": {
              "sender": "user2",
              "content": "다음 회의는 언제로 할까요?",
              "timestamp": "2024-11-07T15:30:00Z"
            },
            "thumbnailImage": "https://picsum.photos/id/1011/200/200"
          },
          {
            "roomId": "room2",
            "roomName": "개발자 채팅방",
            "creator": "user4",
            "participants": ["user4", "user5", "user2"],
            "createdAt": "2024-10-25T14:30:00Z",
            "lastMessage": {
              "sender": "user5",
              "content": "코드 리뷰 부탁드립니다.",
              "timestamp": "2024-11-07T14:45:00Z"
            },
            "thumbnailImage": "https://picsum.photos/id/1012/200/200"
          },
        ]
      };

      when(mockChatRoomDatasource.getChatRooms())
          .thenAnswer((_) async => ResponseResult(
                data: ChatRoomListModel.fromJson(mockResponse),
                code: ResponseCodes.success,
              ));

      final result = await chatRoomRepositoryImpl.getChatRooms();

      expect(result.code, ResponseCodes.success);
      expect(result.data, isA<List<ChatRoom>>());
      expect(result.data?.length, 2);
    });
  });
}
