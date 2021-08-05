import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mainViewModelProvider =
    ChangeNotifierProvider((ref) => MainViewModel(ref.read));

enum PageType {
  Top,
}

class MainViewModel extends ChangeNotifier {
  MainViewModel(this._reader);

  final Reader _reader;

  // late final AuthRepository _repository = _reader(authRepositoryProvider);

  PageType _currentPageType = PageType.Top;
  PageType get currentPageType => _currentPageType;

  bool _loading = false;
  bool get loading => _loading;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  void changeBodyPage(PageType pageType) {
    _currentPageType = pageType;
    notifyListeners();
  }

}