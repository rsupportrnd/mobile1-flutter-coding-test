import 'package:flutter/material.dart';
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
        child: Text (user.name));
  }

  @override
  UsersDetailViewModel? get vmProvider => UsersDetailViewModel();

}