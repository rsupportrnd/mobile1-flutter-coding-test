import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/api/local/local_data_source.dart';
import 'package:mobile1_flutter_coding_test/api/network/end_point.dart';
import 'package:mobile1_flutter_coding_test/api/network/network_data_source.dart';
import 'package:mobile1_flutter_coding_test/core/storage/storage.dart';
import 'package:mobile1_flutter_coding_test/core/storage/storage_keys.dart';
import 'package:mobile1_flutter_coding_test/models/room.dart';
import 'package:mobile1_flutter_coding_test/repository/utils.dart';

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
    for (final e in list) {
      if (e is Map) {
        final m = Map<String, dynamic>.from(
          e.map((k, v) => MapEntry(k.toString(), v)),
        );
        final r = Room.fromJson(m);
        await _storage.set(StorageKeys.room(r.roomId), r.toJson());
      } else {}
    }
  }

  List<Room> _scanRoomsFromStorage() {
    final out = <Room>[];
    for (final k in _storage.keys()) {
      if (k is String && k.startsWith('room:')) {
        final raw = _storage.get(k);
        if (raw is Map) {
          final normalized = normalizeJson(raw) as Map<String, dynamic>;
          out.add(Room.fromJson(normalized));
        }
      }
    }
    return out;
  }

  Room? getById(String roomId) =>
      _rooms.firstWhere((r) => r.roomId == roomId, orElse: () => Room());
}
