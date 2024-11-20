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
    context.read<UserListCubit>().fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    //kBottomNavigationBarHeight
    return Scaffold(
      body: BlocBuilder<UserListCubit, UserListState>(
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
    );
  }

  Widget buildListViewContent(List<UserModel> users) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
      child: ListView.builder(
          itemBuilder: (_, index) => UserCardWidget(user: users[index]),
          itemCount: users.length),
    );
  }
}
