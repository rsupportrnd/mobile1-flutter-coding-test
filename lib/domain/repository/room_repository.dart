import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/room.dart';

abstract class RoomRepository {
  Future<Result<List<ChatRoom>>> getRooms();
  Future<Result<void>> insertRooms({required List<ChatRoom> rooms});
}
