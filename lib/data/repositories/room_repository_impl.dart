import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/data/datasources/user_local_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/datasources/user_remote_datasource.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/room_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  RoomRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<List<RoomEntity>> getRooms() async {
    final localRooms = await localDataSource.getRooms();
    if (localRooms.isNotEmpty) {
      return localRooms.map((e) => RoomEntity.fromModel(e)).toList();
    }

    final model = await remoteDataSource.getRooms();
    await localDataSource.saveRooms(model);
    return model.map((e) => RoomEntity.fromModel(e)).toList();
  }
}
