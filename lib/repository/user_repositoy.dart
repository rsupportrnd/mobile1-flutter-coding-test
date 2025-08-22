import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile1_flutter_coding_test/api/network/end_point.dart';
import 'package:mobile1_flutter_coding_test/api/local/local_data_source.dart';
import 'package:mobile1_flutter_coding_test/api/network/network_data_source.dart';
import 'package:mobile1_flutter_coding_test/core/storage/storage.dart';
import 'package:mobile1_flutter_coding_test/core/storage/storage_keys.dart';
import 'package:mobile1_flutter_coding_test/models/app_user.dart';
import 'package:mobile1_flutter_coding_test/repository/utils.dart';

class UserRepository {
  UserRepository(this._dio, this._storage)
    : _local = LocalDataSource(),
      _net = NetworkDataSource(_dio);

  final Dio _dio;
  final Storage _storage;
  final LocalDataSource _local;
  final NetworkDataSource _net;

  final List<AppUser> _users = [];
  String? _lastUserId;

  List<AppUser> get users => List.unmodifiable(_users);
  String? get lastUserId => _lastUserId;

  AppUser? get lastSession {
    if (_lastUserId == null) return null;
    for (final u in _users) {
      if (u.userId == _lastUserId) return u;
    }
    return null;
  }

  Future<void> load() async {
    // 최초 실행
    final seeded = (_storage.get(StorageKeys.firstSeedDone) as bool?) ?? false;
    if (!seeded) {
      await _seedFirstRun();
    }
    // Hive -> 메모리 캐시 로드
    _users
      ..clear()
      ..addAll(_scanUsersFromStorage());
    // lastUserId 보정
    final last = (_storage.get(StorageKeys.lastUserId) as String?) ?? '';
    if (last.isNotEmpty && _users.any((u) => u.userId == last)) {
      _lastUserId = last;
    } else if (_users.isNotEmpty) {
      _lastUserId = _users.first.userId;
      await _storage.set(StorageKeys.lastUserId, _lastUserId);
    }
  }

  Future<void> setLastSession(String userId) async {
    if (_users.any((u) => u.userId == userId)) {
      _lastUserId = userId;
      await _storage.set(StorageKeys.lastUserId, userId);
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
    for (final e in list) {
      if (e is Map) {
        final m = Map<String, dynamic>.from(
          e.map((k, v) => MapEntry(k.toString(), v)),
        );
        final u = AppUser.fromJson(m);
        await _storage.set(StorageKeys.user(u.userId), u.toJson());
      } else {
        debugPrint('no map: $e');
      }
    }
  }

  List<AppUser> _scanUsersFromStorage() {
    final result = <AppUser>[];
    for (final k in _storage.keys()) {
      if (k is String && k.startsWith('user:')) {
        final raw = _storage.get(k);
        if (raw is Map) {
          final raw = _storage.get(k);
          final m = toStringKeyMap(raw);
          result.add(AppUser.fromJson(m));
        }
      }
    }
    return result;
  }

  AppUser? getById(String userId) => _users.firstWhere(
    (u) => u.userId == userId,
    orElse: () => AppUser(userId: "123123"),
  );
}
