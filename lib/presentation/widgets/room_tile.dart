import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/extensions/extensions.dart';
import 'package:mobile1_flutter_coding_test/common/widgets/image_component.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/room_entity.dart';

class RoomTile extends StatelessWidget {
  final RoomEntity room;
  const RoomTile({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ImageComponent(
            url: room.thumbnailImage,
            width: double.infinity,
            fit: BoxFit.cover,
            height: 250,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.flip,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withValues(alpha: 0.3),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            room.roomName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.group,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${room.participants.length}명 참여중',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.mail,
                            color: Colors.white60,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              room.lastMessage.content,
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            room.lastMessage.timestamp.toDiffTime(),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
