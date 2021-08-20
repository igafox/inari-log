import 'dart:typed_data';

import 'package:inari_log/model/user.dart';

abstract class UserRepository {

  Future<bool> create(String email,String password,String userName,Uint8List profileImage);

  Future<bool> isLogin();

  Future<User?> getUser(String id);

  Stream<User?> getCurrentUser();

  Future<bool> logout();

  Future<bool> delete();

}
