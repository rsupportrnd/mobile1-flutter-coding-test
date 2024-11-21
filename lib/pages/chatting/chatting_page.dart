import 'package:mobile1_flutter_coding_test/index.dart';

class ChattingPage extends StatefulWidget {
  final String roomId;

  const ChattingPage({super.key, required this.roomId});

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {


  late ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<MessageListCubit>().fetchMessagesByRoomNumber(roomId: widget.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.getAppBar(context,
          titleString: widget.roomId, isLeadingIcon: true),
      bottomSheet: const BottomInputWidget(),
      body:
      BlocBuilder<MessageListCubit, MessageListState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return state.when(
              // (messages) => Text(messages.toString()),
          initial: () => const SizedBox.shrink(),
          loading: () =>
          const Center(child: CircularProgressIndicator.adaptive()),
          loaded: (messages) =>buildListViewContent(messages),
          error: (e) => Center(child: Text("Error: $e")),
        );
        },
      ),
    );
  }

  Widget buildListViewContent(List<MessageModel> messages) {
    if(messages.isEmpty){
      return const Center(child: Text("No messages"));
    }
    context.read<MessageListCubit>().scrollToEnd(_scrollController);
    return Padding(
      padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
      child: ListView.builder(
        controller: _scrollController,
          itemBuilder: (_, index) => MessageCardWidget(message: messages[index]),
          itemCount: messages.length),
    );
  }
}
