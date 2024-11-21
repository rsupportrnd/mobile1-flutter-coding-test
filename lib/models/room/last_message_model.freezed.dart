// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'last_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LastMessageModel _$LastMessageModelFromJson(Map<String, dynamic> json) {
  return _LastMessageModel.fromJson(json);
}

/// @nodoc
mixin _$LastMessageModel {
  String get sender => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;

  /// Serializes this LastMessageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LastMessageModelCopyWith<LastMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastMessageModelCopyWith<$Res> {
  factory $LastMessageModelCopyWith(
          LastMessageModel value, $Res Function(LastMessageModel) then) =
      _$LastMessageModelCopyWithImpl<$Res, LastMessageModel>;
  @useResult
  $Res call({String sender, String content, String timestamp});
}

/// @nodoc
class _$LastMessageModelCopyWithImpl<$Res, $Val extends LastMessageModel>
    implements $LastMessageModelCopyWith<$Res> {
  _$LastMessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sender = null,
    Object? content = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LastMessageModelImplCopyWith<$Res>
    implements $LastMessageModelCopyWith<$Res> {
  factory _$$LastMessageModelImplCopyWith(_$LastMessageModelImpl value,
          $Res Function(_$LastMessageModelImpl) then) =
      __$$LastMessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String sender, String content, String timestamp});
}

/// @nodoc
class __$$LastMessageModelImplCopyWithImpl<$Res>
    extends _$LastMessageModelCopyWithImpl<$Res, _$LastMessageModelImpl>
    implements _$$LastMessageModelImplCopyWith<$Res> {
  __$$LastMessageModelImplCopyWithImpl(_$LastMessageModelImpl _value,
      $Res Function(_$LastMessageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sender = null,
    Object? content = null,
    Object? timestamp = null,
  }) {
    return _then(_$LastMessageModelImpl(
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LastMessageModelImpl implements _LastMessageModel {
  const _$LastMessageModelImpl(
      {required this.sender, required this.content, required this.timestamp});

  factory _$LastMessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastMessageModelImplFromJson(json);

  @override
  final String sender;
  @override
  final String content;
  @override
  final String timestamp;

  @override
  String toString() {
    return 'LastMessageModel(sender: $sender, content: $content, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastMessageModelImpl &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sender, content, timestamp);

  /// Create a copy of LastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LastMessageModelImplCopyWith<_$LastMessageModelImpl> get copyWith =>
      __$$LastMessageModelImplCopyWithImpl<_$LastMessageModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LastMessageModelImplToJson(
      this,
    );
  }
}

abstract class _LastMessageModel implements LastMessageModel {
  const factory _LastMessageModel(
      {required final String sender,
      required final String content,
      required final String timestamp}) = _$LastMessageModelImpl;

  factory _LastMessageModel.fromJson(Map<String, dynamic> json) =
      _$LastMessageModelImpl.fromJson;

  @override
  String get sender;
  @override
  String get content;
  @override
  String get timestamp;

  /// Create a copy of LastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LastMessageModelImplCopyWith<_$LastMessageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
