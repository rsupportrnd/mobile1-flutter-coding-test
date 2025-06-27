import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/provider/bottom_nav_index_provider.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/presentation.dart';

class HomeScreen extends HookConsumerWidget {
  static const route = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BottomNavTabType bottomNavTabIndex =
        ref.watch(bottomNavIndexProviderProvider);

    final List<Widget> screens = [
      const UserListScreen(),
      const MeetingRoomListScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: bottomNavTabIndex.index,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavTabIndex.index,
        onTap: (int idx) {
          ref
              .read(bottomNavIndexProviderProvider.notifier)
              .setTab(BottomNavTabType.values[idx]);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '유저',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room),
            label: '미팅룸',
          ),
        ],
      ),
    );
  }
}
