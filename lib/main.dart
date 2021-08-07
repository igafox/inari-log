import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';

import 'app.dart';

void main() async {
  AppRouter.setup();
  setUrlStrategy(PathUrlStrategy());

  // if (FirebaseAuth.instance.currentUser == null) {
  //   // 2秒過ぎるかcurrentUserが復帰してきたらレンダリング開始
  //   await Future.any([
  //     FirebaseAuth.instance.userChanges().firstWhere((u) => u != null),
  //     Future.delayed(Duration(milliseconds: 1000)),
  //   ]);
  // }


  runApp(ProviderScope(child: MyApp()));
}
