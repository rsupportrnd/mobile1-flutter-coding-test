import 'package:mobile1_flutter_coding_test/index.dart';

class BottomInputWidget extends StatefulWidget {
  const BottomInputWidget({super.key});

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
      height: INPUT_BOX_HEIGHT,
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
              // MessageModel? inputMessageModel = context
              //     .read<MessageListCubit>()
              //     .createMessage(
              //         roomId: widget.roomId,
              //         content: _contentEditingController.text);
              // if (inputMessageModel != null) {
              //   context.read<MessageListCubit>().addMessage(inputMessageModel);
              //   objectBox.saveMessage(inputMessageModel);
              // }
              // _contentEditingController.clear();
            },
          ),
        ),
      ),
    );
  }
}
