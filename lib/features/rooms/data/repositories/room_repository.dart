

import '../models/room.dart';

abstract class RoomRepository {
  Future<List<Room>> fetchRooms();

  Future<void> saveLastMessage(String roomId, LastMessage lastMessage);
}
