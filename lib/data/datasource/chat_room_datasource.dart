import 'package:mobile1_flutter_coding_test/core/network/request_api.dart';
import 'package:mobile1_flutter_coding_test/core/network/response_result.dart';
import 'package:mobile1_flutter_coding_test/data/model/chat_room_model.dart';
import 'package:mobile1_flutter_coding_test/shared/const/api_endpoints.dart';

class ChatRoomDatasource {
  Future<ResponseResult<ChatRoomListModel>> getChatRooms() async {
    final response = await RequestApi.request(ApiEndpoints.rooms,
        fromJson: ChatRoomListModel.fromJson);
    return response;
  }
}
