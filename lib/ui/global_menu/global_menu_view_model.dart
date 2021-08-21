import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/model/user.dart' as model;
import 'package:inari_log/provider/firebase_provider.dart';
import 'package:inari_log/repository/user_repository.dart';
import 'package:inari_log/repository/user_repository_imp.dart';

final globalMenuViewModelProvider =
    ChangeNotifierProvider((ref) => GlobalMenuViewModel(ref.read));

class GlobalMenuViewModel extends ChangeNotifier {
  GlobalMenuViewModel(this._reader);

  final Reader _reader;

  model.User? _user;

  model.User? get user => _user;

  bool _isLogin = false;

  bool get isLogin => _isLogin;

  late final FirebaseAuth _auth = _reader(firebaseAuthProvider);

  late final UserRepository _repository = _reader(userRepositoryProvider);

  void logout(BuildContext context) async {
    await _repository.logout();
    AppRouter.router.navigateTo(context, "/", replace: true);
  }
}
