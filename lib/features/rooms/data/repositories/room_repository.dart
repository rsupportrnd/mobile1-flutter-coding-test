

import '../models/room.dart';

abstract class RoomRepository {
  Future<List<Room>> fetchRooms();
}
