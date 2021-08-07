import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

@freezed
abstract class Post implements _$Post {
  const factory Post({
    @Default("") String id,
    @Default("") String name,
    @Default("") String memo,
    @Default("") String address,
    DateTime? createdAt,
    @Default("") String userId,
    @Default("") String userName,
    @Default("") String userIcon,
    @Default([]) List<String> imageUrls,
  }) = _Post;

  factory Post.from(Map<String, dynamic> map) {
    List<String> imageUrls = [];
    if (map["imageUrls"] is List<dynamic>) {
      imageUrls =
          (map["imageUrls"] as List<dynamic>).map((e) => e as String).toList();
    }

    return Post(
        id: map["id"] ?? "",
        name: map["name"] ?? "",
        memo: map["memo"] ?? "",
        address: map["address"] ?? "",
        userId: map["userId"] ?? "",
        userName: map["userName"] ?? "",
        userIcon: map["userIcon"] ?? "",
        imageUrls: imageUrls,
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
