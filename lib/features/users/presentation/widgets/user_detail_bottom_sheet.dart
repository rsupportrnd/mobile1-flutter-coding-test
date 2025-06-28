import 'package:mobile1_flutter_coding_test/app/index.dart';

class UserDetailBottomSheet extends HookWidget {
  final User user;

  const UserDetailBottomSheet({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(visible: _getRole(user.role.toString()) == '관리자', child: Icon(Icons.admin_panel_settings, size: 30, color: _statusColor(user.status.toString()))),
          ClipRRect(
            child: CachedNetworkImage(
              imageUrl: user.profilePicture,
              width: 120,
              height: 120,
              memCacheWidth: 120,
              memCacheHeight: 120,
              errorWidget: (context, url, error) => const Icon(Icons.account_circle, size: 60, color: Colors.grey),
              placeholder: (context, url) => const Icon(Icons.account_circle, size: 60, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(user.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                width: 20,
                height: 20,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: _statusColor(user.status.toString())),
              ),
              Text(
                _statusMessage(user.status.toString()),
                style: TextStyle(
                  color: _statusColor(user.status.toString()),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text(user.email, style: TextStyle(color: Colors.grey[600])), Text(" (${user.userId})", style: TextStyle(color: Colors.grey[600]))],
          )
        ],
      ),
    );
  }

  String _getRole(String role) {
    print(role);
    switch (role) {
      case 'UserRole.admin':
        return '관리자';
      case 'UserRole.member':
        return '사용자';
      default:
        return '알 수 없음';
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
}
