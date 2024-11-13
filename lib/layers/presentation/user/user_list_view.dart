import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/user_list_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/widget/user_tile.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/widgets/future_handler.dart';
import 'package:provider/provider.dart';

/// 유저 리스트 화면
class UserListView extends StatelessWidget {
  const UserListView({super.key});

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
