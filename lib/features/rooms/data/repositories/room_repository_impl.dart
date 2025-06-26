
import '../datasources/room_remote_datasource.dart';
import '../models/room.dart';
import 'room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDataSource remoteDataSource;

  RoomRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Room>> fetchRooms() async {
    try {
    return await remoteDataSource.fetchRooms();
    } catch (e, stack) {
      rethrow;
    }
  }
}
