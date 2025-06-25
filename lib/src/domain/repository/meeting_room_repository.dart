import 'package:mobile1_flutter_coding_test/src/data/model/meeting_room_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/message_list_response_model.dart';

abstract interface class MeetingRoomRepository {
  Future<MeetingRoomListResponseModel> getMeetingRoomList();

  Future<MessageListResponseModel> getMessageList();
}
