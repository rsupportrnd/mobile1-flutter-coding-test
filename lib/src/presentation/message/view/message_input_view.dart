part of '../message_screen.dart';

class _MessageInputView extends BaseView {
  final TextEditingController controller;
  final ValueChanged<String> onSend;

  const _MessageInputView({
    required this.controller,
    required this.onSend,
  });

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: MessageStringConstant.inputHint,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final text = controller.text.trim();
              if (text.isEmpty) return;
              onSend(text);
            },
          ),
        ],
      ),
    );
  }
}
