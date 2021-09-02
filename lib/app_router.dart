import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:inari_log/ui/login/login_page.dart';
import 'package:inari_log/ui/post_create/post_create_page.dart';
import 'package:inari_log/ui/post_detail/detail_page.dart';
import 'package:inari_log/ui/post_edit/post_edit_page.dart';
import 'package:inari_log/ui/post_list/post_list_page.dart';
import 'package:inari_log/ui/top/top_page.dart';
import 'package:inari_log/ui/user/user_page.dart';
import 'package:collection/collection.dart';
import 'package:inari_log/ui/user_create/user_create_page.dart';
import 'package:inari_log/ui/user_eidt_profile/user_edit_profile_page.dart';

class AppRouter {
  static late final FluroRouter router = FluroRouter();

  static var homeHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return TopPage();
      });

  static var postCreateHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return PostCreatePage();
      });

  static var postListHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return PostListPage();
      });

  static var postEditHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        String postId = params["id"]?.firstOrNull ?? "";
        return PostEditPage(postId: postId);
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

  static var userEditHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return UserEditProfilePage();
      });

  static var loginHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return LoginPage();
      });

  static void setup() {
    router.notFoundHandler = homeHandler;
    router.define("/", handler: homeHandler,transitionType: TransitionType.native);
    router.define("/post", handler: postListHandler,transitionType: TransitionType.native);
    router.define("/post/create", handler: postCreateHandler,transitionType: TransitionType.native);
    router.define("/post/:id", handler: postDetailHandler,transitionType: TransitionType.native);
    router.define("/post/:id/edit", handler: postEditHandler,transitionType: TransitionType.native);
    router.define("/user/create", handler: userCreateHandler,transitionType: TransitionType.native);
    router.define("/user/edit", handler: userEditHandler,transitionType: TransitionType.native);
    router.define("/user/:id", handler: userDetailHandler,transitionType: TransitionType.native);
    router.define("/login", handler:loginHandler,transitionType: TransitionType.native);
  }

}