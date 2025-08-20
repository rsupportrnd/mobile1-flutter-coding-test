import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile1_flutter_coding_test/core/injector.dart';
import 'package:mobile1_flutter_coding_test/repository/user_repositoy.dart';
import 'package:mobile1_flutter_coding_test/presentation/rooms/bloc/rooms_bloc.dart';
import 'package:mobile1_flutter_coding_test/presentation/users/bloc/users_bloc.dart';

import 'bloc/home_bloc.dart';
import '../users/users_list_screen.dart';
import '../rooms/rooms_list_screen.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()..add(const HomeEvent.start())),
        BlocProvider(create: (_) => UsersBloc()..add(const UsersEvent.load())),
        BlocProvider(create: (_) => RoomsBloc()..add(const RoomsEvent.load())),
      ],
      child: const _HomeShellView(),
    );
  }
}

class _HomeShellView extends StatelessWidget {
  const _HomeShellView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) =>
          previous.currentUserId != current.currentUserId,
      listener: (context, state) {
        context.read<UsersBloc>().add(
          UsersEvent.setCurrentUser(state.currentUserId),
        );
        context.read<RoomsBloc>().add(
          RoomsEvent.setCurrentUser(state.currentUserId),
        );
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Mobile Chat'),
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
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
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
                UsersListScreen(key: ValueKey('users-${state.currentUserId}')),
                RoomsListScreen(key: ValueKey('rooms-${state.currentUserId}')),
              ],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 0.5,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    offset: const Offset(0, -2),
                    blurRadius: 8,
                  )
                ],
              ),
              child: NavigationBar(
                selectedIndex: state.navIdx,
                onDestinationSelected: (index) {
                  context.read<HomeBloc>().add(HomeEvent.move(index));
                },
                labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
                indicatorColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: '사용자',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.chat_bubble_outline),
                    selectedIcon: Icon(Icons.chat_bubble),
                    label: '채팅방',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
