// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatListController)
const chatListControllerProvider = ChatListControllerProvider._();

final class ChatListControllerProvider
    extends $AsyncNotifierProvider<ChatListController, List<ChatRoom>> {
  const ChatListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatListControllerHash();

  @$internal
  @override
  ChatListController create() => ChatListController();
}

String _$chatListControllerHash() =>
    r'af91be59040470c30c3254e85a49d349994aee4d';

abstract class _$ChatListController extends $AsyncNotifier<List<ChatRoom>> {
  FutureOr<List<ChatRoom>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<ChatRoom>>, List<ChatRoom>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ChatRoom>>, List<ChatRoom>>,
              AsyncValue<List<ChatRoom>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
