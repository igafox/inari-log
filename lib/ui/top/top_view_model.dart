import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/repository/post_repository.dart';
import 'package:inari_log/repository/post_repository_imp.dart';

final topViewModelProvider =
    ChangeNotifierProvider((ref) => TopViewModel(ref.read));

class TopViewModel extends ChangeNotifier {
  TopViewModel(this._reader) {
    load();
  }

  final Reader _reader;

  // late final AuthRepository _repository = _reader(authRepositoryProvider);
  late final PostRepository _repository = _reader(postRepositoryProvider);

  bool _loading = false;
  bool get loading => _loading;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  bool _isVisibleFab = false;
  bool get isVisibleFab => _isVisibleFab;

  List<Post> _post = [];
  List<Post> get post => _post;

  void setVisibleFab(bool visible) {
    _isVisibleFab = visible;
    notifyListeners();
  }

  void load() async {
    _loading = true;
    _repository.findAll(3,null).then((value) {
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