import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/model/user.dart';
import 'package:inari_log/repository/user_repository.dart';
import 'package:inari_log/repository/user_repository_imp.dart';

final globalMenuViewModelProvider =
    ChangeNotifierProvider((ref) => GlobalMenuViewModel(ref.read));

class GlobalMenuViewModel extends ChangeNotifier {
  GlobalMenuViewModel(this._reader) {
    checkLoginStatus();
  }

  final Reader _reader;

  User? _user;
  User? get user => _user;

  bool _isLogin = false;
  bool get isLogin => _isLogin;

  late final UserRepository _repository = _reader(userRepositoryProvider);

  void checkLoginStatus() async {

    _user = await _repository.getCurrentUser();
    _isLogin = _user != null;

    print("isLogin:$_isLogin");
    notifyListeners();

    //再リロード時にnullが返ってくる場合があるため、遅延して再チェック
    if(_isLogin == false) {
      await Future.delayed(Duration(seconds: 1));
      _user = await _repository.getCurrentUser();
      _isLogin = _user != null;
      notifyListeners();
    }

  }

}