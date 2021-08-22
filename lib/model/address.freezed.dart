// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'address.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AddressTearOff {
  const _$AddressTearOff();

  _Address call(
      {String prefecture = "",
      String municipality = "",
      String localSection = "",
      String homeNumber = ""}) {
    return _Address(
      prefecture: prefecture,
      municipality: municipality,
      localSection: localSection,
      homeNumber: homeNumber,
    );
  }
}

/// @nodoc
const $Address = _$AddressTearOff();

/// @nodoc
mixin _$Address {
  String get prefecture => throw _privateConstructorUsedError;
  String get municipality => throw _privateConstructorUsedError;
  String get localSection => throw _privateConstructorUsedError;
  String get homeNumber => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddressCopyWith<Address> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressCopyWith<$Res> {
  factory $AddressCopyWith(Address value, $Res Function(Address) then) =
      _$AddressCopyWithImpl<$Res>;
  $Res call(
      {String prefecture,
      String municipality,
      String localSection,
      String homeNumber});
}

/// @nodoc
class _$AddressCopyWithImpl<$Res> implements $AddressCopyWith<$Res> {
  _$AddressCopyWithImpl(this._value, this._then);

  final Address _value;
  // ignore: unused_field
  final $Res Function(Address) _then;

  @override
  $Res call({
    Object? prefecture = freezed,
    Object? municipality = freezed,
    Object? localSection = freezed,
    Object? homeNumber = freezed,
  }) {
    return _then(_value.copyWith(
      prefecture: prefecture == freezed
          ? _value.prefecture
          : prefecture // ignore: cast_nullable_to_non_nullable
              as String,
      municipality: municipality == freezed
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as String,
      localSection: localSection == freezed
          ? _value.localSection
          : localSection // ignore: cast_nullable_to_non_nullable
              as String,
      homeNumber: homeNumber == freezed
          ? _value.homeNumber
          : homeNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$AddressCopyWith<$Res> implements $AddressCopyWith<$Res> {
  factory _$AddressCopyWith(_Address value, $Res Function(_Address) then) =
      __$AddressCopyWithImpl<$Res>;
  @override
  $Res call(
      {String prefecture,
      String municipality,
      String localSection,
      String homeNumber});
}

/// @nodoc
class __$AddressCopyWithImpl<$Res> extends _$AddressCopyWithImpl<$Res>
    implements _$AddressCopyWith<$Res> {
  __$AddressCopyWithImpl(_Address _value, $Res Function(_Address) _then)
      : super(_value, (v) => _then(v as _Address));

  @override
  _Address get _value => super._value as _Address;

  @override
  $Res call({
    Object? prefecture = freezed,
    Object? municipality = freezed,
    Object? localSection = freezed,
    Object? homeNumber = freezed,
  }) {
    return _then(_Address(
      prefecture: prefecture == freezed
          ? _value.prefecture
          : prefecture // ignore: cast_nullable_to_non_nullable
              as String,
      municipality: municipality == freezed
          ? _value.municipality
          : municipality // ignore: cast_nullable_to_non_nullable
              as String,
      localSection: localSection == freezed
          ? _value.localSection
          : localSection // ignore: cast_nullable_to_non_nullable
              as String,
      homeNumber: homeNumber == freezed
          ? _value.homeNumber
          : homeNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Address extends _Address {
  const _$_Address(
      {this.prefecture = "",
      this.municipality = "",
      this.localSection = "",
      this.homeNumber = ""})
      : super._();

  @JsonKey(defaultValue: "")
  @override
  final String prefecture;
  @JsonKey(defaultValue: "")
  @override
  final String municipality;
  @JsonKey(defaultValue: "")
  @override
  final String localSection;
  @JsonKey(defaultValue: "")
  @override
  final String homeNumber;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Address &&
            (identical(other.prefecture, prefecture) ||
                const DeepCollectionEquality()
                    .equals(other.prefecture, prefecture)) &&
            (identical(other.municipality, municipality) ||
                const DeepCollectionEquality()
                    .equals(other.municipality, municipality)) &&
            (identical(other.localSection, localSection) ||
                const DeepCollectionEquality()
                    .equals(other.localSection, localSection)) &&
            (identical(other.homeNumber, homeNumber) ||
                const DeepCollectionEquality()
                    .equals(other.homeNumber, homeNumber)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(prefecture) ^
      const DeepCollectionEquality().hash(municipality) ^
      const DeepCollectionEquality().hash(localSection) ^
      const DeepCollectionEquality().hash(homeNumber);

  @JsonKey(ignore: true)
  @override
  _$AddressCopyWith<_Address> get copyWith =>
      __$AddressCopyWithImpl<_Address>(this, _$identity);
}

abstract class _Address extends Address {
  const factory _Address(
      {String prefecture,
      String municipality,
      String localSection,
      String homeNumber}) = _$_Address;
  const _Address._() : super._();

  @override
  String get prefecture => throw _privateConstructorUsedError;
  @override
  String get municipality => throw _privateConstructorUsedError;
  @override
  String get localSection => throw _privateConstructorUsedError;
  @override
  String get homeNumber => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AddressCopyWith<_Address> get copyWith =>
      throw _privateConstructorUsedError;
}
