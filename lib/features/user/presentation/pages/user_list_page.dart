import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/features/user/presentation/controllers/user_list_provider.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/models/user_model.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/models/user_status.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/models/user_role.dart';
import 'package:mobile1_flutter_coding_test/features/user/presentation/widgets/user_detail_modal.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(userListControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('사용자 목록'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () => ref.refresh(userListControllerProvider),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: usersAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) { 
          print(error);
          return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                '데이터를 불러오는 중 오류가 발생했습니다',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(userListControllerProvider),
                child: const Text('다시 시도'),
              ),
            ],
          ),
        );
        },
        data: (users) => users.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      '등록된 사용자가 없습니다',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await ref.read(userListControllerProvider.notifier).refresh();
                },
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return UserListTile(user: user);
                  },
                ),
              ),
      ),
    );
  }
}

class UserListTile extends StatelessWidget {
  final User user;

  const UserListTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.profilePicture),
          onBackgroundImageError: (exception, stackTrace) {
            // 이미지 로드 실패 시 기본 아이콘 표시
          },
          child: user.profilePicture.isEmpty
              ? const Icon(Icons.person)
              : null,
        ),
        title: Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email),
            const SizedBox(height: 4),
            Row(
              children: [
                _buildStatusChip(user.status),
                const SizedBox(width: 8),
                _buildRoleChip(user.role),
              ],
            ),
          ],
        ),
        onTap: () {
          UserDetailModal.show(context, user);
        },
      ),
    );
  }

  Widget _buildStatusChip(UserStatus status) {
    Color backgroundColor;
    Color textColor;
    String statusText;

    switch (status) {
      case UserStatus.online:
        backgroundColor = Colors.green;
        textColor = Colors.white;
        statusText = '온라인';
        break;
      case UserStatus.offline:
        backgroundColor = Colors.grey;
        textColor = Colors.white;
        statusText = '오프라인';
        break;
      case UserStatus.away:
        backgroundColor = Colors.orange;
        textColor = Colors.white;
        statusText = '자리비움';
        break;
      case UserStatus.doNotDisturb:
        backgroundColor = Colors.red;
        textColor = Colors.white;
        statusText = '방해금지';
        break;
    }

    return Chip(
      label: Text(
        statusText,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
        ),
      ),
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildRoleChip(UserRole role) {
    String roleText;
    Color backgroundColor;

    switch (role) {
      case UserRole.admin:
        roleText = '관리자';
        backgroundColor = Colors.blue;
        break;
      case UserRole.member:
        roleText = '멤버';
        backgroundColor = Colors.teal;
        break;
    }

    return Chip(
      label: Text(
        roleText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}