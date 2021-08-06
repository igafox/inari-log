import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/provider/firebase_provider.dart';
import 'package:inari_log/repository/post_repository.dart';

final postRepositoryProvider = Provider((ref) => PostRepositoryImp(ref.read));

class PostRepositoryImp implements PostRepository {
  PostRepositoryImp(this._reader);

  final Reader _reader;

  late final FirebaseFirestore _firestore = _reader(firebaseFirestoreProvider);

  late final postCollection = _firestore.collection("post");

  @override
  Future<List<Post>> findAll(int limit, String? startAfterId) async {
    final QuerySnapshot<Map<String, dynamic>> result;
    if (startAfterId != null) {
      final doc = await postCollection.doc(startAfterId).get();
      result = await postCollection
          .limit(limit)
          .orderBy("createdDate", descending: true)
          .startAfterDocument(doc)
          .get();
    } else {
      result = await postCollection
          .limit(limit)
          .orderBy("createdDate", descending: true)
          .get();
    }

    final post = result.docs.map((e) => Post.from(e.data())).toList();
    return post;
  }

// @override
// Future<List<Post>> findAll(int limit) async {
//     final result = await postCollection.limit(limit).get();
//     final posts = result.docs.map((e) => Post.from(e.data())).toList();
//     return posts;
// }

// @override
// Future<void> create(Vote vote) {
//   // var id = voteCollection.doc().id;
//   // var tempVote = vote.copyWith(id: id);
//   // return voteCollection.doc(id).set(data)
//
//   return voteCollection.doc(vote.id).set({});
//
// }
//
// @override
// Future<void> delete(String id) async {
//   return voteCollection.doc(id).delete();
// }
//
// @override
// Future<Vote> select(String id) async {
//   final result = await voteCollection.doc(id).get();
//   final vote = Vote.from(result.data() as Map);
//   return vote;
// }
//
// @override
// Future<List<Vote>> selectAll() async {
//   final result = await voteCollection.get();
//   final votes = result.docs.map((e) => Vote.from(e.data())).toList();
//   return votes;
// }
//
// @override
// Future<void> update(Vote vote) {
//   return voteCollection.doc("id").set({
//     'title': vote.title,
//     'open': vote.open,
//   });
// }

}
