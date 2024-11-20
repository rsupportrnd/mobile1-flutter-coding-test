import 'package:mobile1_flutter_coding_test/index.dart';

class UserInfoWidget extends StatelessWidget {
  final String name;
  final String role;
  final String email;

  const UserInfoWidget(
      {super.key, required this.name, required this.role, required this.email});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildText(text: name),
          const SizedBox(height: 3),
          buildText(text: role),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.email_outlined),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: buildText(text: email, maxLines: 2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text buildText({required String text, int maxLines = 1}) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
