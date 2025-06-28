import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../bloc/user_bloc.dart';
import 'widgets/user_list_item.dart';

class UserListScreen extends HookWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사용자 목록'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoadSuccess) {
            final users = state.users;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<UserBloc>().add(UserLoadRequested());
              },
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: users.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final user = users[index];
                  return UserListItem(user: user);
                },
              ),
            );
          } else if (state is UserLoadFailure) {
            return Center(child: Text('에러: ${state.errorMessage}'));
          } else {
            return const Center(child: Text('사용자 정보를 불러올 수 없습니다.'));
          }
        },
      ),
    );
  }
}
