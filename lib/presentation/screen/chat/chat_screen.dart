import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/di/viewmodel_provider.dart';

class ChatScreen extends ConsumerWidget {
  final String meetingName;
  ChatScreen({super.key, required this.meetingName});

  final TextEditingController _controller = TextEditingController();

  void _sendMessage(BuildContext context, WidgetRef ref) {
    final text = _controller.text;
    ref.read(chatViewModelProvider.notifier).sendMessage(message: text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatViewModelProvider);
    return Scaffold(
      appBar: AppBar(title: Text(meetingName)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(state.items[index].messageId),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(context, ref),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
