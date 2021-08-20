import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/model/user.dart' as Model;
import 'package:inari_log/provider/firebase_provider.dart';
import 'package:inari_log/repository/post_repository.dart';

final postRepositoryProvider = Provider((ref) => PostRepositoryImp(ref.read));

class PostRepositoryImp implements PostRepository {
  PostRepositoryImp(this._reader);

  final Reader _reader;

  late final FirebaseFirestore _firestore = _reader(firebaseFirestoreProvider);
  late final FirebaseAuth _firebaseAuth = _reader(firebaseAuthProvider);

  late final postCollection = _firestore.collection("post");
  late final userCollection = _firestore.collection("user");

  @override
  Future<List<Post>> findAll(int limit, String? startAfterId) async {
    final QuerySnapshot<Map<String, dynamic>> result;
    if (startAfterId != null) {
      final doc = await postCollection.doc(startAfterId).get();
      result = await postCollection
          .limit(limit)
          .orderBy("createdAt", descending: true)
          .startAfterDocument(doc)
          .get();
    } else {
      result = await postCollection
          .limit(limit)
          .orderBy("createdAt", descending: true)
          .get();
    }

    final post = result.docs.map((e) => Post.from(e.data())).toList();
    return post;
  }

  @override
  Future<Post> findById(String id) async {
    final result = await postCollection.doc(id).get();
    final post = Post.from(result.data()!);
    return post;
  }

  @override
  Future<List<Post>> findByUserId(String userId, int limit, String? startAfterId) async {
    final QuerySnapshot<Map<String, dynamic>> result;
    if (startAfterId != null) {
      final doc = await postCollection.doc(startAfterId).get();
      result = await postCollection
          .limit(limit)
          .where("userId", isEqualTo: userId)
          .orderBy("createdAt", descending: true)
          .startAfterDocument(doc)
          .get();
    } else {
      result = await postCollection
          .limit(limit)
          .where("userId", isEqualTo: userId)
          .orderBy("createdAt", descending: true)
          .get();
    }

    final post = result.docs.map((e) => Post.from(e.data())).toList();
    return post;
  }

  @override
  Future<bool> create(Post post) async {
    // final uid = _firebaseAuth.currentUser?.uid ?? "iga_fox";
    // if(uid == null) return false;

    print("create data");

    try {
      //uid取得
      final currentUser = _firebaseAuth.currentUser;
      final uid = currentUser?.uid ?? "";
      final displayName = currentUser?.displayName ?? "";

      // //ユーザーデータ取得
      // final userResult = await userCollection.doc(uid).get();
      // if (userResult.data() == null) return false;
      // final user = Model.User.from(userResult.data()!);
      post = post.copyWith(userId: uid, userName: displayName);

      print(post);

      //idが未設定の場合、生成する
      if (post.id.isEmpty) {
        post = post.copyWith(id: userCollection.doc().id);
      }

      final data = {
        "id": post.id,
        "name": post.name,
        "memos": post.memos,
        "address": post.address,
        "userId": post.userId,
        "userName": post.userName,
        "userIcon": post.userIcon,
        "createdAt": FieldValue.serverTimestamp()
      };

      await postCollection.doc(post.id).set(data);
      print("create done");
      return true;
    } catch (e) {
      print("create failed");
      print(e);
      return false;
    }
  }

  @override
  Future<String> generateId() async {
    return postCollection.doc().id;
  }

}
