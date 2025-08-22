import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/core/routes.dart';
import 'package:mobile1_flutter_coding_test/presentation/users/user_detail/user_detail_view.dart';
import 'package:mobile1_flutter_coding_test/presentation/users/widgets/status_badge.dart';
import 'package:mobile1_flutter_coding_test/presentation/users/widgets/user_avatar.dart';
import 'package:mobile1_flutter_coding_test/presentation/users/widgets/profile_image_viewer.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({super.key, required this.user});

  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        onTap: () => ProfileImageViewer.show(
          context,
          imageUrl: user.profilePicture,
        ),
        child: UserAvatar(url: user.profilePicture),
      ),
      title: Text(
        user.name,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        user.email,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: StatusBadge(status: user.status),
      onTap: () {
        context.go(
          '${AppRoutes.home}/users/${user.userId}',
          extra: UserDetailArgs(user: user, isMe: false),
        );
      },
    );
  }

  // legacy avatar builder removed in favor of UserAvatar

  // legacy method removed; StatusBadge used instead
}
