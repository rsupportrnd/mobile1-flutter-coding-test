import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:mobile1_flutter_coding_test/common/locator/locator.dart';
import 'package:mobile1_flutter_coding_test/common/widgets/liquid_glass/liquid_tab_switch.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_rooms_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_users_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/post_room_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodels/room_list_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodels/user_list_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/routes/app_router.gr.dart';
import 'package:provider/provider.dart';

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonBuilder: (context, tabsRouter) {
        return LiquidTabSwitch(
          currentIndex: tabsRouter.activeIndex,
          items: [
            LiquidTabSwitchItem(
              label: '유저',
              icon: CupertinoIcons.person,
              onTap: () => tabsRouter.setActiveIndex(0),
            ),
            LiquidTabSwitchItem(
              label: '회의',
              icon: Icons.meeting_room,
              onTap: () => tabsRouter.setActiveIndex(1),
            ),
          ],
        );
      },
      routes: [
        UserListRoute(),
        RoomListRoute(),
      ],
    );
  }
}
