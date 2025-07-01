// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserListState {
  bool get isLoading;
  List<User> get items;

  /// Create a copy of UserListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserListStateCopyWith<UserListState> get copyWith =>
      _$UserListStateCopyWithImpl<UserListState>(
          this as UserListState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserListState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other.items, items));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(items));

  @override
  String toString() {
    return 'UserListState(isLoading: $isLoading, items: $items)';
  }
}

/// @nodoc
abstract mixin class $UserListStateCopyWith<$Res> {
  factory $UserListStateCopyWith(
          UserListState value, $Res Function(UserListState) _then) =
      _$UserListStateCopyWithImpl;
  @useResult
  $Res call({bool isLoading, List<User> items});
}

/// @nodoc
class _$UserListStateCopyWithImpl<$Res>
    implements $UserListStateCopyWith<$Res> {
  _$UserListStateCopyWithImpl(this._self, this._then);

  final UserListState _self;
  final $Res Function(UserListState) _then;

  /// Create a copy of UserListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? items = null,
  }) {
    return _then(_self.copyWith(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<User>,
    ));
  }
}

/// @nodoc

class _UserListState implements UserListState {
  const _UserListState(
      {this.isLoading = false, final List<User> items = const []})
      : _items = items;

  @override
  @JsonKey()
  final bool isLoading;
  final List<User> _items;
  @override
  @JsonKey()
  List<User> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Create a copy of UserListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserListStateCopyWith<_UserListState> get copyWith =>
      __$UserListStateCopyWithImpl<_UserListState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserListState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isLoading, const DeepCollectionEquality().hash(_items));

  @override
  String toString() {
    return 'UserListState(isLoading: $isLoading, items: $items)';
  }
}

/// @nodoc
abstract mixin class _$UserListStateCopyWith<$Res>
    implements $UserListStateCopyWith<$Res> {
  factory _$UserListStateCopyWith(
          _UserListState value, $Res Function(_UserListState) _then) =
      __$UserListStateCopyWithImpl;
  @override
  @useResult
  $Res call({bool isLoading, List<User> items});
}

/// @nodoc
class __$UserListStateCopyWithImpl<$Res>
    implements _$UserListStateCopyWith<$Res> {
  __$UserListStateCopyWithImpl(this._self, this._then);

  final _UserListState _self;
  final $Res Function(_UserListState) _then;

  /// Create a copy of UserListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isLoading = null,
    Object? items = null,
  }) {
    return _then(_UserListState(
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<User>,
    ));
  }
}

// dart format on
