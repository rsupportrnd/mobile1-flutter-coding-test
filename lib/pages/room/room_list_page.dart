import 'package:mobile1_flutter_coding_test/index.dart';

class RoomListPage extends StatefulWidget {
  const RoomListPage({super.key});

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<RoomListCubit>().fetchRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RoomListCubit, RoomListState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () =>
                const Center(child: CircularProgressIndicator.adaptive()),
            loaded: (rooms) => buildListViewContent(rooms),
            error: (e) => Center(child: Text("Error: $e")),
          );
        },
      ),
    );
  }

  Widget buildListViewContent(List<RoomModel> rooms) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
      child: ListView.builder(
          itemBuilder: (_, index) => RoomCardWidget(room: rooms[index]),
          itemCount: rooms.length),
    );
  }
}
