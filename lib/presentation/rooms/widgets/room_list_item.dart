import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/core/injector.dart';
import 'package:mobile1_flutter_coding_test/core/routes.dart';
import 'package:mobile1_flutter_coding_test/models/app_user.dart';
import 'package:mobile1_flutter_coding_test/models/room.dart';
import 'package:mobile1_flutter_coding_test/repository/user_repositoy.dart';
import 'package:mobile1_flutter_coding_test/presentation/rooms/chatting/chat_view.dart';
import 'package:mobile1_flutter_coding_test/presentation/home/bloc/home_bloc.dart';

class RoomListItem extends StatelessWidget {
  const RoomListItem({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildThumbnail(),
      title: Text(
        room.roomName,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          _buildParticipants(),
          if (room.lastMessage != null) ...[
            const SizedBox(height: 4),
            _buildLastMessage(),
          ],
        ],
      ),
      onTap: () {
        final currentUserId = context.read<HomeBloc>().state.currentUserId;
        context.go(
          '${AppRoutes.home}/rooms/${room.roomId}/chat',
          extra: ChatArgs(currentUserId: currentUserId),
        );
      },
    );
  }

  Widget _buildThumbnail() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(color: Colors.grey[300]),
        child: Image.network(
          room.thumbnailImage ?? '',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.chat_bubble, size: 24, color: Colors.grey[600]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildParticipants() {
    final participants = room.participants;
    if (participants.isEmpty) return const SizedBox.shrink();

    return Row(
      children: [
        Icon(Icons.people, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          '${participants.length}명 참여',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildLastMessage() {
    final lastMessage = room.lastMessage;
    if (lastMessage == null) return const SizedBox.shrink();

    final content = lastMessage['content'] as String? ?? '';
    final sender =
        injector<UserRepository>().getById(
          lastMessage['sender'] as String? ?? '',
        ) ??
        AppUser(userId: '1234');
    return Row(
      children: [
        Text(
          '${sender.name}: ',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
