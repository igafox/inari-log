import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  factory User({
    String? id,
    String? title,
  }) = _User;

  // factory Vote.from(Map<dynamic, dynamic> map) {
  //   return Vote(
  //     id: map["id"],
  //     title: map["title"],
  //     options: (map["options"] as Map)
  //         .values
  //         .map((e) => VoteOption.from(e as Map))
  //         .toList(),
  //     total: map["totalVote"],
  //     open: map["isOpen"],
  //   );
  // }

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
