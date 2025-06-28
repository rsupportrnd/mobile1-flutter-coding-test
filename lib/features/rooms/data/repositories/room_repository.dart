import 'package:mobile1_flutter_coding_test/app/index.dart';

abstract class RoomRepository {
  Future<List<Room>> fetchRooms();

  Future<void> saveLastMessage(String roomId, LastMessage lastMessage);
}
