import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/meeting_room_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/meeting_room_list/provider/meeting_room_list_provider.dart';

mixin MeetingRoomState {
  AsyncValue<MeetingRoomListResponseEntity> watchMeetingRoomListProvider(
          {required WidgetRef ref}) =>
      ref.watch(meetingRoomListProvider);
}
