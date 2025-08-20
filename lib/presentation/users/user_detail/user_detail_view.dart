import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/core/injector.dart';
import 'package:mobile1_flutter_coding_test/models/app_user.dart';
import 'package:mobile1_flutter_coding_test/repository/user_repositoy.dart';
import 'package:mobile1_flutter_coding_test/presentation/users/widgets/status_badge.dart';
import 'package:mobile1_flutter_coding_test/presentation/users/widgets/user_avatar.dart';

class UserDetailArgs {
  UserDetailArgs({this.user, this.isMe = false});
  final AppUser? user;
  final bool isMe;
}

class UserDetailView extends StatelessWidget {
  const UserDetailView({super.key, required this.userId, this.user, this.isMe = false});

  final String userId;
  final AppUser? user;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final repo = injector<UserRepository>();
    AppUser? u = user;
    u ??= repo.getById(userId);

    if (u == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('사용자 상세')),
        body: const Center(child: Text('사용자를 찾을 수 없습니다.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(isMe ? '내 프로필' : '사용자 상세')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                UserAvatar(url: u.profilePicture, size: 80, iconSize: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        u.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        u.email,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  '상태',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                StatusBadge(status: u.status, size: 18),
              ],
            ),
            const SizedBox(height: 12),
            _InfoTile(label: '권한', value: u.role.isEmpty ? '-' : u.role),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}


