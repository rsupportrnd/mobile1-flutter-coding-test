import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/meeting/widget/meeting_room_tile.dart';
import 'package:provider/provider.dart';

import '../widgets/future_handler.dart';
import 'meeting_room_list_viewmodel.dart';

class MeetingRoomListView extends StatefulWidget {
  const MeetingRoomListView({super.key});

  @override
  State<MeetingRoomListView> createState() => _MeetingRoomListViewState();
}

class _MeetingRoomListViewState extends State<MeetingRoomListView> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MeetingRoomListViewModel>(context, listen: false)
          .fetchMeetingRoomList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MeetingRoomListViewModel>(
      builder: (context, provider, child) {
        return  FutureHandler(
          isLoading: provider.isLoading,
          isError: provider.isError,
          errorMessage: provider.errorMessage,
          onRetry: provider.onRetry,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: provider.meetingRoomList.length,
                  itemBuilder: (context, index) => MeetingRoomTile(
                    meetingRoom: provider.meetingRoomList[index],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
