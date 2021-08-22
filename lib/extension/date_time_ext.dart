import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime {

  //yyyy/MM/dd HH:mm'
  String format(String text) {
    var formatter = new DateFormat(text, "ja_JP");
    var formatted = formatter.format(this); // DateからString
    return formatted;
  }

}