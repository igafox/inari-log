import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:inari_log/ui/detail/detail_page.dart';
import 'package:inari_log/ui/login/login_page.dart';
import 'package:inari_log/ui/post/post_page.dart';
import 'package:inari_log/ui/post_list/post_list_page.dart';
import 'package:inari_log/ui/top/top_page.dart';
import 'package:inari_log/ui/user/user_page.dart';
import 'package:collection/collection.dart';
import 'package:inari_log/ui/user_create/user_create_page.dart';

class AppRouter {
  static late final FluroRouter router = FluroRouter();

  static var homeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return TopPage();
      });

  static var postCreateHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return PostPage();
      });

  static var postListHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return PostListPage();
      });

  static var postDetailHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        String postId = params["id"]?.firstOrNull ?? "";
        return DetailPage(postId: postId);
      });

  static var userCreateHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return UserCreatePage();
      });

  static var userDetailHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        String userId = params["id"]?.firstOrNull ?? "";
        print(userId);
        return UserPage(userId: userId);
      });

  static var loginHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return LoginPage();
      });

  static void setup() {
    router.notFoundHandler = homeHandler;
    router.define("/", handler: homeHandler);
    router.define("/post", handler: postListHandler);
    router.define("/post/create", handler: postCreateHandler);
    router.define("/post/:id", handler: postDetailHandler);
    router.define("/user/create", handler: userCreateHandler);
    router.define("/user/:id", handler: userDetailHandler);
    router.define("/login", handler:loginHandler);
  }

}