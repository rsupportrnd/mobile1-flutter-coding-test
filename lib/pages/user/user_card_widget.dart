import 'package:mobile1_flutter_coding_test/index.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(body: UserCardWidget(),),));
}

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('aa'),);
  }
}
