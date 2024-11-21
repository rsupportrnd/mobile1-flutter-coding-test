import 'package:mobile1_flutter_coding_test/index.dart';

abstract class RoomRepository {
  Future<List<RoomModel>> fetchRooms();
}

