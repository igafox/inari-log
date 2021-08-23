import 'package:intl/intl.dart';

extension DateTimeFormat on DateTime {

  //yyyy/MM/dd HH:mm'
  String format(String text) {
    var formatter = new DateFormat(text, "ja_JP");
    var formatted = formatter.format(this); // DateからString
    return formatted;
  }
  
  String elapsedTime() {
    final nowDate = DateTime.now();
    final difference = nowDate.difference(this);

    if (difference.inDays >= 1 || difference.isNegative) {
      return this.format("yyyy/MM/dd");
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} 時間前';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} 分前';
    } else  {
      return '${difference.inSeconds} 秒前';
    }
  }

}