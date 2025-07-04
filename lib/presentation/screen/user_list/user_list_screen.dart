import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/di/viewmodel_provider.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({super.key});

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  // 상위 위젯인 HomeScreen의 tab 상태가 변경될 때 마다 실행
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 현재 프레임 이후에 실행하도록 지연시켜 build가 완료된 후 실행
    Future.microtask(() {
      // microtask 없이 호출할 경우 생명주기 중 State를 변경하여 에러
      ref.read(userListViewModelProvider.notifier).loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userListViewModelProvider);
    return ListView.builder(
      itemCount: state.items.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(state.items[index].name),
        onTap: () => _showUserDetail(context, state.items[index]),
      ),
    );
  }

  void _showUserDetail(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(user.name), Text(user.status)],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.network(
                user.profilePicture,
                fit: BoxFit.scaleDown,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  child: Center(child: Icon(Icons.error)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('UserId: ${user.userId}'),
            Text('Email: ${user.email}'),
            Text('Role: ${user.role}')
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          )
        ],
      ),
    );
  }
}
