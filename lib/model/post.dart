import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    @Default("") String id,
    @Default("") String name,
    @Default("") String address,
    DateTime? createdDate,
    @Default("") String userId,
    @Default("") String userName,
    @Default([])List<String> imageUrls,
  }) = _Post;

factory Post.from(Map<String, dynamic> map) {
  print(map);

  return Post(
    id: map["id"] ?? "",
    name: map["name"] ?? "",
    address: map["address"] ?? "",
    userId: map["userId"] ?? "",
    userName: map["userName"] ?? "",
    imageUrls: (map["images"] as List<dynamic>).map((e) => e as String).toList(),
    createdDate: (map["createdDate"] as Timestamp).toDate()
  );
}

// Map<String, dynamic> toMap() {
//   return {
//     "id": id,
//     "title": this.title,
//     "options": "options",
//     "total": total,
//     "open": open
//   };
// }
}
