

import 'package:inari_log/model/post.dart';

abstract class PostRepository {
  // Future<List<Post>> selectAll();
  //
  // Future<Post> select(String id);

  Future<List<Post>> findAll(int limit,String? startAfterId);


  // Future<void> create(Post Post);
  //
  // Future<void> update(Post Post);
  //
  // Future<void> delete(String id);

}
