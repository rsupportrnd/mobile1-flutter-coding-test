import 'package:mobile1_flutter_coding_test/index.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<UserListCubit>().fetchUsers(UserStatus.all);
  }

  @override
  Widget build(BuildContext context) {
    //kBottomNavigationBarHeight
    return DefaultTabController(
      length: UserStatus.values.length,
      child: Scaffold(
        body: Column(
          children: [
            tabBarWidget(),
            Expanded(
              child: BlocBuilder<UserListCubit, UserListState>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator.adaptive()),
                    loaded: (users) => buildListViewContent(users),
                    error: (e) => Center(child: Text("Error: $e")),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListViewContent(List<UserModel> users) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
      child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (_, index) => UserCardWidget(user: users[index]),
          itemCount: users.length),
    );
  }

  Widget tabBarWidget() {
    return TabBar(
      isScrollable: true,
      padding: EdgeInsets.zero,
      tabAlignment: TabAlignment.start,
      labelColor: Colors.grey,
      unselectedLabelColor: Colors.grey.shade300,
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
      indicatorColor: Colors.cyan,
      indicatorSize: TabBarIndicatorSize.tab,
      onTap: (index) {
        context.read<UserListCubit>().fetchUsers(UserStatus.values[index]);
      },
      tabs: List.generate(
        UserStatus.values.length,
        (index) => Tab(
          text: UserStatus.values[index].name,
        ),
      ),
    );
  }
}
