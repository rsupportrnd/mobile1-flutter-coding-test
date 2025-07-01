import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/viewmodel/viewmodel_state.dart';
import 'package:mobile1_flutter_coding_test/data/datasources/user_remote_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/repositories/user_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/user_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_users_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodels/user_list_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/widgets/user_tile.dart';
import 'package:provider/provider.dart';

class UserListPage extends StatelessWidget {
  static const routeName = '/userList';

  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserListViewModel(
          getUsersUseCase: GetUsersUseCase(UserRepositoryImpl(
        remoteDataSource: UserRemoteDataSource(dio: Dio()),
      ))),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('유저 목록'),
        ),
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
  const _UserList({required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => showDetail(context, users[index]),
          child: UserTile(user: users[index]),
        );
      },
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
