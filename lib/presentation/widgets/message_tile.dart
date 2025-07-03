import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/extensions/extensions.dart';
import 'package:mobile1_flutter_coding_test/common/widgets/user_profile.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/user_entity.dart';

class MessageTile extends StatelessWidget {
  final MessageEntity message;
  final UserEntity? user;
  const MessageTile({super.key, required this.message, this.user});

  @override
  Widget build(BuildContext context) {
    final isMine = message.sender == 'me';
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMine) ...{
          UserProfile.large(url: user?.profilePicture ?? ''),
          SizedBox(width: 8),
        },
        Flexible(
          child: Column(
            crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMine) ...{
                Text(
                  user?.name ?? message.sender,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
              },
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black.withValues(alpha: 0.3),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    message.content,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                message.timestamp.toHHMM(),
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
