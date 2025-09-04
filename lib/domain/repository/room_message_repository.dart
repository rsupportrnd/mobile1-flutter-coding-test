import 'package:mobile1_flutter_coding_test/core/network/response_result.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';

abstract class RoomMessageRepository {
  Future<ResponseResult<Map<String, List<Message>>>> getRoomMessages();
  Future<void> saveRoomMessagesToStorage(
      Map<String, List<Map<String, dynamic>>> messages);
  Future<void> addMessageToStorage(String roomId, Message message);
}
