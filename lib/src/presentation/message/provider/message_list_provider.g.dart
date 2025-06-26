// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messageListHash() => r'7c63c3d4ab3ae6be39347ca7f7f8ad72fddc57a6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MessageList
    extends BuildlessAsyncNotifier<List<MessageEntity>> {
  late final String roomId;

  FutureOr<List<MessageEntity>> build(
    String roomId,
  );
}

/// See also [MessageList].
@ProviderFor(MessageList)
const messageListProvider = MessageListFamily();

/// See also [MessageList].
class MessageListFamily extends Family<AsyncValue<List<MessageEntity>>> {
  /// See also [MessageList].
  const MessageListFamily();

  /// See also [MessageList].
  MessageListProvider call(
    String roomId,
  ) {
    return MessageListProvider(
      roomId,
    );
  }

  @override
  MessageListProvider getProviderOverride(
    covariant MessageListProvider provider,
  ) {
    return call(
      provider.roomId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'messageListProvider';
}

/// See also [MessageList].
class MessageListProvider
    extends AsyncNotifierProviderImpl<MessageList, List<MessageEntity>> {
  /// See also [MessageList].
  MessageListProvider(
    String roomId,
  ) : this._internal(
          () => MessageList()..roomId = roomId,
          from: messageListProvider,
          name: r'messageListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messageListHash,
          dependencies: MessageListFamily._dependencies,
          allTransitiveDependencies:
              MessageListFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  MessageListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roomId,
  }) : super.internal();

  final String roomId;

  @override
  FutureOr<List<MessageEntity>> runNotifierBuild(
    covariant MessageList notifier,
  ) {
    return notifier.build(
      roomId,
    );
  }

  @override
  Override overrideWith(MessageList Function() create) {
    return ProviderOverride(
      origin: this,
      override: MessageListProvider._internal(
        () => create()..roomId = roomId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roomId: roomId,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<MessageList, List<MessageEntity>>
      createElement() {
    return _MessageListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MessageListProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MessageListRef on AsyncNotifierProviderRef<List<MessageEntity>> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _MessageListProviderElement
    extends AsyncNotifierProviderElement<MessageList, List<MessageEntity>>
    with MessageListRef {
  _MessageListProviderElement(super.provider);

  @override
  String get roomId => (origin as MessageListProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
