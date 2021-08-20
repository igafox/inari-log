import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_memo.freezed.dart';

@freezed
abstract class PostMemo implements _$PostMemo {
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

// Map<String, dynamic> toMap() {
//   return {
//     "id": this.id,
//     "name": this.name,
//     "memo": this.memo,
//     "address": this.address,
//     "userId": this.userId,
//     "userName": this.userName,
//     "images": this.imageUrls,
//     "createDate": this.createdDate
//   };
// }
}
