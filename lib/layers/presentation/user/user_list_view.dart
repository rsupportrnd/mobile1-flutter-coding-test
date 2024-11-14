import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/common.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/user_list_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/widget/user_tile.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/widgets/future_handler.dart';
import 'package:provider/provider.dart';

import '../../domain/usecase/user_usecase.dart';

/// 유저 리스트 화면
class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserListViewModel>(context, listen: false).fetchUserList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserListViewModel>(
         builder: (context, provider, child) {
           return  FutureHandler(
             isLoading: provider.isLoading,
             isError: provider.isError,
             errorMessage: provider.errorMessage,
             onRetry: provider.onRetry,
             child: Column(
               children: [
                 Expanded(
                   child: ListView.builder(
                     itemCount: provider.userList.length,
                     itemBuilder: (context, index) => UserTile(
                       user: provider.userList[index],
                     ),
                   ),
                 ),
               ],
             ),
           );
         },
      );
  }
}
