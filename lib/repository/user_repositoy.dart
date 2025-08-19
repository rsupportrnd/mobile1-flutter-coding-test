import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/api/network/end_point.dart';
import 'package:mobile1_flutter_coding_test/api/local/local_data_source.dart';
import 'package:mobile1_flutter_coding_test/api/network/network_data_source.dart';
import 'package:mobile1_flutter_coding_test/core/storage/storage.dart';
import 'package:mobile1_flutter_coding_test/core/storage/storage_keys.dart';
import 'package:mobile1_flutter_coding_test/models/app_user.dart';

class UserRepository {
  UserRepository(this._dio, this._storage)
      : _local = LocalDataSource(),
        _net = NetworkDataSource(_dio);

  final Dio _dio;
  final Storage _storage;
  final LocalDataSource _local;
  final NetworkDataSource _net;

  final List<AppUser> _users = [];

  List<AppUser> get users => List.unmodifiable(_users);

  Future<void> load() async {
    // 최초 실행
    final seeded = (_storage.get(StorageKeys.firstSeedDone) as bool?) ?? false;
    if (!seeded) {
      await _seedFirstRun();
      await _storage.set(StorageKeys.firstSeedDone, true);
    }
    // Hive -> 메모리 캐시 로드
    _users
      ..clear()
      ..addAll(_scanUsersFromStorage());
    // lastUserId 보정
    final last = (_storage.get(StorageKeys.lastUserId) as String?) ?? '';
    if (last.isEmpty && _users.isNotEmpty) {
      await _storage.set(StorageKeys.lastUserId, _users.first.userId);
    }
  }

  Future<void> _seedFirstRun() async {
    // 원격 진행후 실패 로컬 폴백
    List<dynamic> list;
    try {
      list = await _net.fetchList(ApiEndpoints.users, rootKey: 'users');
    } catch (_) {
      list = await _local.loadUsers();
    }
    // user:$id 로 저장
    for (final m in list.cast<Map<String, dynamic>>()) {
      final u = AppUser.fromJson(m);
      await _storage.set(StorageKeys.user(u.userId), u.toJson());
    }
  }

  List<AppUser> _scanUsersFromStorage() {
    final result = <AppUser>[];
    for (final k in _storage.keys()) {
      if (k is String && k.startsWith('user:')) {
        final map = (_storage.get(k) as Map?)?.cast<String, dynamic>();
        if (map != null) result.add(AppUser.fromJson(map));
      }
    }
    return result;
  }

  AppUser? getById(String userId) =>
      _users.firstWhere((u) => u.userId == userId,
          orElse: () => AppUser(userId: "123123"));
}
