import 'package:mobile1_flutter_coding_test/index.dart';

class MainPage extends StatelessWidget {
  final Widget child;

  const MainPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.getAppBar(context,
          titleString: 'coding-test', isLeadingIcon: false),
      bottomSheet: buildBottomSheet(context),
      body: SafeArea(child: child),
    );
  }

  BottomNavigationBar buildBottomSheet(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      onTap: (index) {
        context.read<NavigationCubit>().changePage(index);
        switch (index) {
          case 0:
            GoRouter.of(context).go(AppPath.userList.toPath);
            break;
          case 1:
            GoRouter.of(context).go(AppPath.roomList.toPath);
            break;
        }
      },
      currentIndex: context.watch<NavigationCubit>().currentIndex,
      elevation: 0.0,
      selectedFontSize: 15.0,
      unselectedFontSize: 15.0,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.person, size: 40,),
          ),
          label: "User",
        ),
        BottomNavigationBarItem(
            icon: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              child: Icon(Icons.meeting_room_rounded, size: 40,),
            ), label: "Room"),
      ],
    );
  }
}
