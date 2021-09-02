// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PostTearOff {
  const _$PostTearOff();

  _Post call(
      {dynamic id = "",
      String name = "",
      String prefecture = "",
      String municipality = "",
      String houseNumber = "",
      String address = "",
      List<PostMemo> memos = const [],
      String userId = "",
      String userName = "",
      String userIconUrl = "",
      GeoPoint? location,
      DateTime? visitedDate,
      DateTime? updatedAt,
      DateTime? createdAt}) {
    return _Post(
      id: id,
      name: name,
      prefecture: prefecture,
      municipality: municipality,
      houseNumber: houseNumber,
      address: address,
      memos: memos,
      userId: userId,
      userName: userName,
      userIconUrl: userIconUrl,
      location: location,
      visitedDate: visitedDate,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }
}

/// @nodoc
const $Post = _$PostTearOff();

/// @nodoc
mixin _$Post {
  dynamic get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get prefecture => throw _privateConstructorUsedError;
  String get municipality => throw _privateConstructorUsedError;
  String get houseNumber => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  List<PostMemo> get memos => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get userIconUrl => throw _privateConstructorUsedError;
  GeoPoint? get location => throw _privateConstructorUsedError;
  DateTime? get visitedDate => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res>;
  $Res call(
      {dynamic id,
      String name,
      String prefecture,
      String municipality,
      String houseNumber,
      String address,
      List<PostMemo> memos,
      String userId,
      String userName,
      String userIconUrl,
      GeoPoint? location,
      DateTime? visitedDate,
      DateTime? updatedAt,
      DateTime? createdAt});
}

/// @nodoc
class _$PostCopyWithImpl<$Res> implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  final Post _value;
  // ignore: unused_field
  final $Res Function(Post) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? prefecture = freezed,
    Object? municipality = freezed,
    Object? houseNumber = freezed,
    Object? address = freezed,
    Object? memos = freezed,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? userIconUrl = freezed,
    Object? location = freezed,
    Object? visitedDate = freezed,
    Object? updatedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      prefecture: prefecture == freezed
          ? _value.prefecture
          : prefecture // ignore: cast_nullable_to_non_nullable
              as String,
      municipality: municipality == freezed
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as String,
      houseNumber: houseNumber == freezed
          ? _value.houseNumber
          : houseNumber // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      memos: memos == freezed
          ? _value.memos
          : memos // ignore: cast_nullable_to_non_nullable
              as List<PostMemo>,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userIconUrl: userIconUrl == freezed
          ? _value.userIconUrl
          : userIconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
      visitedDate: visitedDate == freezed
          ? _value.visitedDate
          : visitedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$PostCopyWith(_Post value, $Res Function(_Post) then) =
      __$PostCopyWithImpl<$Res>;
  @override
  $Res call(
      {dynamic id,
      String name,
      String prefecture,
      String municipality,
      String houseNumber,
      String address,
      List<PostMemo> memos,
      String userId,
      String userName,
      String userIconUrl,
      GeoPoint? location,
      DateTime? visitedDate,
      DateTime? updatedAt,
      DateTime? createdAt});
}

/// @nodoc
class __$PostCopyWithImpl<$Res> extends _$PostCopyWithImpl<$Res>
    implements _$PostCopyWith<$Res> {
  __$PostCopyWithImpl(_Post _value, $Res Function(_Post) _then)
      : super(_value, (v) => _then(v as _Post));

  @override
  _Post get _value => super._value as _Post;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? prefecture = freezed,
    Object? municipality = freezed,
    Object? houseNumber = freezed,
    Object? address = freezed,
    Object? memos = freezed,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? userIconUrl = freezed,
    Object? location = freezed,
    Object? visitedDate = freezed,
    Object? updatedAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_Post(
      id: id == freezed ? _value.id : id,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      prefecture: prefecture == freezed
          ? _value.prefecture
          : prefecture // ignore: cast_nullable_to_non_nullable
              as String,
      municipality: municipality == freezed
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as String,
      houseNumber: houseNumber == freezed
          ? _value.houseNumber
          : houseNumber // ignore: cast_nullable_to_non_nullable
              as String,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      memos: memos == freezed
          ? _value.memos
          : memos // ignore: cast_nullable_to_non_nullable
              as List<PostMemo>,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userIconUrl: userIconUrl == freezed
          ? _value.userIconUrl
          : userIconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
      visitedDate: visitedDate == freezed
          ? _value.visitedDate
          : visitedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_Post extends _Post {
  const _$_Post(
      {this.id = "",
      this.name = "",
      this.prefecture = "",
      this.municipality = "",
      this.houseNumber = "",
      this.address = "",
      this.memos = const [],
      this.userId = "",
      this.userName = "",
      this.userIconUrl = "",
      this.location,
      this.visitedDate,
      this.updatedAt,
      this.createdAt})
      : super._();

  @JsonKey(defaultValue: "")
  @override
  final dynamic id;
  @JsonKey(defaultValue: "")
  @override
  final String name;
  @JsonKey(defaultValue: "")
  @override
  final String prefecture;
  @JsonKey(defaultValue: "")
  @override
  final String municipality;
  @JsonKey(defaultValue: "")
  @override
  final String houseNumber;
  @JsonKey(defaultValue: "")
  @override
  final String address;
  @JsonKey(defaultValue: const [])
  @override
  final List<PostMemo> memos;
  @JsonKey(defaultValue: "")
  @override
  final String userId;
  @JsonKey(defaultValue: "")
  @override
  final String userName;
  @JsonKey(defaultValue: "")
  @override
  final String userIconUrl;
  @override
  final GeoPoint? location;
  @override
  final DateTime? visitedDate;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Post(id: $id, name: $name, prefecture: $prefecture, municipality: $municipality, houseNumber: $houseNumber, address: $address, memos: $memos, userId: $userId, userName: $userName, userIconUrl: $userIconUrl, location: $location, visitedDate: $visitedDate, updatedAt: $updatedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Post &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.prefecture, prefecture) ||
                const DeepCollectionEquality()
                    .equals(other.prefecture, prefecture)) &&
            (identical(other.municipality, municipality) ||
                const DeepCollectionEquality()
                    .equals(other.municipality, municipality)) &&
            (identical(other.houseNumber, houseNumber) ||
                const DeepCollectionEquality()
                    .equals(other.houseNumber, houseNumber)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.memos, memos) ||
                const DeepCollectionEquality().equals(other.memos, memos)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.userName, userName) ||
                const DeepCollectionEquality()
                    .equals(other.userName, userName)) &&
            (identical(other.userIconUrl, userIconUrl) ||
                const DeepCollectionEquality()
                    .equals(other.userIconUrl, userIconUrl)) &&
            (identical(other.location, location) ||
                const DeepCollectionEquality()
                    .equals(other.location, location)) &&
            (identical(other.visitedDate, visitedDate) ||
                const DeepCollectionEquality()
                    .equals(other.visitedDate, visitedDate)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(prefecture) ^
      const DeepCollectionEquality().hash(municipality) ^
      const DeepCollectionEquality().hash(houseNumber) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(memos) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(userName) ^
      const DeepCollectionEquality().hash(userIconUrl) ^
      const DeepCollectionEquality().hash(location) ^
      const DeepCollectionEquality().hash(visitedDate) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(createdAt);

  @JsonKey(ignore: true)
  @override
  _$PostCopyWith<_Post> get copyWith =>
      __$PostCopyWithImpl<_Post>(this, _$identity);
}

abstract class _Post extends Post {
  const factory _Post(
      {dynamic id,
      String name,
      String prefecture,
      String municipality,
      String houseNumber,
      String address,
      List<PostMemo> memos,
      String userId,
      String userName,
      String userIconUrl,
      GeoPoint? location,
      DateTime? visitedDate,
      DateTime? updatedAt,
      DateTime? createdAt}) = _$_Post;
  const _Post._() : super._();

  @override
  dynamic get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get prefecture => throw _privateConstructorUsedError;
  @override
  String get municipality => throw _privateConstructorUsedError;
  @override
  String get houseNumber => throw _privateConstructorUsedError;
  @override
  String get address => throw _privateConstructorUsedError;
  @override
  List<PostMemo> get memos => throw _privateConstructorUsedError;
  @override
  String get userId => throw _privateConstructorUsedError;
  @override
  String get userName => throw _privateConstructorUsedError;
  @override
  String get userIconUrl => throw _privateConstructorUsedError;
  @override
  GeoPoint? get location => throw _privateConstructorUsedError;
  @override
  DateTime? get visitedDate => throw _privateConstructorUsedError;
  @override
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @override
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PostCopyWith<_Post> get copyWith => throw _privateConstructorUsedError;
}
