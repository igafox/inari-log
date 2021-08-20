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

  @override
  Future<String> generateId() async {
    return postCollection.doc().id;
  }


  @override
  Future<bool> isLogin() async {
    final user = await FirebaseAuth.instance.authStateChanges().first;
    return user != null;
  }

  @override
  Stream<Model.User?> getCurrentUser()  {
    return FirebaseAuth.instance.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      //ユーザーデータ取得
      final result = await userCollection.doc(user.uid).get();
      final data = result.data();

      //Firestoreにデータが存在しない場合は、FirebaseAuthのデータを使用する
      if (data == null) {
        return Model.User(id: user.uid, iconUrl: user.photoURL);
      }

      final userData = Model.User.from(data);

      return userData;
    });

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

  @override
  Future<bool> delete() async {
    await _firebaseAuth.currentUser!.delete();
    return true;
  }

  @override
  Future<bool> logout() async {
    await _firebaseAuth.signOut();
    return true;
  }

}