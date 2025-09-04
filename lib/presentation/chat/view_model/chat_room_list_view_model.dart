import 'package:mobile1_flutter_coding_test/core/network/response_codes.dart';
import 'package:mobile1_flutter_coding_test/data/repository/chat_room_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/chat_room_repository.dart';
import 'package:mobile1_flutter_coding_test/presentation/chat/state/chat_room_state.dart';
import 'package:mobile1_flutter_coding_test/presentation/user/view_model/user_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_room_list_view_model.g.dart';

@riverpod
class ChatRoomListViewModel extends _$ChatRoomListViewModel {
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
    final userList = ref.read(userViewModelProvider).value?.users ?? [];

    return ChatRoomState(
        chatRooms: response.data ?? [], participantUsers: userList);
  }

  List<User> getParticipants(
      {required List<String> participants, required List<User> userList}) {
    return participants
        .map((e) => userList.firstWhere((user) => user.userId == e))
        .toList();
  }
}
