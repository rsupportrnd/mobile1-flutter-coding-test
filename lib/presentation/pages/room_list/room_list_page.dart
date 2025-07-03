import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/locator/locator.dart';
import 'package:mobile1_flutter_coding_test/common/viewmodel/viewmodel_state.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/room_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_rooms_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/post_room_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodels/room_list_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/widgets/room_tile.dart';
import 'package:mobile1_flutter_coding_test/routes/app_router.gr.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class RoomListPage extends StatelessWidget {
  const RoomListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomListViewModel(
        getRoomsUseCase: locator<GetRoomsUseCase>(),
        postRoomMessageUseCase: locator<PostRoomMessageUseCase>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('회의 목록'),
        ),
        body: Consumer<RoomListViewModel>(
          builder: (context, viewModel, child) {
            return switch (viewModel.roomsState) {
              ViewModelStateLoading<List<RoomEntity>>() =>
                const Center(child: CircularProgressIndicator()),
              ViewModelStateError<List<RoomEntity>> error => Center(child: Text(error.error)),
              ViewModelStateSuccess<List<RoomEntity>> success => _RoomList(rooms: success.data),
            };
          },
        ),
      ),
    );
  }
}

class _RoomList extends StatelessWidget {
  final List<RoomEntity> rooms;
  const _RoomList({required this.rooms});

  @override
  Widget build(BuildContext context) {
    final sortedRooms = rooms.sortedBy((room) => room.lastMessage.timestamp).reversed.toList();

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 120),
          sliver: SliverList.builder(
            itemCount: sortedRooms.length,
            itemBuilder: (context, index) {
              final room = sortedRooms[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => routeToDetail(context, room),
                    child: RoomTile(room: room),
                  ),
                  SizedBox(height: 8),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  void routeToDetail(
    BuildContext context,
    RoomEntity room,
  ) {
    context.router.push(RoomRoute(roomId: room.roomId, roomName: room.roomName));
  }
}
