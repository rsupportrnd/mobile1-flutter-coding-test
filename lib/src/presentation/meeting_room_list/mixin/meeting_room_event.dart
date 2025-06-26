import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/meeting_room_list/provider/meeting_room_list_provider.dart';

mixin class MeetingRoomEvent {
  Future<void> getMeetingRoomList(WidgetRef ref) =>
      ref.read(meetingRoomListProvider.notifier).getUserList();
}
