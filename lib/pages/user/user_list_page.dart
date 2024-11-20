import 'package:mobile1_flutter_coding_test/index.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    //kBottomNavigationBarHeight
    return Scaffold(
      body: Stack(
        children: [
          // Positioned(
          //     child: Container(
          //         color: Colors.blue, height: 300, width: double.infinity),
          //     left: 0,
          //     right: 0,
          //     bottom: kBottomNavigationBarHeight),
          // Center(
          //   child: Text('user list'),
          // ),
        ],
      ),
    );
  }
}
