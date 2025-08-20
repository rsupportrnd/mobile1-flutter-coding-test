import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile1_flutter_coding_test/core/injector.dart';
import 'package:mobile1_flutter_coding_test/repository/user_repositoy.dart';

import 'bloc/home_bloc.dart';
import '../users/user_list_screen.dart';
import '../rooms/room_list_screen.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(const HomeEvent.start()),
      child: const _HomeShellView(),
    );
  }
}

class _HomeShellView extends StatelessWidget {
  const _HomeShellView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Mobile1 Chat'),
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            elevation: 0,
            actions: [
              // 현재 유저 세션 표시
              if (state.currentUserName.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person,
                        size: 16,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        state.currentUserName,
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              // 유저 전환 드롭다운
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.swap_horiz,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onSelected: (userId) {
                  context.read<HomeBloc>().add(HomeEvent.switchUser(userId));
                },
                itemBuilder: (context) => injector<UserRepository>().users
                    .map(
                      (e) =>
                          PopupMenuItem(value: e.userId, child: Text(e.name)),
                    )
                    .toList(),
              ),
            ],
          ),
          body: IndexedStack(
            index: state.navIdx,
            children: [
              Container(color: Colors.red),
              Container(color: Colors.blue),
              // UserListScreen(),
              // RoomListScreen()],
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: state.navIdx,
            onDestinationSelected: (index) {
              context.read<HomeBloc>().add(HomeEvent.move(index));
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: '사용자',
              ),
              NavigationDestination(
                icon: Icon(Icons.chat_bubble_outline),
                selectedIcon: Icon(Icons.chat_bubble),
                label: '회의',
              ),
            ],
          ),
        );
      },
    );
  }
}
