import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:mobile1_flutter_coding_test/routes/app_router.gr.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        UserListRoute(),
        RoomListRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '유저',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.meeting_room),
              label: '회의',
            ),
          ],
        );
      },
    );
  }
}
