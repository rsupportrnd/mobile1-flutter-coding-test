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
  @override
  void initState() {
    super.initState();

    // 현재 프레임 이후에 실행하도록 지연시켜 build가 완료된 후 실행
    Future.microtask(() {
      // microtask 없이 호출할 경우 생명주기 중 State를 변경하여 에러
      // ref.read(homeViewModelProvider.notifier).loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(homeViewModelProvider).tab;
    final screens = {
      MainTab.users: const UserListScreen(),
      MainTab.meetings: const MeetingListScreen(),
    };
    return Scaffold(
      body: screens[selectedTab],
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
