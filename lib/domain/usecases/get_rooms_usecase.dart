import 'dart:async';

import 'package:mobile1_flutter_coding_test/domain/entities/room_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/room_repository.dart';
import 'package:rxdart/rxdart.dart';

class GetRoomsUseCase {
  final RoomRepository repository;
  final _updateStream = PublishSubject<List<RoomEntity>>();

  GetRoomsUseCase(this.repository);

  StreamSubscription<List<RoomEntity>> get stream {
    StreamSubscription<List<RoomEntity>> sub = _updateStream.listen((event) {});
    return sub;
  }

  Future<List<RoomEntity>> call() async {
    final rooms = await repository.getRooms();
    _updateStream.add(rooms);
    return rooms;
  }

  void dispose() {
    _updateStream.close();
  }
}
