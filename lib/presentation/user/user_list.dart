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
            child: ListView.separated(
              itemCount: data.users.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: UserCard(user: data.users[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Gap(8);
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
