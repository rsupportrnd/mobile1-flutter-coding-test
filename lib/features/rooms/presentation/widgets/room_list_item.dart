import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/room.dart';

class RoomListItem extends StatelessWidget {
  final Room room;

  const RoomListItem({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          context.pushNamed('messages', pathParameters: {'roomId': room.roomId});
        },
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: room.thumbnailImage,
                      width: 60,
                      height: 60,
                      memCacheWidth: 60,
                      memCacheHeight: 60,
                      errorWidget: (context, url, error) => const Icon(Icons.account_circle, size: 60, color: Colors.grey),
                      placeholder: (context, url) => const Icon(Icons.account_circle, size: 60, color: Colors.grey),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                      room.roomName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            room.lastMessage.content,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
                          )
                        ],
                      ))
                ],
              ),
              Text(
                room.lastMessage.timestamp.toLocal().toString().split(' ').first ?? '',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
          ),
        ));
  }
}
