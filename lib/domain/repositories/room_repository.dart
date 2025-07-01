import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/room_entity.dart';

abstract class RoomRepository {
  Future<List<RoomEntity>> getRooms();
  Future<List<MessageEntity>> getMessages();
}
