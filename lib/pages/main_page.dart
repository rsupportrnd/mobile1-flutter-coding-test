import 'package:mobile1_flutter_coding_test/index.dart';

class MainPage extends StatelessWidget {
  final Widget child;

  const MainPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.getAppBar(context, titleString: 'MainPage', isLeadingIcon: false),
      bottomSheet: buildBottomSheet(context),
      body: child,
    );
  }

  BottomNavigationBar buildBottomSheet(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      onTap: (index) {
        context.read<NavigationCubit>().changePage(index);
        switch(index){
          case 0:
            GoRouter.of(context).go(AppPath.userList.toPath);
            break;
          case 1:
            GoRouter.of(context).go(AppPath.roomList.toPath);
            break;
        }
        // context.read<BottomNaviCubit>().changePage(index);
        // _pageController.jumpToPage(index);
      },
      currentIndex: context.watch<NavigationCubit>().currentIndex,
      elevation: 0.0,
      selectedFontSize: 15.0,
      unselectedFontSize: 15.0,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "User", ),
        BottomNavigationBarItem(
            icon: Icon(Icons.door_front_door_sharp), label: "Room"),
      ],
    );
  }

}
