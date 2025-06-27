import 'package:mobile1_flutter_coding_test/src/data/model/meeting_room_list_response_model.dart';

abstract interface class MeetingRoomRepository {
  Future<MeetingRoomListResponseModel> getMeetingRoomList();
}
