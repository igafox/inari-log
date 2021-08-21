// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'post_memo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PostMemoTearOff {
  const _$PostMemoTearOff();

  _PostMemo call({String text = "", String imageUrl = ""}) {
    return _PostMemo(
      text: text,
      imageUrl: imageUrl,
    );
  }
}

/// @nodoc
const $PostMemo = _$PostMemoTearOff();

/// @nodoc
mixin _$PostMemo {
  String get text => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PostMemoCopyWith<PostMemo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostMemoCopyWith<$Res> {
  factory $PostMemoCopyWith(PostMemo value, $Res Function(PostMemo) then) =
      _$PostMemoCopyWithImpl<$Res>;
  $Res call({String text, String imageUrl});
}

/// @nodoc
class _$PostMemoCopyWithImpl<$Res> implements $PostMemoCopyWith<$Res> {
  _$PostMemoCopyWithImpl(this._value, this._then);

  final PostMemo _value;
  // ignore: unused_field
  final $Res Function(PostMemo) _then;

  @override
  $Res call({
    Object? text = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$PostMemoCopyWith<$Res> implements $PostMemoCopyWith<$Res> {
  factory _$PostMemoCopyWith(_PostMemo value, $Res Function(_PostMemo) then) =
      __$PostMemoCopyWithImpl<$Res>;
  @override
  $Res call({String text, String imageUrl});
}

/// @nodoc
class __$PostMemoCopyWithImpl<$Res> extends _$PostMemoCopyWithImpl<$Res>
    implements _$PostMemoCopyWith<$Res> {
  __$PostMemoCopyWithImpl(_PostMemo _value, $Res Function(_PostMemo) _then)
      : super(_value, (v) => _then(v as _PostMemo));

  @override
  _PostMemo get _value => super._value as _PostMemo;

  @override
  $Res call({
    Object? text = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_PostMemo(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: imageUrl == freezed
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_PostMemo extends _PostMemo {
  const _$_PostMemo({this.text = "", this.imageUrl = ""}) : super._();

  @JsonKey(defaultValue: "")
  @override
  final String text;
  @JsonKey(defaultValue: "")
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'PostMemo(text: $text, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PostMemo &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(text) ^
      const DeepCollectionEquality().hash(imageUrl);

  @JsonKey(ignore: true)
  @override
  _$PostMemoCopyWith<_PostMemo> get copyWith =>
      __$PostMemoCopyWithImpl<_PostMemo>(this, _$identity);
}

abstract class _PostMemo extends PostMemo {
  const factory _PostMemo({String text, String imageUrl}) = _$_PostMemo;
  const _PostMemo._() : super._();

  @override
  String get text => throw _privateConstructorUsedError;
  @override
  String get imageUrl => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PostMemoCopyWith<_PostMemo> get copyWith =>
      throw _privateConstructorUsedError;
}
