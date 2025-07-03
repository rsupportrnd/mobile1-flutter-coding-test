import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/widgets/user_profile.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/user_entity.dart';

class UserTile extends StatelessWidget {
  final UserEntity user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withValues(alpha: 0.3),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        UserProfile.large(url: user.profilePicture),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: _UserStatus(status: user.status),
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                color: Colors.white,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                user.email,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.white60,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                user.role,
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UserStatus extends StatelessWidget {
  final String status;
  const _UserStatus({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        shape: BoxShape.circle,
      ),
      child: switch (status) {
        'online' => const Icon(Icons.circle, color: Colors.green, size: 12),
        'offline' => const Icon(Icons.circle, color: Colors.grey, size: 14),
        'away' => const Icon(Icons.circle, color: Colors.yellow, size: 14),
        'do_not_disturb' => const Icon(Icons.circle, color: Colors.red, size: 14),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
