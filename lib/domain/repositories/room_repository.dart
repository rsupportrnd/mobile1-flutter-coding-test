import 'package:mobile1_flutter_coding_test/domain/entities/room_entity.dart';

abstract class RoomRepository {
  Future<List<RoomEntity>> getRooms();
}
