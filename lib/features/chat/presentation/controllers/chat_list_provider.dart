import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_room.dart';
import 'package:mobile1_flutter_coding_test/features/chat/domain/repositories/chat_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_list_provider.g.dart';

@riverpod
class ChatListController extends _$ChatListController {
  @override
  Future<List<ChatRoom>> build() async {
    return await _getChatRooms();
  }

  Future<List<ChatRoom>> _getChatRooms() async {
    return ref.read(chatRepositoryProvider).getChatRooms();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _getChatRooms());
  }
}