part of '../meeting_room_list_screen.dart';

class _MeetingRoomListView extends BaseView {
  final MeetingRoomListResponseEntity meetingRoomListEntity;
  const _MeetingRoomListView({required this.meetingRoomListEntity});

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final MeetingRoomEntity meetingRoom =
            meetingRoomListEntity.meetingRooms[index];
        final LastMessageEntity lastMessage = meetingRoom.lastMessage;
        final String formattedTime =
            lastMessage.timestamp.updateLastMessageDateFormat;

        return ListTile(
          key: ValueKey(meetingRoom.roomId),
          onTap: () {
            context.pushNamed(
              MessageScreen.route,
              pathParameters: {'roomId': meetingRoom.roomId},
              extra: {
                'roomId': meetingRoom.roomId,
                'roomName': meetingRoom.roomName,
              },
            );
          },
          leading:
              UserAvatarWidget(profilePictureUrl: meetingRoom.thumbnailImage),
          title: Text(meetingRoom.roomName),
          subtitle: Text(
            '${lastMessage.sender}: ${lastMessage.content}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            formattedTime,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(height: 1);
      },
      itemCount: meetingRoomListEntity.meetingRooms.length,
    );
  }
}
