import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/features/chat/presentation/controllers/chat_list_provider.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/models/chat_room.dart';
import 'package:intl/intl.dart';

class ChatListPage extends ConsumerWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoomsAsync = ref.watch(chatListControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅목록'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () => ref.refresh(chatListControllerProvider),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: chatRoomsAsync.when(
        loading: () => buildLoadingState(),
        error: (error, stackTrace) {
          return buildErrorState(context, error, ref);
        },
        data: (chatRooms) => buildDataState(chatRooms, ref),
      ),
    );
  }

  Widget buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            '생성된 채팅방이 없습니다',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildErrorState(BuildContext context, Object error, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            '데이터를 불러오는 중 오류가 발생했습니다',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => ref.refresh(chatListControllerProvider),
            child: const Text('다시 시도'),
          ),
        ],
      ),
    );
  }

  Widget buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildDataState(List<ChatRoom> chatRooms, WidgetRef ref) {
    if (chatRooms.isEmpty) {
      return buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(chatListControllerProvider.notifier).refresh();
      },
      child: ListView.builder(
        itemCount: chatRooms.length,
        itemBuilder: (context, index) {
          final chatRoom = chatRooms[index];
          return ChatRoomTile(chatRoom: chatRoom);
        },
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final ChatRoom chatRoom;

  const ChatRoomTile({
    super.key,
    required this.chatRoom,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(chatRoom.thumbnailImage),
          onBackgroundImageError: (exception, stackTrace) {
            // 이미지 로드 실패 시 기본 아이콘 표시
          },
          child: chatRoom.thumbnailImage.isEmpty
              ? const Icon(Icons.chat_bubble)
              : null,
        ),
        title: Text(
          chatRoom.roomName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chatRoom.lastMessage.content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.people,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  '${chatRoom.participants.length}명',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  _formatTime(chatRoom.lastMessage.timestamp),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          // 채팅방으로 네비게이션 (push 방식으로 이전 상태 유지)
          context.push('/chat/${chatRoom.roomId}?roomName=${Uri.encodeQueryComponent(chatRoom.roomName)}');
        },
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp).inDays;

    if (difference == 0) {
      return DateFormat('HH:mm').format(timestamp);
    } else if (difference == 1) {
      return '어제';
    } else if (difference < 7) {
      return DateFormat('E').format(timestamp);
    } else {
      return DateFormat('MM/dd').format(timestamp);
    }
  }
}