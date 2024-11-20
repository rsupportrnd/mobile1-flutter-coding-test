import 'package:mobile1_flutter_coding_test/index.dart';

class UserCardWidget extends StatelessWidget {
  final UserModel user;
  const UserCardWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildPhoto(user.profilePicture, user.status),
          buildInfo(context,
              name: user.name, email: user.email, role: user.role),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Expanded buildInfo(BuildContext context,
      {required String name, required String email, required String role}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            role,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.email_outlined),
              const SizedBox(
                width: 5,
              ),
              Text(email)
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPhoto(String url, String userStatusString) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              url,
              width: 100,
              height: 100,
              errorBuilder: (context, e, s) => const SizedBox(
                width: 100,
                height: 100,
                child: Icon(
                  Icons.error,
                  size: 40,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          buildStatus(userStatusString),
        ],
      ),
    );
  }

  Center buildStatus(String userStatusString) {
    UserStatus userStatus = UserStatus.values
        .firstWhere((element) => element.name == userStatusString);
    return Center(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Transform.translate(
          offset: const Offset(5, 5),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: userStatus.backColor),
          ),
        ),
      ),
    );
  }
}
