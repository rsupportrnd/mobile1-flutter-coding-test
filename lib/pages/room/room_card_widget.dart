import 'package:intl/intl.dart';
import 'package:mobile1_flutter_coding_test/index.dart';

class RoomCardWidget extends StatelessWidget {
  final RoomModel room;

  const RoomCardWidget({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(room.thumbnailImage),
      ),
      title: Text(room.roomName),
      subtitle: Text(
        room.lastMessage.content,
        maxLines: 2,
      ),
      isThreeLine: false,
      trailing: Text(
          '⏱️${context.read<RoomListCubit>().convertFormatTimeDiff(room.lastMessage.timestamp)}'),
      onTap: () {
        GoRouter.of(context).push('${AppPath.chatting.toPath}/${room.roomId}');
      },
    );
  }
}
