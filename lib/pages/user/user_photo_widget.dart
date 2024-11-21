import 'package:mobile1_flutter_coding_test/index.dart';

class UserPhotoWidget extends StatelessWidget {
  final String photoUrl;
  final String userStatusString;

  const UserPhotoWidget({super.key, required this.photoUrl, required this.userStatusString});

  @override
  Widget build(BuildContext context) {
    double photoSize = 60.0;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              photoUrl,
              width: photoSize,
              errorBuilder: (context, e, s) => Container(
                width: photoSize,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: const Icon(
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