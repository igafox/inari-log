import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/model/user.dart';
import 'package:inari_log/repository/post_repository.dart';
import 'package:inari_log/repository/post_repository_imp.dart';
import 'package:inari_log/repository/user_repository.dart';
import 'package:inari_log/repository/user_repository_imp.dart';

final userViewModelProvider =
    ChangeNotifierProvider.family<UserViewModel, String>((ref, id) {
  return UserViewModel(ref.read, id);
});

class UserViewModel extends ChangeNotifier {
  UserViewModel(this._reader, this.userId) {
    load();
  }

  static const PAGING_SIZE = 10;

  final String userId;

  final Reader _reader;

  late final PostRepository _repository = _reader(postRepositoryProvider);

  late final UserRepository _userRepository = _reader(userRepositoryProvider);

  bool _loading = false;

  bool get loading => _loading;

  bool _hasNext = true;

  bool get hasNext => _hasNext;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  User? _user;

  User? get user => _user;

  List<Post> _posts = [];

  List<Post> get posts => _posts;

  void load() async {
    _loading = true;
    try {
      final result = await Future.wait([
        _repository.findByUserId(userId, PAGING_SIZE, null),
        _userRepository.getUser(userId)
      ]);

      _posts = result[0] as List<Post>;
      _user = result[1] as User;

    } catch (e) {
      print(e);
      _loading = false;
    } finally {
      notifyListeners();
    }
  }

  void loadNext() async {
    print("load next");
    _loading = true;

    final lastPostId = posts.lastOrNull?.id;
    if(lastPostId == null) return;

    try {
      final result = await _repository.findByUserId(userId, PAGING_SIZE, lastPostId);
      _posts += result;

      if(result.length < PAGING_SIZE) {
        _hasNext = false;
      }
    } catch(e) {
      print(e);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

}
