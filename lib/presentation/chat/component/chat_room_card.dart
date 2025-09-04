import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/core/router/router.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/chat_room.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/presentation/chat/view_model/chat_room_list_view_model.dart';
import 'package:mobile1_flutter_coding_test/shared/extension/datetime_formatting.dart';
import 'package:mobile1_flutter_coding_test/shared/widgets/custom_card.dart';
import 'package:mobile1_flutter_coding_test/shared/widgets/profile.dart';

class ChatRoomCard extends ConsumerWidget {
  const ChatRoomCard(
      {super.key, required this.chatRoom, required this.participantUsers});
  final ChatRoom chatRoom;
  final List<User> participantUsers;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(chatRoomListViewModelProvider.notifier);
    return CustomCard(
      onTap: () {
        context.push(Routes.chatting.path, extra: chatRoom);
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Profile(imageUrl: chatRoom.thumbnailImage),
            const Gap(8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chatRoom.roomName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text.rich(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: chatRoom.lastMessage?.content ?? '',
                              ),
                            ],
                          ),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      Text(
                        DateTime.tryParse(chatRoom.lastMessage?.timestamp ?? '')
                                ?.chatDisplayTime ??
                            '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Gap(4),
                  Text(
                    notifier
                        .getParticipants(
                            participants: chatRoom.participants,
                            userList: participantUsers)
                        .map((e) => e.name)
                        .join(', '),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
