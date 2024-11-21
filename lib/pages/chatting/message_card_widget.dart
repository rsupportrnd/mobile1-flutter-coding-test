import 'package:intl/intl.dart';
import 'package:mobile1_flutter_coding_test/index.dart';

class MessageCardWidget extends StatelessWidget {
  final MessageModel message;

  const MessageCardWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    //chatting line widget with MessageModel
    return ListTile(
      title: Text(message.sender),
      subtitle: Text(message.content.toString()),
      trailing: Text(
        DateFormat('HH:mm')
            .format(DateTime.parse(message.timestamp.toString())),
      ),
    );
  }
}
