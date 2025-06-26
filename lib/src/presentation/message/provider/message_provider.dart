import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile1_flutter_coding_test/src/core/constant/string_constant/hive_string_constant.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/message_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/domain/usecase/meeting_room_usecase.dart';

class MessageListNotifier
    extends StateNotifier<AsyncValue<List<MessageEntity>>> {
  final Ref _ref;
  final String _roomId;

  MessageListNotifier({required Ref ref, required String roomId})
      : _ref = ref,
        _roomId = roomId,
        super(const AsyncLoading()) {
    loadMessages();
  }

  Future<void> loadMessages() async {
    try {
      final box = Hive.box(HiveStringConstant.messages);
      final List<dynamic>? stored = box.get(_roomId) as List<dynamic>?;
      List<MessageEntity> local = [];
      if (stored != null) {
        local = stored
            .map((e) => MessageEntity.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }

      final MessageUseCase useCase = _ref.read(messageUseCaseProvider);
      final MessageListResponseEntity remote = await useCase.getMessageList();
      final List<MessageEntity> remoteMessages =
          remote.messages.where((m) => m.roomId == _roomId).toList();

      final Map<String, MessageEntity> merged = {
        for (var m in remoteMessages) m.messageId: m,
        for (var m in local) m.messageId: m,
      };
      final List<MessageEntity> messages = merged.values.toList()
        ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

      state = AsyncData(messages);
      await _save(messages);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> sendMessage(
      {required String sender, required String content}) async {
    final MessageEntity message = MessageEntity(
      roomId: _roomId,
      messageId: 'local-${DateTime.now().millisecondsSinceEpoch}',
      sender: sender,
      content: content,
      timestamp: DateTime.now(),
    );
    final List<MessageEntity> current = [...state.value ?? [], message];
    current.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    state = AsyncData(current);
    await _save(current);
  }

  Future<void> _save(List<MessageEntity> messages) async {
    final box = Hive.box('messages');
    await box.put(_roomId, messages.map((e) => e.toJson()).toList());
  }
}

final messageListProvider = StateNotifierProvider.family<MessageListNotifier,
    AsyncValue<List<MessageEntity>>, String>((ref, roomId) {
  return MessageListNotifier(ref: ref, roomId: roomId);
});
