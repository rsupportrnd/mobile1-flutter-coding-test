import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/extensions/extensions.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';

class MessageTile extends StatelessWidget {
  final MessageEntity message;
  const MessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message.content),
              Text(message.timestamp.toYYYYMMDDHHMM()),
            ],
          )),
        ],
      ),
    );
  }
}
