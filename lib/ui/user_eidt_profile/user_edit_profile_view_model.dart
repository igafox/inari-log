import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/extension/FirebaseError.dart';
import 'package:inari_log/model/user.dart';
import 'package:inari_log/repository/user_repository.dart';
import 'package:inari_log/repository/user_repository_imp.dart';

final userEditProfileViewModelProvider =
ChangeNotifierProvider((ref) => UserEditProfileViewModel(ref.read));

class UserEditProfileViewModel extends ChangeNotifier {
  UserEditProfileViewModel(this._reader);

  final Reader _reader;

  late final UserRepository _userRepository = _reader(userRepositoryProvider);

  User? _user;
  User? get user => _user;

  bool _loading = false;
  bool get loading => _loading;

  Uint8List? _profileImage;
  Uint8List? get profileImage => _profileImage;

  String _userName = "";
  String get userName => _userName;

  String _location = "";
  String get location => _location;

  String _comment = "";
  String get comment => _comment;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  void load() async {
    _user = await _userRepository.getCurrentUser().first;
    _userName = _user?.name ?? "";
    _location = _user?.location ?? "";
    _comment = _user?.comment ?? "";

    notifyListeners();
  }

  void setUserImage(Uint8List image) {
    _profileImage = image;
    notifyListeners();
  }

  void setUserName(String text) {
    _userName = text;
  }

  void setLocation(String text) {
    _location = text;
  }

  void setComment(String text) {
    _comment = text;
  }

  void onClickRegisterButton(BuildContext context) async {
    _loading = true;
    notifyListeners();

    try {
      await _userRepository.update(_userName, _location, _comment, _profileImage);
      AppRouter.router.navigateTo(context, "/");
    } on Auth.FirebaseAuthException catch (e) {
      print(e);
      _errorMessage = FirebaseAuthUtil.getDisplayMessage(e);
    } catch (e) {
      print(e);
      _errorMessage = "不明なエラーが発生しました";
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

}
