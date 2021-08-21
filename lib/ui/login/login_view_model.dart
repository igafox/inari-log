import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/extension/FirebaseError.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/provider/firebase_provider.dart';
import 'package:inari_log/repository/post_repository.dart';
import 'package:inari_log/repository/post_repository_imp.dart';
import 'package:inari_log/ui/global_menu/global_menu_view_model.dart';

final loginViewModelProvider =
    ChangeNotifierProvider((ref) => LoginViewModel(ref.read));

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._reader) {
    load();
  }

  final Reader _reader;

  // late final AuthRepository _repository = _reader(authRepositoryProvider);

  late final PostRepository _repository = _reader(postRepositoryProvider);
  late final FirebaseAuth _firebaseAuth = _reader(firebaseAuthProvider);

  late final GlobalMenuViewModel _globalMenuViewModel = _reader(globalMenuViewModelProvider);

  bool _loading = false;
  bool get loading => _loading;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  String _email = "";
  String get email => _email;

  String _password = "";
  String get password => _password;

  bool _loginSuccess = false;
  bool get loginSuccess => _loginSuccess;

  List<Post> _post = [];

  List<Post> get post => _post;


  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  void onClickEmailLoginButton(BuildContext context) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: _email, password: _password);

      if (result.user != null) {
        AppRouter.router.navigateTo(
            context, "/");
      } else {
        _errorMessage = "ユーザーの読み込みに失敗しました";
      }

    } on FirebaseAuthException catch(e) {
      print(e);
      _errorMessage = FirebaseAuthUtil.getDisplayMessage(e);
    } catch(e) {
      print(e);
      _errorMessage = "不明なエラーが発生しました";
    }

    notifyListeners();
  }

  void onClickTwiterLoginButton() async {}

  void onClickGoogleLoginButton() async {

  }

  void onClickRegisterEmail(BuildContext context) {
    AppRouter.router.navigateTo(context, "/user/create",);
  }

  void load() async {
    _loading = true;
    _repository.findAll(15, null).then((value) {
      _post = value;
    }).catchError((dynamic error) {
      print(error);
      _errorMessage = error.toString();
    }).whenComplete(() {
      _loading = false;
      notifyListeners();
    });
  }


}
