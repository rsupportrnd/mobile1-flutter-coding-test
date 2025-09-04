import 'package:mobile1_flutter_coding_test/core/network/response_codes.dart';
import 'package:mobile1_flutter_coding_test/data/repository/chat_room_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/chat_room_repository.dart';
import 'package:mobile1_flutter_coding_test/presentation/chat/state/chat_room_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_room_view_model.g.dart';

@riverpod
class ChatRoomViewModel extends _$ChatRoomViewModel {
  late final ChatRoomRepository chatRoomRepository;

  @override
  Future<ChatRoomState> build() async {
    chatRoomRepository = ref.read(chatRoomRepositoryProvider);

    return await _loadChatRooms();
  }

  Future<ChatRoomState> _loadChatRooms() async {
    final response = await chatRoomRepository.getChatRooms();
    if (response.code != ResponseCodes.success) {
      throw Exception('실패 에러 코드 : ${response.code}');
    }
    return ChatRoomState(chatRooms: response.data ?? []);
  }
}
