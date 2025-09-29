import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_message.dart';
import 'package:mobile1_flutter_coding_test/features/chat/domain/repositories/chat_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_messages_provider.g.dart';

@riverpod
class ChatMessagesController extends _$ChatMessagesController {
  @override
  Future<List<ChatMessage>> build(String roomId) async {
    return await _getMessagesForRoom(roomId);
  }

  Future<List<ChatMessage>> _getMessagesForRoom(String roomId) async {
    return ref.read(chatRepositoryProvider).getMessagesForRoom(roomId);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    // roomId는 generated 코드에서 제공하는 매개변수
    state = await AsyncValue.guard(() => _getMessagesForRoom(roomId));
  }
}