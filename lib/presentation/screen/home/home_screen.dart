import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/di/viewmodel_provider.dart';
import 'package:mobile1_flutter_coding_test/presentation/screen/meeting_list/meeting_list_screen.dart';
import 'package:mobile1_flutter_coding_test/presentation/screen/user_list/user_list_screen.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/home/home_state.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();

    _loadFuture = ref.read(homeViewModelProvider.notifier).loadData();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(homeViewModelProvider).tab;
    final screens = {
      MainTab.users: const UserListScreen(),
      MainTab.meetings: const MeetingListScreen(),
    };
    return Scaffold(
      body: FutureBuilder(
          future: _loadFuture,
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.done) {
              if (asyncSnapshot.hasError) {
                return const Center(child: Text("오류가 발생하였습니다."));
              }
              return Center(
                  child: screens[selectedTab] ??
                      const Text("화면을 불러오는 중 오류가 발생하였습니다."));
            } else {
              return const Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("데이터 불러오는중..."),
                  SizedBox(height: 10),
                  IgnorePointer(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ));
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
            BottomNavigationBarItem(
                icon: Icon(Icons.meeting_room), label: 'Meetings'),
          ],
          currentIndex: MainTab.values.indexOf(selectedTab),
          onTap: (index) => ref
              .read(homeViewModelProvider.notifier)
              .changeTab(tab: MainTab.values[index])),
    );
  }
}
