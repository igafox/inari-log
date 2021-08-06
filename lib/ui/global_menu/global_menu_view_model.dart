import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/model/user.dart';

final globalMenuViewModelProvider =
    ChangeNotifierProvider((ref) => GlobalMenuViewModel(ref.read));

class GlobalMenuViewModel extends ChangeNotifier {
  GlobalMenuViewModel(this._reader);

  final Reader _reader;

  User? _user;
  User? get user => _user;

  bool _isLogin = false;
  bool get isLogin => _isLogin;

  // late final AuthRepository _repository = _reader(authRepositoryProvider);

   void changeStatus(bool login) {
     _isLogin = login;
     notifyListeners();
   }

}