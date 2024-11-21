import 'package:mobile1_flutter_coding_test/index.dart';
import 'package:mobile1_flutter_coding_test/local_database/objectbox.dart';

class BottomInputWidget extends StatefulWidget {
  final String roomId;

  const BottomInputWidget({super.key, required this.roomId});

  @override
  State<BottomInputWidget> createState() => _BottomInputWidgetState();
}

class _BottomInputWidgetState extends State<BottomInputWidget> {
  late TextEditingController _messageInputController;

  @override
  void initState() {
    super.initState();
    _messageInputController = TextEditingController();
  }

  @override
  void dispose() {
    _messageInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      height: INPUTBOX_HEIGHT,
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      width: double.infinity,
      child: TextFormField(
        controller: _messageInputController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: "Type a message",
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              MessageModel? inputMessageModel = context
                  .read<MessageListCubit>()
                  .createMessage(
                      roomId: widget.roomId,
                      content: _messageInputController.text);
              if (inputMessageModel != null) {
                context.read<MessageListCubit>().addMessage(inputMessageModel);
                getIt<ObjectBox>().saveMessage(inputMessageModel);
              }
              _messageInputController.clear();
            },
          ),
        ),
      ),
    );
  }
}
