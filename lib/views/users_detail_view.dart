import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile1_flutter_coding_test/commons/enums.dart';
import 'package:mobile1_flutter_coding_test/models/user_model.dart';
import 'package:mobile1_flutter_coding_test/view_models/users_detail_view_model.dart';
import 'package:mobile1_flutter_coding_test/views/base_view.dart';
import 'package:mobile1_flutter_coding_test/widgets/base_content_widget.dart';

class UsersDetailView extends BaseView<UsersDetailViewModel> {
  const UsersDetailView({super.key, required this.user});
  final UserModel user;

@override
  void initState(UsersDetailViewModel vm) {
    // TODO: implement initState
    super.initState(vm);
  }

  @override
  void dispose(UsersDetailViewModel vm) {
    // TODO: implement dispose
    super.dispose(vm);
  }

  @override
  Widget builder(BuildContext context, UsersDetailViewModel vm) {

    return BaseContentWidget(
        title: '유저 정보',
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            children: [
              SizedBox( height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                    width: 125,
                    height: 125,
                    child: (user.profilePicture != null && user.profilePicture.isNotEmpty) ?
                    Container(
                        width: 125,
                        height: 125,
                        decoration:
                        BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  user.profilePicture,
                                  maxWidth: 125,
                                  maxHeight: 125,
                                  errorListener: (_) {

                                  })),
                        )) : Icon(Icons.account_circle, size: 125, color: Colors.grey)),
              ),
              Expanded(child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Text(
                        style: TextStyle (
                          fontSize: 30,
                        ),
                        user.name),
                    SizedBox(height:10),
                    Text (user.email),
                    SizedBox(height:10),
                    Row(
                      children: [
                        Text (
                          '유저 타입: ${user.role == UserRole.admin ? '관리자' : user.role == UserRole.member ? '일반유저' : '오류'}'
                        ),
                        if ( user.role == UserRole.admin)
                          Icon(Icons.handyman, color: Colors.blueGrey),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                            '유저 상태: ${user.status == UserStatus.offline ? '오프라인'
                                : user.status == UserStatus.online ? '온라인'
                                : user.status == UserStatus.doNotDisturb ? '방해금지'
                                : user.status == UserStatus.away ? '이탈' : '오류'}'),
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
                  ],
                ),
              )),
            ],
          ),
        ));
  }

  @override
  UsersDetailViewModel? get vmProvider => UsersDetailViewModel();

}