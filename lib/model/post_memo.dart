import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_memo.freezed.dart';

@freezed
abstract class PostMemo implements _$PostMemo {

  const PostMemo._();

  const factory PostMemo({
    @Default("") String text,
    @Default("") String imageUrl,
  }) = _PostMemo;

  factory PostMemo.from(Map<String, dynamic> map) {
    return PostMemo(
      text: map["text"] ?? "",
      imageUrl: map["imageUrl"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'imageUrl': imageUrl,
    };
  }

}
