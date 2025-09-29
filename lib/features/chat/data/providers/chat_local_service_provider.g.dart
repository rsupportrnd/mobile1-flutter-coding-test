// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_local_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(chatLocalService)
const chatLocalServiceProvider = ChatLocalServiceProvider._();

final class ChatLocalServiceProvider
    extends
        $FunctionalProvider<
          ChatLocalService,
          ChatLocalService,
          ChatLocalService
        >
    with $Provider<ChatLocalService> {
  const ChatLocalServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatLocalServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatLocalServiceHash();

  @$internal
  @override
  $ProviderElement<ChatLocalService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ChatLocalService create(Ref ref) {
    return chatLocalService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatLocalService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatLocalService>(value),
    );
  }
}

String _$chatLocalServiceHash() => r'4f684b215901ff0028efafe1dce187a55733ba42';
