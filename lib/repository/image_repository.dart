import 'dart:typed_data';

abstract class ImageRepository {

  Future<List<String>> uploadImages(String postId,List<Uint8List> images);

  Future<String> uploadImage(String postId,Uint8List image);

}
