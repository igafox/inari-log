import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/extension/image_util.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/model/user.dart' as Model;
import 'package:inari_log/provider/firebase_provider.dart';
import 'package:inari_log/repository/user_repository.dart';

final userRepositoryProvider = Provider((ref) => UserRepositoryImp(ref.read));

class UserRepositoryImp implements UserRepository {
  UserRepositoryImp(this._reader);

  final Reader _reader;

  late final FirebaseFirestore _firestore = _reader(firebaseFirestoreProvider);
  late final FirebaseAuth _firebaseAuth = _reader(firebaseAuthProvider);
  late final FirebaseStorage _firebaseStorage = _reader(firebaseStorageProvider);

  late final postCollection = _firestore.collection("post");
  late final userCollection = _firestore.collection("user");

  // @override
  // Future<List<Post>> findAll(int limit, String? startAfterId) async {
  //   final QuerySnapshot<Map<String, dynamic>> result;
  //   if (startAfterId != null) {
  //     final doc = await postCollection.doc(startAfterId).get();
  //     result = await postCollection
  //         .limit(limit)
  //         .orderBy("createdAt", descending: false)
  //         .startAfterDocument(doc)
  //         .get();
  //   } else {
  //     result = await postCollection
  //         .limit(limit)
  //         .orderBy("createdAt", descending: false)
  //         .get();
  //   }
  //
  //   final post = result.docs.map((e) => Post.from(e.data())).toList();
  //   return post;
  // }
  //
  // @override
  // Future<Post> findById(String id) async {
  //   final result = await postCollection.doc(id).get();
  //   final post = Post.from(result.data()!);
  //   return post;
  // }
  //
  // @override
  // Future<bool> create(Post post) async {
  //   // final uid = _firebaseAuth.currentUser?.uid ?? "iga_fox";
  //   // if(uid == null) return false;
  //
  //   //uid取得
  //   final uid = "iga_fox";
  //
  //   //ユーザーデータ取得
  //   final userResult = await userCollection.doc(uid).get();
  //   if (userResult.data() == null) return false;
  //   final user = Model.User.from(userResult.data()!);
  //   post = post.copyWith(userId: user.id!, userName: user.name!);
  //
  //   //idが未設定の場合、生成する
  //   if (post.id.isEmpty) {
  //     post = post.copyWith(id: userCollection.doc().id);
  //   }
  //
  //   final data = {
  //     "id": post.id,
  //     "name": post.name,
  //     "memo": post.memo,
  //     "address": post.address,
  //     "userId": post.userId,
  //     "userName": post.userName,
  //     "userIcon": post.userIcon,
  //     "imageUrls": post.imageUrls,
  //     "createdAt": FieldValue.serverTimestamp()
  //   };
  //
  //   await postCollection.doc(post.id).set(data);
  //
  //   return true;
  // }
  //
  // @override
  // Future<String> generateId() async {
  //   return postCollection.doc().id;
  // }
  //
  // // @override
  // // Future<User?> getCurrentUser() async {
  // //   final uid = _firebaseAuth.currentUser?.uid;
  // //
  // //   if(uid == null) return null;
  // //
  // //   final result = await userCollection.doc(uid).get();
  // //   final data = result.data();
  // //
  // //   if(data == null) return User();
  // //
  // //   final user = User.from(data);
  // //   return user;
  // // }

  @override
  Future<bool> isLogin() async{
    if(_firebaseAuth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Model.User?> getCurrentUser() async{
    final currentUser = await  _firebaseAuth.currentUser;

    if (currentUser == null) return null;
    final result = await userCollection.doc(currentUser.uid).get();
    final data = result.data();

    if (data == null) return null;

    final user = Model.User.from(data);
    return user;
  }

  @override
  Future<bool> create(String email, String password, String userName, Uint8List profileImage) async {
    //ユーザー作成
    print("ユーザー作成開始");
    final result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final user = await _firebaseAuth.currentUser!;
    print(user.toString());
    final uid = user.uid;
    print("ユーザー作成完了");

    //ユーザー名更新
    print("ユーザー名更新開始");
    await user.updateDisplayName(userName);
    print("ユーザー更新完了");

    //プロフィール画像更新
    print("プロフィール画像更新開始");
    final extension = ImageUtil.getExtension(profileImage);
    final fileName = "icon" + extension;
    final imageRef = _firebaseStorage.ref("images/user/$uid/").child(fileName);
    final contentType = ImageUtil.getContentType(profileImage);
    print("プロフィール画像アップロード開始");
    final uploadResult = await imageRef.putData(profileImage,SettableMetadata(contentType: contentType));
    final imageUrl = await uploadResult.ref.getDownloadURL();
    print("プロフィール画像アップロード完了");
    await user.updatePhotoURL(imageUrl);
    print("プロフィール画像更新完了");

    print("ユーザーデータ作成開始開始");
    final userData = {
      "id":user.uid,
      "name":userName,
      "imageUrl":imageUrl
    };
    await userCollection.doc(user.uid).set(userData);
    print("ユーザーデータ作成完了");

    return true;
  }

}
