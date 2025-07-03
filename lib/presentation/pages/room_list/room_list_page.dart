import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/%08locator/locator.dart';
import 'package:mobile1_flutter_coding_test/common/viewmodel/viewmodel_state.dart';
import 'package:mobile1_flutter_coding_test/data/datasources/user_local_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/datasources/user_remote_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/repositories/room_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/room_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_rooms_usecase.dart';
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
    return ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => routeToDetail(context, rooms[index]),
          child: RoomTile(room: rooms[index]),
        );
      },
    );
  }

  void routeToDetail(
    BuildContext context,
    RoomEntity room,
  ) {
    context.router.push(RoomRoute(roomId: room.roomId, roomName: room.roomName));
  }
}
