import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/di/viewmodel_provider.dart';
import 'package:mobile1_flutter_coding_test/presentation/screen/chat/chat_screen.dart';

class MeetingListScreen extends ConsumerStatefulWidget {
  const MeetingListScreen({super.key});

  @override
  ConsumerState<MeetingListScreen> createState() => _MeetingListScreenState();
}

class _MeetingListScreenState extends ConsumerState<MeetingListScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 현재 프레임 이후에 실행하도록 지연시켜 build가 완료된 후 실행
    Future.microtask(() {
      // microtask 없이 호출할 경우 생명주기 중 State를 변경하여 에러
      ref.read(meetingListViewModelProvider.notifier).loadMeetings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(meetingListViewModelProvider);
    return Stack(
      children: [
        ListView.builder(
          itemCount: state.items.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(state.items[index].roomId),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChatScreen(roomId: state.items[index].roomId),
                ),
              );
            },
          ),
        ),
        // if (state.isLoading)
        //   const Center(
        //     child: IgnorePointer(
        //       child: CircularProgressIndicator(),
        //     ),
        //   ),
      ],
    );
  }
}
