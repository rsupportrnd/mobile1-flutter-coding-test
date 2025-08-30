import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile1_flutter_coding_test/view_models/users_view_model.dart';
import 'package:mobile1_flutter_coding_test/views/base_view.dart';
import 'package:mobile1_flutter_coding_test/views/users_detail_view.dart';

class UsersView extends BaseView<UsersViewModel> {
  const UsersView({super.key});

  @override
  void initState(UsersViewModel vm) {
    // TODO: implement initState
    super.initState(vm);
  }

  @override
  void dispose(UsersViewModel vm) {
    // TODO: implement dispose
    super.dispose(vm);
  }

  @override
  Widget builder(BuildContext context, UsersViewModel vm) {
    return Obx ( () {
      var usersList = controller.usersList;

      return ListView.separated(
          controller: controller.scrollController,
          scrollDirection: Axis.vertical,
          itemCount: usersList.length,
          shrinkWrap: true,
          separatorBuilder: (_, __) => const SizedBox(height: 5),
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () async {
                  Get.to(UsersDetailView(user:usersList[index]));
                },
                child: Container(height: 300, child: Text('${usersList[index].name}')));
          });
    });
  }

  @override
  UsersViewModel? get vmProvider => UsersViewModel();

}