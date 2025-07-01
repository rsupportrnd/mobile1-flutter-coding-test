import 'package:mobile1_flutter_coding_test/data/datasources/user_remote_datasource.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/room_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final UserRemoteDataSource remoteDataSource;

  RoomRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<RoomEntity>> getRooms() async {
    final model = await remoteDataSource.getRooms();
    return model.map((e) => RoomEntity.fromModel(e)).toList();
  }

  @override
  Future<List<MessageEntity>> getMessages() async {
    final model = await remoteDataSource.getMessages();
    return model.map((e) => MessageEntity.fromModel(e)).toList();
  }
}
