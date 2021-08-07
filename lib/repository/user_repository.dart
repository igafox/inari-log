import 'package:inari_log/model/user.dart';

abstract class UserRepository {

  Future<bool> isLogin();

  Future<User?> getCurrentUser();

}
