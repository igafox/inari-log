import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/extension/FirebaseError.dart';
import 'package:inari_log/repository/user_repository.dart';
import 'package:inari_log/repository/user_repository_imp.dart';

final userEditProfileViewModelProvider =
ChangeNotifierProvider((ref) => UserEditProfileViewModel(ref.read));

class UserEditProfileViewModel extends ChangeNotifier {
  UserEditProfileViewModel(this._reader);

  final Reader _reader;

  late final UserRepository _userRepository = _reader(userRepositoryProvider);

  bool _loading = false;
  bool get loading => _loading;

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

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

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
