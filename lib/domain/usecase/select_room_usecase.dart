import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/room.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/room_repository.dart';

class SelectRoomUseCase {
  SelectRoomUseCase({required RoomRepository repository})
      : _repository = repository;
  final RoomRepository _repository;

  Future<Result<List<ChatRoom>>> call() async =>
      await _repository.selectRooms();
}
