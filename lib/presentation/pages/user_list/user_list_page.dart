import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/locator/locator.dart';
import 'package:mobile1_flutter_coding_test/common/viewmodel/viewmodel_state.dart';
import 'package:mobile1_flutter_coding_test/common/widgets/liquid_glass/liquid_app_bar.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/user_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_users_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodels/user_list_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/widgets/user_tile.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserListViewModel(
        getUsersUseCase: locator<GetUsersUseCase>(),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: LiquidAppBar(title: '유저 목록'),
        body: Consumer<UserListViewModel>(
          builder: (context, viewModel, child) {
            return switch (viewModel.usersState) {
              ViewModelStateLoading<List<UserEntity>>() =>
                const Center(child: CircularProgressIndicator()),
              ViewModelStateError<List<UserEntity>> error => Center(child: Text(error.error)),
              ViewModelStateSuccess<List<UserEntity>> success => _UserList(users: success.data),
            };
          },
        ),
      ),
    );
  }
}

class _UserList extends StatelessWidget {
  final List<UserEntity> users;
  _UserList({required this.users});

  final statusPriority = {
    'online': 0,
    'do_not_disturb': 1,
    'away': 2,
    'offline': 3,
  };

  @override
  Widget build(BuildContext context) {
    final sortedUsers = users.sortedBy((user) => statusPriority[user.status] ?? 3);
    return CustomScrollView(
      slivers: [
        SliverSafeArea(
          sliver: SliverPadding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 120),
            sliver: SliverList.builder(
              itemCount: sortedUsers.length,
              itemBuilder: (context, index) {
                final user = sortedUsers[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => showDetail(context, user),
                      child: UserTile(user: user),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void showDetail(
    BuildContext context,
    UserEntity user,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user.name),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(user.name),
            Text(user.email),
            Text(user.role),
          ],
        ),
      ),
    );
  }
}
