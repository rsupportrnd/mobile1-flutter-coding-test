import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../data/models/user.dart';
import 'user_detail_bottom_sheet.dart';

class UserListItem extends StatelessWidget {
  final User user;

  const UserListItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useRootNavigator: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => UserDetailBottomSheet(user: user),
        );
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
                  imageUrl: user.profilePicture,
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
                        user.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
                      )
                    ],
                  ))
            ],
          ),
          Row(
            children: [
              Text(
                _statusMessage(user.status.toString()),
                style: TextStyle(
                  color: _statusColor(user.status.toString()),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                width: 20,
                height: 20,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: _statusColor(user.status.toString())),
              )
            ],
          ),
        ],
      ),
    ));
  }
}

Color _statusColor(String status) {
  switch (status) {
    case 'UserStatus.online':
      return Colors.green;
    case 'UserStatus.away':
      return Colors.orange;
    case 'UserStatus.offline':
      return Colors.grey;
    case 'UserStatus.do_not_disturb':
      return Colors.red;
    default:
      return Colors.black;
  }
}

String _statusMessage(String status) {
  switch (status) {
    case 'UserStatus.online':
      return "온라인";
    case 'UserStatus.away':
      return "자리비움";
    case 'UserStatus.offline':
      return "오프라인";
    case 'UserStatus.do_not_disturb':
      return "방해금지";
    default:
      return "알 수 없음";
  }
}
