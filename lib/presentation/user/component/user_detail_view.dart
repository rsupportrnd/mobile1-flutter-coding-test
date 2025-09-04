import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/shared/widgets/profile.dart';
import 'package:mobile1_flutter_coding_test/shared/widgets/tag.dart';

void showUserDetail(BuildContext context, User user) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    builder: (context) => UserDetailView(user: user),
  );
}

class UserDetailView extends ConsumerWidget {
  const UserDetailView({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const gap = Gap(8);
    return AlertDialog(
      backgroundColor: const Color(0xFFF6F7F8),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFDEEAE7),
            ),
            onPressed: () => context.pop(context),
            child: const Text('닫기')),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Profile(imageUrl: user.profilePicture),
          Text(user.name, style: Theme.of(context).textTheme.titleLarge),
          Text(user.email, style: Theme.of(context).textTheme.bodyMedium),
          gap,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tag.fromUserStatus(user.status),
              gap,
              Tag.fromRoleType(user.role),
            ],
          )
        ],
      ),
    );
  }
}
