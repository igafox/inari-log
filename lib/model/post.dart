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
    DateTime? createdDate,
    @Default("") String userId,
    @Default("") String userName,
    @Default([]) List<String> imageUrls,
  }) = _Post;

  factory Post.from(Map<String, dynamic> map) {
    return Post(
        id: map["id"] ?? "",
        name: map["name"] ?? "",
        memo: map["memo"] ?? "",
        address: map["address"] ?? "",
        userId: map["userId"] ?? "",
        userName: map["userName"] ?? "",
        imageUrls:
            (map["images"] as List<dynamic>).map((e) => e as String).toList(),
        createdDate: (map["createdDate"] as Timestamp).toDate());
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
