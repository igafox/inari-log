import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User implements _$User {
  const User._();

  factory User({
    String? id,
    String? name,
    String? location,
    String? comment,
    String? imageUrl,
  }) = _User;

  factory User.from(Map<dynamic, dynamic> map) {
    return User(
      id: map["id"],
      name: map["name"],
      location: map["location"],
      comment: map["comment"],
      imageUrl: map["imageUrl"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "name": this.name,
      "location": this.location,
      "comment": this.comment,
      "imageUrl":this.imageUrl,
    };
  }

}
