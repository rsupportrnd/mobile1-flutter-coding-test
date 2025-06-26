import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/exception/custom_exception.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/extension/data_time_extension.dart';
import 'package:mobile1_flutter_coding_test/src/core/constant/string_constant/meeting_room_string_constant.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/meeting_room_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/base/base_screen.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/base/base_view.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/component/custom_app_bar_widget.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/component/loading_indicator.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/component/user_avatar_widget.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/error_screen.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/meeting_room_list/mixin/meeting_room_event.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/meeting_room_list/mixin/meeting_room_state.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/message/message_screen.dart';

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
