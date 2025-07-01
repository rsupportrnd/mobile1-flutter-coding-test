import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/extensions/extensions.dart';
import 'package:mobile1_flutter_coding_test/common/widgets/image_component.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/room_entity.dart';

class RoomTile extends StatelessWidget {
  final RoomEntity room;
  const RoomTile({super.key, required this.room});

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
          ImageComponent(
              url: room.thumbnailImage,
              width: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.room_outlined)),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(room.roomName),
              Text(room.lastMessage.content),
              Text(room.lastMessage.timestamp.toYYYYMMDDHHMM()),
            ],
          )),
        ],
      ),
    );
  }
}
