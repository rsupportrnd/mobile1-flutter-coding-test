// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RoomResponseModel _$RoomResponseModelFromJson(Map<String, dynamic> json) {
  return _RoomResponseModel.fromJson(json);
}

/// @nodoc
mixin _$RoomResponseModel {
  List<RoomModel> get chatRooms => throw _privateConstructorUsedError;

  /// Serializes this RoomResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoomResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomResponseModelCopyWith<RoomResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomResponseModelCopyWith<$Res> {
  factory $RoomResponseModelCopyWith(
          RoomResponseModel value, $Res Function(RoomResponseModel) then) =
      _$RoomResponseModelCopyWithImpl<$Res, RoomResponseModel>;
  @useResult
  $Res call({List<RoomModel> chatRooms});
}

/// @nodoc
class _$RoomResponseModelCopyWithImpl<$Res, $Val extends RoomResponseModel>
    implements $RoomResponseModelCopyWith<$Res> {
  _$RoomResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRooms = null,
  }) {
    return _then(_value.copyWith(
      chatRooms: null == chatRooms
          ? _value.chatRooms
          : chatRooms // ignore: cast_nullable_to_non_nullable
              as List<RoomModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomResponseModelImplCopyWith<$Res>
    implements $RoomResponseModelCopyWith<$Res> {
  factory _$$RoomResponseModelImplCopyWith(_$RoomResponseModelImpl value,
          $Res Function(_$RoomResponseModelImpl) then) =
      __$$RoomResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<RoomModel> chatRooms});
}

/// @nodoc
class __$$RoomResponseModelImplCopyWithImpl<$Res>
    extends _$RoomResponseModelCopyWithImpl<$Res, _$RoomResponseModelImpl>
    implements _$$RoomResponseModelImplCopyWith<$Res> {
  __$$RoomResponseModelImplCopyWithImpl(_$RoomResponseModelImpl _value,
      $Res Function(_$RoomResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoomResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatRooms = null,
  }) {
    return _then(_$RoomResponseModelImpl(
      chatRooms: null == chatRooms
          ? _value._chatRooms
          : chatRooms // ignore: cast_nullable_to_non_nullable
              as List<RoomModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomResponseModelImpl
    with DiagnosticableTreeMixin
    implements _RoomResponseModel {
  const _$RoomResponseModelImpl({required final List<RoomModel> chatRooms})
      : _chatRooms = chatRooms;

  factory _$RoomResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomResponseModelImplFromJson(json);

  final List<RoomModel> _chatRooms;
  @override
  List<RoomModel> get chatRooms {
    if (_chatRooms is EqualUnmodifiableListView) return _chatRooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatRooms);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RoomResponseModel(chatRooms: $chatRooms)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RoomResponseModel'))
      ..add(DiagnosticsProperty('chatRooms', chatRooms));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomResponseModelImpl &&
            const DeepCollectionEquality()
                .equals(other._chatRooms, _chatRooms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_chatRooms));

  /// Create a copy of RoomResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomResponseModelImplCopyWith<_$RoomResponseModelImpl> get copyWith =>
      __$$RoomResponseModelImplCopyWithImpl<_$RoomResponseModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomResponseModelImplToJson(
      this,
    );
  }
}

abstract class _RoomResponseModel implements RoomResponseModel {
  const factory _RoomResponseModel({required final List<RoomModel> chatRooms}) =
      _$RoomResponseModelImpl;

  factory _RoomResponseModel.fromJson(Map<String, dynamic> json) =
      _$RoomResponseModelImpl.fromJson;

  @override
  List<RoomModel> get chatRooms;

  /// Create a copy of RoomResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomResponseModelImplCopyWith<_$RoomResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
