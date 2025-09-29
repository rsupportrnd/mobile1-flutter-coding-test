// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

 String get userId; String get name; String get email; String get profilePicture;@JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) UserStatus get status;@JsonKey(fromJson: _roleFromJson, toJson: _roleToJson) UserRole get role;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.status, status) || other.status == status)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,name,email,profilePicture,status,role);

@override
String toString() {
  return 'User(userId: $userId, name: $name, email: $email, profilePicture: $profilePicture, status: $status, role: $role)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 String userId, String name, String email, String profilePicture,@JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) UserStatus status,@JsonKey(fromJson: _roleFromJson, toJson: _roleToJson) UserRole role
});




}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? name = null,Object? email = null,Object? profilePicture = null,Object? status = null,Object? role = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,profilePicture: null == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserStatus,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,
  ));
}

}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String name,  String email,  String profilePicture, @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)  UserStatus status, @JsonKey(fromJson: _roleFromJson, toJson: _roleToJson)  UserRole role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.userId,_that.name,_that.email,_that.profilePicture,_that.status,_that.role);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String name,  String email,  String profilePicture, @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)  UserStatus status, @JsonKey(fromJson: _roleFromJson, toJson: _roleToJson)  UserRole role)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.userId,_that.name,_that.email,_that.profilePicture,_that.status,_that.role);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String name,  String email,  String profilePicture, @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)  UserStatus status, @JsonKey(fromJson: _roleFromJson, toJson: _roleToJson)  UserRole role)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.userId,_that.name,_that.email,_that.profilePicture,_that.status,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User implements User {
  const _User({required this.userId, required this.name, required this.email, required this.profilePicture, @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) required this.status, @JsonKey(fromJson: _roleFromJson, toJson: _roleToJson) required this.role});
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override final  String userId;
@override final  String name;
@override final  String email;
@override final  String profilePicture;
@override@JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) final  UserStatus status;
@override@JsonKey(fromJson: _roleFromJson, toJson: _roleToJson) final  UserRole role;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.status, status) || other.status == status)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,name,email,profilePicture,status,role);

@override
String toString() {
  return 'User(userId: $userId, name: $name, email: $email, profilePicture: $profilePicture, status: $status, role: $role)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 String userId, String name, String email, String profilePicture,@JsonKey(fromJson: _statusFromJson, toJson: _statusToJson) UserStatus status,@JsonKey(fromJson: _roleFromJson, toJson: _roleToJson) UserRole role
});




}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? name = null,Object? email = null,Object? profilePicture = null,Object? status = null,Object? role = null,}) {
  return _then(_User(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,profilePicture: null == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserStatus,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,
  ));
}


}

// dart format on
