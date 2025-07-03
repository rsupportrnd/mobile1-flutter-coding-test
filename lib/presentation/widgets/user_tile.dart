import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/widgets/user_profile.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/user_entity.dart';

class UserTile extends StatelessWidget {
  final UserEntity user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          UserProfile.large(url: user.profilePicture),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name),
              Text(user.role),
            ],
          )),
          _UserStatus(status: user.status),
        ],
      ),
    );
  }
}

class _UserStatus extends StatelessWidget {
  final String status;
  const _UserStatus({required this.status});

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      'online' => const Icon(Icons.circle, color: Colors.green),
      'offline' => const Icon(Icons.circle, color: Colors.grey),
      'away' => const Icon(Icons.circle, color: Colors.yellow),
      'do_not_disturb' => const Icon(Icons.circle, color: Colors.red),
      _ => const SizedBox.shrink(),
    };
  }
}
