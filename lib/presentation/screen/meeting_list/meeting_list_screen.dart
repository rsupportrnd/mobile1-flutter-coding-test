import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/di/viewmodel_provider.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/room.dart';
import 'package:mobile1_flutter_coding_test/presentation/screen/chat/chat_screen.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/utils.dart';

class MeetingListScreen extends ConsumerStatefulWidget {
  const MeetingListScreen({super.key});

  @override
  ConsumerState<MeetingListScreen> createState() => _MeetingListScreenState();
}

class _MeetingListScreenState extends ConsumerState<MeetingListScreen> {
  // 상위 위젯인 HomeScreen의 tab 상태가 변경될 때 마다 실행
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
    return ListView.builder(
      itemCount: state.items.length,
      itemBuilder: (context, index) => _roomTile(
        room: state.items[index],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(room: state.items[index]),
            ),
          ).then((_) {
            ref.read(meetingListViewModelProvider.notifier).loadMeetings();
          });
        },
      ),
    );
  }

  Widget _roomTile({required ChatRoom room, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      room.roomName,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      room.participants.length.toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  room.lastMessage.content,
                  style: const TextStyle(color: Colors.blueGrey),
                )
              ],
            ),
            const Spacer(),
            Text(
              Utils().formatMessageTime(room.lastMessage.timestamp),
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
