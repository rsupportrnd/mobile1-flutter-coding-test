import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/users_bloc.dart';
import 'widgets/user_list_item.dart';
import '../../core/routes.dart';
import 'user_detail/user_detail_view.dart';
import 'widgets/user_avatar.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '오류가 발생했습니다',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    state.error!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }

          final currentUserId = state.currentUserId;
          final me = state.users.firstWhere(
            (u) => u.userId == currentUserId,
            orElse: () => null,
          );
          final others = state.users.where((u) => u.userId != currentUserId).toList();

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: others.length + 1,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              if (index == 0) {
                if (me == null) return const SizedBox.shrink();
                return _MyProfileHeader(
                  user: me,
                  onTap: () {
                    context.go(
                      '${AppRoutes.home}/users/${me.userId}',
                      extra: UserDetailArgs(user: me, isMe: true),
                    );
                  },
                );
              }
              final user = others[index - 1];
              return UserListItem(user: user);
            },
          );
        },
      );
  }
} 

class _MyProfileHeader extends StatelessWidget {
  const _MyProfileHeader({required this.user, this.onTap});

  final dynamic user;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            UserAvatar(url: user.profilePicture, size: 56, iconSize: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}