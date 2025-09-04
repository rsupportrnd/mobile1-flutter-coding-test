import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/shared/enum/role_type.dart';
import 'package:mobile1_flutter_coding_test/shared/enum/user_status.dart';
import 'package:mobile1_flutter_coding_test/shared/widgets/profile.dart';
import 'package:mobile1_flutter_coding_test/shared/widgets/tag.dart';

class UserCard extends ConsumerWidget {
  const UserCard({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7F8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.1),
        ),
      ),
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
                  const Text(
                    "ws5260@naver.com",
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tag.fromUserStatus(UserStatus.online),
                const SizedBox(height: 2),
                Tag.fromRoleType(RoleType.admin),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
