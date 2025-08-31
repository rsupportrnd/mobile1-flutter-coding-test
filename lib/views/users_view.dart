import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile1_flutter_coding_test/commons/enums.dart';
import 'package:mobile1_flutter_coding_test/commons/main_module.dart';
import 'package:mobile1_flutter_coding_test/models/user_model.dart';
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

            return InkWell(
                onTap: () async {
                  Get.to(UsersDetailView(user: user));
                },
                child: Container(
                    height: 75,
                    child: Row(
                      children: [
                        SizedBox(
                            width: 75,
                            height: 75,
                            child: Center(
                              child: (user.profilePicture != null && user.profilePicture.isNotEmpty) ?
                              Container(
                                width: 50,
                                height: 50,
                                decoration:
                                BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          user.profilePicture,
                                          maxWidth: 50,
                                          maxHeight: 50,
                                          errorListener: (_) {

                                          })),
                                )) : Icon(Icons.account_circle, size: 50, color: Colors.grey),
                            )),
                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(user.name + (user.userId == MainModule.instance.currentUser.userId ? ' (나)' : '' )),
                                if ( user.role == UserRole.admin)
                                  Icon(Icons.handyman, color: Colors.blueGrey),
                                if ( user.status == UserStatus.offline)
                                  Icon(Icons.offline_bolt_outlined, color: Colors.grey),
                                if ( user.status == UserStatus.online)
                                  Icon(Icons.offline_bolt_outlined, color: Colors.green),
                                if ( user.status == UserStatus.doNotDisturb)
                                  Icon(Icons.do_not_disturb_on, color: Colors.red),
                                if ( user.status == UserStatus.away)
                                  Icon(Icons.leave_bags_at_home, color: Colors.grey),
                              ],
                            ),
                            Text (user.email),
                          ],
                        )),
                      ],
                    )));
          });
    });
  }

  @override
  UsersViewModel? get vmProvider => UsersViewModel();
}
