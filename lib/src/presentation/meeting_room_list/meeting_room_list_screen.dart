import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/core.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/presentation.dart';

part 'view/meeting_room_list_view.dart';

class MeetingRoomListScreen extends BaseScreen
    with MeetingRoomState, MeetingRoomEvent {
  const MeetingRoomListScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return watchMeetingRoomListProvider(ref: ref).when(
      data: (MeetingRoomListResponseEntity meetingRoomListEntity) {
        return _MeetingRoomListView(
            meetingRoomListEntity: meetingRoomListEntity);
      },
      error: (error, stackTrace) {
        return ErrorView(
          appException:
              error is AppException ? error : const UnknownException(),
          onPressed: () async {
            await getMeetingRoomList(ref);
          },
        );
      },
      loading: () => const LoadingIndicator(),
    );
  }

  @override
  PreferredSizeWidget? renderAppBar(BuildContext context, WidgetRef ref) {
    return const CustomAppBar(
      title: MeetingRoomStringConstant.title,
      showDivider: true,
    );
  }
}
