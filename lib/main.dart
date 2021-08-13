import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';

import 'app.dart';

void main() async {
  AppRouter.setup();
  setUrlStrategy(PathUrlStrategy());

  // const isEmulator = bool.fromEnvironment('IS_EMULATOR');
  //
  // if (isEmulator) {
  //   const localhost = 'localhost';
  //   FirebaseFirestore.instance.useFirestoreEmulator(localhost, 8080);
  //   FirebaseAuth.instance.useAuthEmulator(localhost, 9099);
  //   FirebaseStorage.instance.useEmulator(host: localhost, port: 9199);
  // }

  // if (FirebaseAuth.instance.currentUser == null) {
  //   // 2秒過ぎるかcurrentUserが復帰してきたらレンダリング開始
  //   await Future.any([
  //     FirebaseAuth.instance.userChanges().firstWhere((u) => u != null),
  //     Future.delayed(Duration(milliseconds: 1000)),
  //   ]);
  // }

  runApp(ProviderScope(child: MyApp()));
}
