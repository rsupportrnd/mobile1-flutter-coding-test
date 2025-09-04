import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mobile1_flutter_coding_test/presentation/user/component/user_card.dart';
import 'package:mobile1_flutter_coding_test/presentation/user/viewModel/user_viewmodel.dart';

class UserList extends ConsumerWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const horizontalPadding = 16.0;

    final state = ref.watch(userViewModelProvider);
    return state.when(data: (data) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "사용자",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.users.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 8,
                  ),
                  child: UserCard(user: data.users[index]),
                );
              },
            ),
          ),
        ],
      );
    }, error: (error, stackTrace) {
      return Text(error.toString());
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}
