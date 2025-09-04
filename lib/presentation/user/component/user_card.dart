import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/presentation/user/component/user_detail_view.dart';
import 'package:mobile1_flutter_coding_test/shared/widgets/custom_card.dart';
import 'package:mobile1_flutter_coding_test/shared/widgets/profile.dart';
import 'package:mobile1_flutter_coding_test/shared/widgets/tag.dart';

class UserCard extends ConsumerWidget {
  const UserCard({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomCard(
      onTap: () => showUserDetail(context, user),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Profile(
              imageUrl: user.profilePicture,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tag.fromUserStatus(user.status),
                const SizedBox(height: 2),
                Tag.fromRoleType(user.role),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
