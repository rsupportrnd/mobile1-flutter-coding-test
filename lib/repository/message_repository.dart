import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/api/local/local_data_source.dart';
import 'package:mobile1_flutter_coding_test/api/network/end_point.dart';
import 'package:mobile1_flutter_coding_test/api/network/network_data_source.dart';
import 'package:mobile1_flutter_coding_test/core/storage/storage.dart';
import 'package:mobile1_flutter_coding_test/core/storage/storage_keys.dart';
import 'package:mobile1_flutter_coding_test/models/chat_message.dart';

class MessageRepository {
  MessageRepository(this._dio, this._storage)
    : _local = LocalDataSource(),
      _net = NetworkDataSource(_dio);

  final Dio _dio;
  final Storage _storage;
  final LocalDataSource _local;
  final NetworkDataSource _net;

  /// 메모리 캐시
  final Map<String, List<ChatMessage>> _cache = {};

  List<ChatMessage> messagesOf(String roomId) =>
      List.unmodifiable(_cache[roomId] ?? const []);

  Future<void> load() async {
    // 퍼스트런이면 시딩
    final seeded = (_storage.get(StorageKeys.firstSeedDone) as bool?) ?? false;
    if (!seeded) {
      await _seedFirstRun();
      await _storage.set(StorageKeys.firstSeedDone, true); // 여기까지 와서야 퍼스트런 체크
    }
    // Hive -> 캐시
    _cache.clear();
    for (final k in _storage.keys()) {
      if (k is String && k.startsWith('msgs:')) {
        final roomId = k.substring('msgs:'.length);
        final raw = _storage.get(k);
        final list = <ChatMessage>[];

        if (raw is List) {
          for (final e in raw) {
            if (e is Map) {
              // key를 String으로 고정
              final m = e.map((key, value) => MapEntry(key.toString(), value));
              list.add(ChatMessage.fromJson(m)); // Map<String, dynamic>
            }
          }
        }

        int ts(ChatMessage m) =>
            DateTime.tryParse(m.timestamp)?.millisecondsSinceEpoch ?? 0;

        list.sort((a, b) => ts(a).compareTo(ts(b)));
        _cache[roomId] = list;
      }
    }
  }

  Future<void> _seedFirstRun() async {
    List<dynamic> list;
    try {
      list = await _net.fetchList(ApiEndpoints.messages, rootKey: 'messages');
    } catch (_) {
      list = await _local.loadMessages();
    }

    // 방별 그룹 & 저장
    final byRoom = <String, List<Map<String, dynamic>>>{};
    for (final e in list) {
      if (e is Map) {
        final m = Map<String, dynamic>.from(
          e.map((k, v) => MapEntry(k.toString(), v)),
        );
        final msg = ChatMessage.fromJson(m);
        byRoom.putIfAbsent(msg.roomId, () => []).add(msg.toJson());
      } else {}
    }
    for (final entry in byRoom.entries) {
      final roomId = entry.key;
      final arr = entry.value
        ..sort(
          (a, b) => DateTime.parse(
            a['timestamp'],
          ).compareTo(DateTime.parse(b['timestamp'])),
        );
      await _storage.set(StorageKeys.roomMessages(roomId), arr);

      // roomMeta 갱신
      final last = arr.isNotEmpty ? arr.last : null;
      if (last != null) {
        await _storage.set(StorageKeys.roomMeta(roomId), {
          'lastMessageId': last['messageId'],
          'lastMessageAt': last['timestamp'],
        });
      }
    }
  }

  Future<void> add(ChatMessage m) async {
    final list = List<ChatMessage>.from(_cache[m.roomId] ?? const []);
    list.add(m);
    list.sort(
      (a, b) =>
          DateTime.parse(a.timestamp).compareTo(DateTime.parse(b.timestamp)),
    );
    _cache[m.roomId] = list;

    // 저장
    await _storage.set(
      StorageKeys.roomMessages(m.roomId),
      list.map((e) => e.toJson()).toList(),
    );
    // last 갱신
    final last = list.last;
    await _storage.set(StorageKeys.roomMeta(m.roomId), {
      'lastMessageId': last.messageId,
      'lastMessageAt': last.timestamp,
    });
  }

  Future<bool> update({
    required String roomId,
    required String messageId,
    required Map<String, dynamic> patch,
  }) async {
    final list = List<ChatMessage>.from(_cache[roomId] ?? const []);
    final idx = list.indexWhere((e) => e.messageId == messageId);
    if (idx < 0) return false;

    final old = list[idx].toJson();
    final merged = {...old, ...patch};
    list[idx] = ChatMessage.fromJson(merged);
    list.sort(
      (a, b) =>
          DateTime.parse(a.timestamp).compareTo(DateTime.parse(b.timestamp)),
    );
    _cache[roomId] = list;

    await _storage.set(
      StorageKeys.roomMessages(roomId),
      list.map((e) => e.toJson()).toList(),
    );
    final last = list.last;
    await _storage.set(StorageKeys.roomMeta(roomId), {
      'lastMessageId': last.messageId,
      'lastMessageAt': last.timestamp,
    });
    return true;
  }

  Future<bool> remove({
    required String roomId,
    required String messageId,
  }) async {
    final list = List<ChatMessage>.from(_cache[roomId] ?? const []);
    final removed = list.any((e) => e.messageId == messageId);
    if (!removed) return false;

    list.sort(
      (a, b) =>
          DateTime.parse(a.timestamp).compareTo(DateTime.parse(b.timestamp)),
    );
    _cache[roomId] = list;

    await _storage.set(
      StorageKeys.roomMessages(roomId),
      list.map((e) => e.toJson()).toList(),
    );
    if (list.isNotEmpty) {
      final last = list.last;
      await _storage.set(StorageKeys.roomMeta(roomId), {
        'lastMessageId': last.messageId,
        'lastMessageAt': last.timestamp,
      });
    }
    return true;
  }

  // 읽음 마킹
  Future<void> markRead({
    required String roomId,
    required String userId,
    required DateTime at,
  }) async {
    await _storage.set(StorageKeys.readReceipt(roomId, userId), {
      'lastReadAt': at.toIso8601String(),
    });
  }

  Future<int> unreadCount({
    required String roomId,
    required String userId,
  }) async {
    final rr = (_storage.get(StorageKeys.readReceipt(roomId, userId)) as Map?)
        ?.cast<String, dynamic>();
    final lastReadAt = rr != null && rr['lastReadAt'] != null
        ? DateTime.parse(rr['lastReadAt'] as String)
        : DateTime.fromMillisecondsSinceEpoch(0);

    final list = List<ChatMessage>.from(_cache[roomId] ?? const []);
    return list
        .where((m) => DateTime.parse(m.timestamp).isAfter(lastReadAt))
        .length;
  }

  // toDo : 방별 스트림 구독 => 서버측 수신시 stream을 통해 업데이트 가능
  Stream<List<ChatMessage>> watchByRoom(String roomId) {
    return _storage.watch(key: StorageKeys.roomMessages(roomId)).asyncMap((
      _,
    ) async {
      final raw =
          ((_storage.get(StorageKeys.roomMessages(roomId)) as List?) ??
                  const [])
              .cast<Map>()
              .map((m) => ChatMessage.fromJson(Map<String, dynamic>.from(m)))
              .toList()
            ..sort(
              (a, b) => DateTime.parse(
                a.timestamp,
              ).compareTo(DateTime.parse(b.timestamp)),
            );
      _cache[roomId] = raw;
      return List<ChatMessage>.from(raw);
    });
  }
}
