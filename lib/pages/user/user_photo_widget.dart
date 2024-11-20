import 'package:mobile1_flutter_coding_test/index.dart';

class UserPhotoWidget extends StatelessWidget {
  final String photoUrl;
  final String userStatusString;

  const UserPhotoWidget({super.key, required this.photoUrl, required this.userStatusString});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              photoUrl,
              width: 100,
              height: 100,
              errorBuilder: (context, e, s) => Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      size: 40,
                      color: Colors.red,
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Failed to load image',
                      textAlign: TextAlign.center,
                    ),
                  ],
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