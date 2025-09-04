import 'package:mobile1_flutter_coding_test/core/network/response_result.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/chat_room.dart';

abstract class ChatRoomRepository {
  Future<ResponseResult<List<ChatRoom>>> getChatRooms();
}
