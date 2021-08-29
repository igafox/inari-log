import 'dart:typed_data';

abstract class PostImageSource {

  String text;

  PostImageSource(this.text);

  bool hasImage();

}

class UrlImageSource extends PostImageSource {

  final String url;

  UrlImageSource(this.url,String text) : super(text);

  @override
  bool hasImage() {
    return url.isNotEmpty;
  }

}

class ByteImageSource extends PostImageSource {

  final Uint8List data;

  ByteImageSource(this.data, String text) : super(text);

  @override
  bool hasImage() {
    return data.isNotEmpty;
  }

}