import 'package:mobile1_flutter_coding_test/app/index.dart';

class RoomListScreen extends HookWidget {
  const RoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회의실 목록'),
      ),
      body: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          if (state is RoomLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoomLoadSuccess) {
            final rooms = state.rooms;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<RoomBloc>().add(RoomLoadRequested());
              },
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: rooms.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return RoomListItem(room: room);
                },
              ),
            );
          } else if (state is RoomLoadFailure) {
            return Center(child: Text('에러: ${state.errorMessage}'));
          } else {
            return const Center(child: Text('회의실 데이터를 불러올 수 없습니다.'));
          }
        },
      ),
    );
  }
}
