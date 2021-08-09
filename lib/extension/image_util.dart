
import 'dart:typed_data';
import 'package:collection/collection.dart';

class ImageUtil {


  static String getExtension(Uint8List data) {

    if(data[0] == 255 && data[1] == 216) {
      return ".jpg";
    }

    if(data[0] == 137 && data[1] == 80 && data[2] == 78 && data[3] == 71) {
      return ".png";
    }

    return "";

  }

  static String getContentType(Uint8List data) {

    if(data[0] == 255 && data[1] == 216) {
      return "image/jpeg";
    }

    if(data[0] == 137 && data[1] == 80 && data[2] == 78 && data[3] == 71) {
      return "image/png";
    }

    return "";

  }

}