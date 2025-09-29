// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_messages_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatMessagesController)
const chatMessagesControllerProvider = ChatMessagesControllerFamily._();

final class ChatMessagesControllerProvider
    extends $AsyncNotifierProvider<ChatMessagesController, List<ChatMessage>> {
  const ChatMessagesControllerProvider._({
    required ChatMessagesControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'chatMessagesControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatMessagesControllerHash();

  @override
  String toString() {
    return r'chatMessagesControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatMessagesController create() => ChatMessagesController();

  @override
  bool operator ==(Object other) {
    return other is ChatMessagesControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatMessagesControllerHash() =>
    r'b9ed52ce6eaf696a0cbf9d816a782e3de558dc88';

final class ChatMessagesControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatMessagesController,
          AsyncValue<List<ChatMessage>>,
          List<ChatMessage>,
          FutureOr<List<ChatMessage>>,
          String
        > {
  const ChatMessagesControllerFamily._()
    : super(
        retry: null,
        name: r'chatMessagesControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChatMessagesControllerProvider call(String roomId) =>
      ChatMessagesControllerProvider._(argument: roomId, from: this);

  @override
  String toString() => r'chatMessagesControllerProvider';
}

abstract class _$ChatMessagesController
    extends $AsyncNotifier<List<ChatMessage>> {
  late final _$args = ref.$arg as String;
  String get roomId => _$args;

  FutureOr<List<ChatMessage>> build(String roomId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<List<ChatMessage>>, List<ChatMessage>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ChatMessage>>, List<ChatMessage>>,
              AsyncValue<List<ChatMessage>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
