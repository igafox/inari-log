import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/repository/post_repository.dart';
import 'package:inari_log/repository/post_repository_imp.dart';
import 'package:inari_log/repository/user_repository.dart';


final userViewModelProvider =
ChangeNotifierProvider.family<UserViewModel, String>((ref, id) {
  return UserViewModel(ref.read, id);
});

class UserViewModel extends ChangeNotifier {
  UserViewModel(this._reader, this.userId) {
    load();
  }

  final String userId;

  final Reader _reader;

  late final PostRepository _repository = _reader(postRepositoryProvider);

  bool _loading = false;
  bool get loading => _loading;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  void load() async {
    _loading = true;
    _repository.findByUserId(userId, 20, null).then((value) {
      _posts = value;
    }).catchError((dynamic error) {
      print(error);
      _errorMessage = error.toString();
    }).whenComplete(() {
      _loading = false;
      notifyListeners();
    });
  }

  void loadNext(String id) async {
    _loading = true;
    _repository.findByUserId(userId, 20, id).then((value) {
      _posts += value;
    }).catchError((dynamic error) {
      print(error);
      _errorMessage = error.toString();
    }).whenComplete(() {
      _loading = false;
      notifyListeners();
    });
  }

}