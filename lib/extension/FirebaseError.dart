
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthUtil {

  static String getDisplayMessage(FirebaseAuthException e) {

    switch(e.code) {

      case 'invalid-email':
        return "メールアドレスの形式が違います";
        break;

      case 'wrong-password':
        return  "パスワードが違います";
        break;

      case 'user-not-found':
        return  "ユーザーが存在しません";
        break;

      case 'user-disabled':
        return  "このアカウントは凍結されています";
        break;

      case 'too-many-requests':
        return "ログイン試行の回数が上限を超えました。しばらく経ってから再度お試しください。";
        break;

      case 'operation-not-allowed':
        return  "許可されていない操作です";
        break;

      case 'email-already-in-use':
        return "メールアドレスが既に使用されています";
        break;

      default:
        return "認証エラーが発生しました。";
        break;

    }

  }

}