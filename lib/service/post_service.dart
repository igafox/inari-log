import 'package:inari_log/model/post.dart';

abstract class PostService {

  Future<bool> create(Post post);

}