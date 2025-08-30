import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mobile1_flutter_coding_test/view_models/base_page_view_model.dart';
import 'package:mobile1_flutter_coding_test/views/base_view.dart';
import 'package:mobile1_flutter_coding_test/views/rooms_view.dart';
import 'package:mobile1_flutter_coding_test/views/users_view.dart';
import 'package:mobile1_flutter_coding_test/widgets/base_tab_widget.dart';

class BasePageView extends BaseView<BasePageViewModel> {
  const BasePageView({super.key});

  @override
  void initState(BasePageViewModel vm) {
    // TODO: implement initState
    super.initState(vm);
  }

  @override
  void dispose(BasePageViewModel vm) {
    // TODO: implement dispose
    super.dispose(vm);
  }

  @override
  Widget builder(BuildContext context, BasePageViewModel vm) {

    return Obx( () {
        return Scaffold(
          backgroundColor: Color(0xFFF6F6F6),
          body: SafeArea(
            top: true,    // 상단 상태바 영역 보호
            bottom: true, // 하단 네비게이션바 영역 보호
            child: currentTabPage,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.tabIndex.value,
            onTap: (index) {
              controller.tabIndex.value = index;
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.man), label: '사용자'),
              BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: '회의실'),
            ],
          ),
        );
      },
    );
  }

  Widget get currentTabPage {
    switch (controller.tabIndex.value) {
      case 0:
        return const BaseTabWidget(child:UsersView());
      case 1:
        return const BaseTabWidget(child:RoomsView());
    }
    return const BaseTabWidget(child:UsersView());
  }

  @override
  BasePageViewModel? get vmProvider => BasePageViewModel();

}