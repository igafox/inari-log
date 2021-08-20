import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inari_log/model/post_memo.dart';

part 'post.freezed.dart';

@freezed
abstract class Post implements _$Post {
  const factory Post({
    @Default("") String id,
    @Default("") String name,
    @Default("") String address,
    @Default([]) List<PostMemo> memos,
    @Default("") String userId,
    @Default("") String userName,
    @Default("") String userIcon,
    DateTime? createdAt,
  }) = _Post;

  factory Post.from(Map<String, dynamic> map) {
    List<PostMemo> memos = [];
    if (map["memos"] is List<dynamic>) {
      memos =
          (map["memos"] as List<dynamic>).map((e) => PostMemo.from(e)).toList();
    }

    return Post(
        id: map["id"] ?? "",
        name: map["name"] ?? "",
        address: map["address"] ?? "",
        memos: memos,
        userId: map["userId"] ?? "",
        userName: map["userName"] ?? "",
        userIcon: map["userIcon"] ?? "",
        createdAt: (map["createdAt"] as Timestamp).toDate());
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
