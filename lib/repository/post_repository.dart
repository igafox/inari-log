

import 'package:inari_log/model/post.dart';

abstract class PostRepository {

  Future<List<Post>> findAll(int limit,String? startAfterId);

  Future<Post> findById(String id);

  Future<bool> create(Post post);

  Future<String> generateId();

}
