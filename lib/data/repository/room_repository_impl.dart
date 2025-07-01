import 'package:mobile1_flutter_coding_test/data/datasource/room_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/mapper/room_mapper.dart';
import 'package:mobile1_flutter_coding_test/data/utils/safe_call.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/room.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  RoomRepositoryImpl({required RoomDataSource dataSource})
      : _dataSource = dataSource;
  final RoomDataSource _dataSource;

  @override
  Future<Result<List<ChatRoom>>> getRooms() async {
    return await safeCall(() async {
      final response = await _dataSource.getRooms();
      return response.chatRooms.map((element) => element.toEntity()).toList();
    });
  }
}
