import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile1_flutter_coding_test/commons/main_module.dart';
import 'package:mobile1_flutter_coding_test/models/user_model.dart';
import 'package:mobile1_flutter_coding_test/view_models/users_view_model.dart';
import 'package:mobile1_flutter_coding_test/views/base_view.dart';
import 'package:mobile1_flutter_coding_test/views/users_detail_view.dart';
import 'package:mobile1_flutter_coding_test/widgets/base_tile_widget.dart';
import 'package:mobile1_flutter_coding_test/widgets/user_role_widget.dart';
import 'package:mobile1_flutter_coding_test/widgets/user_status_widget.dart';

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
    return Obx(() {
      var usersList = MainModule.instance.usersList;

      return ListView.separated(
          controller: controller.scrollController,
          scrollDirection: Axis.vertical,
          itemCount: usersList.length,
          shrinkWrap: true,
          separatorBuilder: (_, __) => const SizedBox(height: 5, child: Divider(height: 1)),
          itemBuilder: (context, index) {
            UserModel user = usersList[index];

            return BaseTileWidget(
              onTap: () async {
                Get.to(UsersDetailView(user: user));
              },
              thumbnailPath: user.profilePicture,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(user.name + (user.userId == MainModule.instance.currentUser.userId ? ' (나)' : '' )),
                      UserRoleWidget(userRole: user.role),
                      UserStatusWidget(userStatus: user.status)
                    ],
                  ),
                  Text (user.email),
                ],
              )
            );
          });
    });
  }

  @override
  UsersViewModel? get vmProvider => UsersViewModel();
}
