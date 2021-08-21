import 'dart:typed_data';

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
import 'package:inari_log/repository/user_repository.dart';
import 'package:inari_log/repository/user_repository_imp.dart';
import 'package:inari_log/ui/global_menu/global_menu_view_model.dart';

final userCreateViewModelProvider =
ChangeNotifierProvider((ref) => UserCreateViewModel(ref.read));

class UserCreateViewModel extends ChangeNotifier {
  UserCreateViewModel(this._reader);

  final Reader _reader;

  // late final AuthRepository _repository = _reader(authRepositoryProvider);

  late final UserRepository _userRepository = _reader(userRepositoryProvider);

  // late final FirebaseAuth _firebaseAuth = _reader(firebaseAuthProvider);
  // late final GlobalMenuViewModel _globalMenuViewModel = _reader(
  //     globalMenuViewModelProvider);

  bool _loading = false;
  bool get loading => _loading;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  Uint8List? _profileImage;
  Uint8List? get profileImage => _profileImage;

  String _userName = "";
  String get userName => _userName;

  String _email = "";
  String get email => _email;

  String _password = "";
  String get password => _password;

  String _confirmPassword = "";
  String get confirmPassword => _confirmPassword;

  void setUserImage(Uint8List image) {
    _profileImage = image;
    notifyListeners();
  }

  void setUserName(String text) {
    _email = text;
  }

  void setEmail(String text) {
    _email = text;
  }

  void setPassword(String text) {
    _password = text;
  }

  void setConfirmPassword(String text) {
    _confirmPassword = text;
  }

  void onClickRegisterButton(BuildContext context) async {
    _loading = true;
    notifyListeners();

    try {
      await _userRepository.create(_email, _password, _userName, _profileImage!);
      AppRouter.router.navigateTo(context, "/");
    } on FirebaseAuthException catch (e) {
      print(e);
      _errorMessage = FirebaseAuthUtil.getDisplayMessage(e);
    } catch (e) {
      print(e);
      _errorMessage = "不明なエラーが発生しました";
    }

    _loading = false;
    notifyListeners();
  }

// void onClickTwiterLoginButton() async {}
//
// void onClickGoogleLoginButton() async {}
//
// void load() async {
//   _loading = true;
//   _repository.findAll(15, null).then((value) {
//     _post = value;
//   }).catchError((dynamic error) {
//     print(error);
//     _errorMessage = error.toString();
//   }).whenComplete(() {
//     _loading = false;
//     notifyListeners();
//   });
// }


}
