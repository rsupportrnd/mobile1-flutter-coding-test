import 'package:mobile1_flutter_coding_test/data/datasource/local_database_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/room_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/mapper/room_mapper.dart';
import 'package:mobile1_flutter_coding_test/data/utils/safe_call.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/room.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  RoomRepositoryImpl(
      {required RoomDataSource dataSource,
      required LocalDatabaseDataSource localDatabaseDataSource})
      : _dataSource = dataSource,
        _localDatabaseDataSource = localDatabaseDataSource;
  final RoomDataSource _dataSource;
  final LocalDatabaseDataSource _localDatabaseDataSource;

  @override
  Future<Result<List<ChatRoom>>> getRooms() async {
    return await safeCall(() async {
      final response = await _dataSource.getRooms();
      final result =
          response.chatRooms.map((element) => element.toEntity()).toList();
      await insertRooms(rooms: result);
      return result;
    });
  }

  @override
  Future<Result<void>> insertRooms({required List<ChatRoom> rooms}) async {
    return await safeCall(() async {
      await _localDatabaseDataSource.insertRooms(
          rooms: rooms.map((element) => element.toModel()).toList());
    });
  }
}
