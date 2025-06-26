import 'package:mobile1_flutter_coding_test/src/data/model/meeting_room_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/message_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/message_list_response_entity.dart';

abstract interface class MeetingRoomRepository {
  Future<MeetingRoomListResponseModel> getMeetingRoomList();

  Future<MessageListResponseModel> getMessageList();

  Future<List<MessageEntity>> getLocalMessageList({required String roomId});

  Future<void> saveMessages({
    required String roomId,
    required List<MessageEntity> messages,
  });
}
