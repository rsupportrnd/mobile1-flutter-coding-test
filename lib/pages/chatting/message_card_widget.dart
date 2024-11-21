import 'package:intl/intl.dart';
import 'package:mobile1_flutter_coding_test/index.dart';

class MessageCardWidget extends StatelessWidget {
  final MessageModel message;

  const MessageCardWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isMe = message.sender == "developer";
    return ListTile(
      title: Text(message.sender, style: isMe? Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.blue) : null,),
      subtitle: Text(message.content.toString(), softWrap: true,),
      isThreeLine: true,
      trailing: Text(
        DateFormat('HH:mm')
            .format(DateTime.parse(message.timestamp.toString())),
      ),
    );
  }
}
