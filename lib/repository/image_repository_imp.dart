import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_compression/image_compression.dart';
import 'package:inari_log/extension/image_util.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/model/user.dart' as Model;
import 'package:inari_log/provider/firebase_provider.dart';
import 'package:inari_log/repository/image_repository.dart';
import 'package:inari_log/repository/post_repository.dart';
import 'package:inari_log/util/RandomString.dart';

final imageRepositoryProvider = Provider((ref) => ImageRepositoryImp(ref.read));

class ImageRepositoryImp implements ImageRepository {
  ImageRepositoryImp(this._reader);

  final Reader _reader;
  
  late final FirebaseAuth _firebaseAuth = _reader(firebaseAuthProvider);
  late final FirebaseStorage _firebaseStorage = _reader(firebaseStorageProvider);

  Future<Uint8List> compressImage(Uint8List image) async {

    var start = DateTime.now().millisecondsSinceEpoch;
    print("start compress");
    var inputImage = ImageFile(rawBytes: image, filePath: '');
    var result = await compressInQueue(ImageFileConfiguration(input:inputImage));
    //
    // var result = await FlutterImageCompress.compressWithList(
    //     image,minHeight: 1920,minWidth: 1080,quality: 96);

    var end = DateTime.now().millisecondsSinceEpoch;

    print("original:" + image.length.toString());
    print("compressed:" + result.rawBytes.length.toString());
    print("time:" + (end - start).toString());
    return result.rawBytes;
  }

  @override
  Future<String> uploadImage(String postId, Uint8List image) async{
    print("upload start");
    var start = DateTime.now().millisecondsSinceEpoch;

    final uid = _firebaseAuth.currentUser!.uid;
    final extension = ImageUtil.getExtension(image);
    final fileName = RandomString.generate(15) + extension;
    final imageRef = _firebaseStorage.ref("images/post/$uid/$postId/").child(fileName);

    final contentType = ImageUtil.getContentType(image);
    final result = await imageRef.putData(image,SettableMetadata(contentType: contentType));
    final imageUrl = await result.ref.getDownloadURL();

    var end = DateTime.now().millisecondsSinceEpoch;
    print("upload done");
    print("time:" + (end - start).toString());

    return imageUrl;
  }

  @override
  Future<List<String>> uploadImages(String postId, List<Uint8List> images) async {

    final tasks = images.map((image) =>uploadImage(postId, image));
    final imageUrl = Future.wait(tasks);

    return imageUrl;
  }


}
