import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/presentation/provider/viewmodel_provider.dart';
import 'package:mobile1_flutter_coding_test/presentation/screen/meeting_list/meeting_list_screen.dart';
import 'package:mobile1_flutter_coding_test/presentation/screen/user_list/user_list_screen.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/home/home_viewmodel.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(homeVIewModelProvider);
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
        onTap: (index) => ref.read(homeVIewModelProvider.notifier).state =
            MainTab.values[index],
      ),
    );
  }
}
