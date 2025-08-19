import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/api/local/local_data_source.dart';
import 'package:mobile1_flutter_coding_test/api/network/end_point.dart';
import 'package:mobile1_flutter_coding_test/api/network/network_data_source.dart';
import 'package:mobile1_flutter_coding_test/core/storage/storage.dart';
import 'package:mobile1_flutter_coding_test/core/storage/storage_keys.dart';
import 'package:mobile1_flutter_coding_test/models/room.dart';

class RoomRepository {
  RoomRepository(this._dio, this._storage)
      : _local = LocalDataSource(),
        _net = NetworkDataSource(_dio);

  final Dio _dio;
  final Storage _storage;
  final LocalDataSource _local;
  final NetworkDataSource _net;

  final List<Room> _rooms = [];
  List<Room> get rooms => List.unmodifiable(_rooms);

  Future<void> load() async {
    // 퍼스트런
    final seeded = (_storage.get(StorageKeys.firstSeedDone) as bool?) ?? false;
    if (!seeded) {
      await _seedFirstRun();
      await _storage.set(StorageKeys.firstSeedDone, true);
    }
    _rooms
      ..clear()
      ..addAll(_scanRoomsFromStorage());
  }

  Future<void> _seedFirstRun() async {
    List<dynamic> list;
    try {
      list = await _net.fetchList(ApiEndpoints.rooms, rootKey: 'chatRooms');
    } catch (_) {
      list = await _local.loadRooms();
    }
    for (final m in list.cast<Map<String, dynamic>>()) {
      final r = Room.fromJson(m);
      await _storage.set(StorageKeys.room(r.roomId), r.toJson());
    }
  }

  List<Room> _scanRoomsFromStorage() {
    final out = <Room>[];
    for (final k in _storage.keys()) {
      if (k is String && k.startsWith('room:')) {
        final map = (_storage.get(k) as Map?)?.cast<String, dynamic>();
        if (map != null) out.add(Room.fromJson(map));
      }
    }
    return out;
  }

  Room? getById(String roomId) =>
      _rooms.firstWhere((r) => r.roomId == roomId, orElse: () => Room());
}
