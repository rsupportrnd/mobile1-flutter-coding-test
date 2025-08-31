import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile1_flutter_coding_test/view_models/base_page_view_model.dart';
import 'package:mobile1_flutter_coding_test/views/base_view.dart';
import 'package:mobile1_flutter_coding_test/views/rooms_view.dart';
import 'package:mobile1_flutter_coding_test/views/users_view.dart';
import 'package:mobile1_flutter_coding_test/widgets/base_content_widget.dart';
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
    initializeDateFormatting(Localizations.localeOf(context).languageCode);
    return Obx( () {
        return BaseContentWidget(

          title: controller.tabIndex.value == 0 ? '사용자' : '회의실',
          useBackButton: false,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.tabIndex.value,
            onTap: (index) {
              controller.tabIndex.value = index;
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.people), label: '사용자'),
              BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: '회의실'),
            ],
          ),
          child: currentTabPage,
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