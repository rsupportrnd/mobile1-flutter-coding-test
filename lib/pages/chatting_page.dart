import 'package:mobile1_flutter_coding_test/index.dart';

class ChattingPage extends StatelessWidget {
  final String roomId;
  const ChattingPage({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(roomId)));
  }
}
