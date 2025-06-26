part of '../user_list_screen.dart';

class _UserInfoListView extends BaseView {
  final List<UserEntity> userListEntity;
  const _UserInfoListView({
    required this.userListEntity,
  });

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: _UserInfoItem(
            userEntity: userListEntity[index],
            onTap: () {},
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 1,
        );
      },
      itemCount: userListEntity.length,
    );
  }
}

class _UserInfoItem extends StatelessWidget {
  final UserEntity userEntity;
  final VoidCallback onTap;
  const _UserInfoItem({
    required this.userEntity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserAvatarWidget(profilePictureUrl: userEntity.profilePicture),
              const SizedBox(width: 20),
              Text(
                userEntity.name,
                style: AppTextStyle.body,
              ),
              const Spacer(),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: userEntity.status.getStatusColor(),
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
