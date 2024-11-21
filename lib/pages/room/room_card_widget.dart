import 'package:intl/intl.dart';
import 'package:mobile1_flutter_coding_test/index.dart';

class RoomCardWidget extends StatelessWidget {
  final RoomModel room;

  const RoomCardWidget({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    double imageSize= 50;
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(imageSize),
        child: Image.network(
          room.thumbnailImage,
          width: imageSize,
          errorBuilder: (_, object, stacktrace) =>  Icon(
            Icons.error,
            size: imageSize,
            color: Colors.red,


          ),
        ),
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
