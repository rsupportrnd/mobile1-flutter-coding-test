import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/presentation/provider/viewmodel_provider.dart';
import 'package:mobile1_flutter_coding_test/presentation/screen/chat/chat_screen.dart';

class MeetingListScreen extends ConsumerWidget {
  const MeetingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(meetingListViewModelProvider);
    return ListView.builder(
      itemCount: state.items.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(state.items[index].roomId),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ChatScreen(meetingName: state.items[index].roomId),
            ),
          );
        },
      ),
    );
  }
}
