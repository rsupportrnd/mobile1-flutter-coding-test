import 'package:flutter/material.dart';

class ChatInputBarWidget extends StatefulWidget {
  final void Function(String) onSend;
  final FocusNode focusNode;

  const ChatInputBarWidget({Key? key, required this.onSend, required this.focusNode}) : super(key: key);

  @override
  State<ChatInputBarWidget> createState() => _ChatInputBarWidgetState();
}

class _ChatInputBarWidgetState extends State<ChatInputBarWidget> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend([String? submitted]) {
    final text = (submitted ?? _controller.text).trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: widget.focusNode,
              controller: _controller,
              onSubmitted: _handleSend, // 완료 버튼 누르면 호출
              decoration: const InputDecoration(
                hintText: '메시지 입력...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _handleSend,
          ),
        ],
      ),
    );
  }
}