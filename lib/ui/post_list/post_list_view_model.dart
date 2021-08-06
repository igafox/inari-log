import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postListViewModelProvider =
    ChangeNotifierProvider((ref) => PostListViewModel(ref.read));

class PostListViewModel extends ChangeNotifier {
  PostListViewModel(this._reader);

  final Reader _reader;

  // late final AuthRepository _repository = _reader(authRepositoryProvider);

  bool _loading = false;
  bool get loading => _loading;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  bool _isVisibleFab = false;
  bool get isVisibleFab => _isVisibleFab;

  void setVisibleFab(bool visible) {
    _isVisibleFab = visible;
    notifyListeners();
  }

}