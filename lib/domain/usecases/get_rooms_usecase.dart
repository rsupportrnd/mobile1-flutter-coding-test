import 'package:mobile1_flutter_coding_test/domain/entities/room_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/room_repository.dart';

class GetRoomsUseCase {
  final RoomRepository repository;

  GetRoomsUseCase(this.repository);

  Future<List<RoomEntity>> call() async {
    return await repository.getRooms();
  }
}
