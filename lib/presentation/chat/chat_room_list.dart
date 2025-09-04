import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/presentation/chat/component/chat_room_card.dart';
import 'package:mobile1_flutter_coding_test/presentation/chat/view_model/chat_room_view_model.dart';
import 'package:mobile1_flutter_coding_test/presentation/user/viewModel/user_viewmodel.dart';

class ChatRoomList extends ConsumerWidget {
  const ChatRoomList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const horizontalPadding = 16.0;
    final state = ref.watch(chatRoomViewModelProvider);
    return state.when(data: (data) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "회의 목록",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.chatRooms.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 8,
                  ),
                  child: ChatRoomCard(
                    chatRoom: data.chatRooms[index],
                    participantUsers: data.participantUsers,
                  ),
                );
              },
            ),
          ),
        ],
      );
    }, error: (error, stackTrace) {
      return Text(error.toString());
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}
