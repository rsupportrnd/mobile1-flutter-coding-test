import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/presentation/provider/viewmodel_provider.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  void _showUserDetail(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('User Detail'),
        content: Text('Details for $user'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userListViewModelProvider);
    return ListView.builder(
      itemCount: state.items.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(state.items[index].name),
        onTap: () => _showUserDetail(context, state.items[index]),
      ),
    );
  }
}
