import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/core/injector.dart';
import 'package:mobile1_flutter_coding_test/models/app_user.dart';
import 'package:mobile1_flutter_coding_test/presentation/rooms/bloc/rooms_bloc.dart';
import 'package:mobile1_flutter_coding_test/presentation/users/widgets/user_avatar.dart';
import 'package:mobile1_flutter_coding_test/repository/user_repositoy.dart';

import 'bloc/chat_bloc.dart';

class ChatArgs {
  ChatArgs({required this.currentUserId, required this.rBloc});
  final String currentUserId;
  final RoomsBloc rBloc;
}

class ChatView extends StatefulWidget {
  const ChatView({
    super.key,
    required this.roomId,
    required this.currentUserId,
  });

  final String roomId;
  final String currentUserId;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  int _prevMsgLen = 0;
  double _prevInsets = 0.0;
  bool _reverse = false;

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(ChatEvent.load(widget.roomId));
  }

  bool _isNearBottom([double threshold = 80]) {
    if (!_scrollCtrl.hasClients) return true;
    final pos = _scrollCtrl.position;
    return (pos.maxScrollExtent - pos.pixels) <= threshold;
  }

  void _scrollToBottom({bool animated = true}) {
    if (!_scrollCtrl.hasClients) return;
    final offset = _reverse ? 0.0 : _scrollCtrl.position.maxScrollExtent;
    if (animated) {
      _scrollCtrl.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    } else {
      _scrollCtrl.jumpTo(offset);
    }
  }

  @override
  Widget build(BuildContext context) {
    final kb = MediaQuery.viewInsetsOf(context).bottom;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;

        final ack = Completer<void>();
        context.read<ChatBloc>().add(ChatEvent.onExit(ack: ack));
        await ack.future;

        if (!mounted) return;
        if (mounted) context.pop();
      },
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          final me = widget.currentUserId;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            final nowLen = state.messages.length;
            bool initialLoaded =
                (_prevMsgLen == 0 && nowLen > 0 && !state.loading);
            bool appendedByMe = false;
            if (nowLen > _prevMsgLen && nowLen > 0) {
              final last = state.messages.last;
              final lastSender = (last.sender as String?);
              appendedByMe = lastSender == me;
            }

            if (_scrollCtrl.hasClients) {
              final canScroll = _scrollCtrl.position.maxScrollExtent > 0;
              if (canScroll != _reverse) {
                setState(() => _reverse = canScroll);
              }
            }

            if (initialLoaded || appendedByMe) {
              _scrollToBottom(animated: true);
            }

            _prevMsgLen = nowLen;
          });

          if (kb != _prevInsets) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_isNearBottom()) _scrollToBottom(animated: true);
              _prevInsets = kb;
            });
          }

          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text(state.room?.roomName ?? '채팅'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.group_outlined),
                  onPressed: () => _openDetailsSheet(context),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: state.loading
                      ? const Center(child: CircularProgressIndicator())
                      : _GroupedChatList(
                          messages: state.messages,
                          me: me,
                          userById: state.userById,
                          controller: _scrollCtrl,
                          reverse: _reverse,
                        ),
                ),
                _InputBar(
                  controller: _controller,
                  onSend: (text) {
                    final roomBloc = context.read<RoomsBloc>();
                    context.read<ChatBloc>().add(ChatEvent.send(text, me));
                    _controller.clear();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _openDetailsSheet(BuildContext context) {
    final state = context.read<ChatBloc>().state;
    final room = state.room;
    if (room == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        '참여자',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: room.participants.length,
                    itemBuilder: (context, index) {
                      final uid = room.participants[index];
                      final isHost = uid == room.creator;
                      final user = state.userById[uid];
                      return ListTile(
                        leading: UserAvatar(
                          url: user?.profilePicture ?? '',
                          size: 40,
                          iconSize: 20,
                        ),
                        title: Text(user?.name ?? uid),
                        subtitle: Text(user?.email ?? ''),
                        trailing: isHost
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '방장',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              )
                            : null,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.isMine,
    required this.sender,
  });

  final dynamic message;
  final bool isMine;
  final AppUser? sender;

  @override
  Widget build(BuildContext context) {
    final userName = sender?.name ?? message.sender;
    final time = _formatTime(message.timestamp);

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .7,
        ),
        child: Column(
          crossAxisAlignment: isMine
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            // 프로필 사진과 이름
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isMine) ...[
                  UserAvatar(
                    url: sender?.profilePicture ?? '',
                    size: 24,
                    iconSize: 12,
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  userName,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                if (isMine) ...[
                  const SizedBox(width: 6),
                  UserAvatar(
                    url: sender?.profilePicture ?? '',
                    size: 24,
                    iconSize: 12,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 4),
            // 채팅 박스
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isMine
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(14),
                  topRight: const Radius.circular(14),
                  bottomLeft: Radius.circular(isMine ? 14 : 4),
                  bottomRight: Radius.circular(isMine ? 4 : 14),
                ),
              ),
              child: Column(
                crossAxisAlignment: isMine
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String iso) {
    final dt = DateTime.tryParse(iso)?.toLocal();
    if (dt == null) return '';
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({required this.controller, required this.onSend});

  final TextEditingController controller;
  final ValueChanged<String> onSend;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(color: Theme.of(context).dividerColor, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: '메시지 입력...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  isDense: true,
                ),
                onSubmitted: onSend,
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: () => onSend(controller.text),
              child: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupedChatList extends StatelessWidget {
  const _GroupedChatList({
    required this.messages,
    required this.me,
    required this.userById,
    required this.controller,
    required this.reverse,
  });

  final List<dynamic> messages;
  final String me;
  final Map<String, AppUser> userById;
  final ScrollController controller;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return Center(
        child: Text(
          "이전 대화를 불러올 수 없습니다.",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }
    final groups = <String, List<dynamic>>{};
    for (final m in messages) {
      final day = _dayKey(m.timestamp);
      groups.putIfAbsent(day, () => []).add(m);
    }
    final orderedDays = groups.keys.toList()..sort((a, b) => a.compareTo(b));

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      controller: controller,
      itemCount: orderedDays.length,
      reverse: reverse,
      itemBuilder: (context, dayIndex) {
        final day = orderedDays[dayIndex];
        final list = groups[day]!
          ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    day,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
            ),
            ...list.map((msg) {
              final isMine = msg.sender == me;
              return _MessageBubble(
                message: msg,
                isMine: isMine,
                sender: userById[msg.sender],
              );
            }),
          ],
        );
      },
    );
  }

  String _dayKey(String iso) {
    final dt = DateTime.tryParse(iso)?.toLocal();
    if (dt == null) return '';
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}
