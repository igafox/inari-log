import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User implements _$User {
  factory User({
    String? id,
    String? name,
    String? iconUrl,
  }) = _User;

  factory User.from(Map<dynamic, dynamic> map) {
    return User(
      id: map["id"],
      name: map["name"],
      iconUrl: map["iconUrl"],
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     "id": this.id,
  //     "name": this.name,
  //     "iconUrl": this.iconUrl,
  //   };
  // }

}
