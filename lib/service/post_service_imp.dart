import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/repository/post_repository.dart';
import 'package:inari_log/repository/post_repository_imp.dart';
import 'package:inari_log/service/post_service.dart';

// final postServiceProvider = Provider((ref) => PostServiceImp(ref.read));

// class PostServiceImp implements PostService {
//   PostServiceImp(this._reader);
//
//   final Reader _reader;
//
//   late final PostRepository _postRepository = _reader(postRepositoryProvider);
//
//   // @override
//   // Future<bool> create(Post post) {
//   //
//   // }
//
//
//
//
// }
