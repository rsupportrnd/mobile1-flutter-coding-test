import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/presentation/user/component/user_card.dart';
import 'package:mobile1_flutter_coding_test/shared/enum/role_type.dart';
import 'package:mobile1_flutter_coding_test/shared/enum/user_status.dart';
import 'package:mobile1_flutter_coding_test/shared/widgets/profile.dart';
import 'package:mobile1_flutter_coding_test/shared/widgets/tag.dart';

class UserList extends ConsumerStatefulWidget {
  const UserList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserListState();
}

class _UserListState extends ConsumerState<ConsumerStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 16.0;
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
            itemCount: 20, // 예시 데이터 개수
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: UserCard(
                    user: User(
                        userId: 'user$index',
                        name: 'name$index',
                        email: 'email$index',
                        profilePicture:
                            'https://picsum.photos/id/1011/200/200 ',
                        status: UserStatus.online,
                        role: RoleType.admin)),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Gap(8);
            },
          ),
        ),
      ],
    );
  }
}
