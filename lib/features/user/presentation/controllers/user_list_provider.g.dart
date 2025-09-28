// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserListController)
const userListControllerProvider = UserListControllerProvider._();

final class UserListControllerProvider
    extends $AsyncNotifierProvider<UserListController, List<User>> {
  const UserListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userListControllerHash();

  @$internal
  @override
  UserListController create() => UserListController();
}

String _$userListControllerHash() =>
    r'5baed943bad9323b139f4b0200a1620c84c0175c';

abstract class _$UserListController extends $AsyncNotifier<List<User>> {
  FutureOr<List<User>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<User>>, List<User>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<User>>, List<User>>,
              AsyncValue<List<User>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
