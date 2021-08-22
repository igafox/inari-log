import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:ui' as ui;

import 'app.dart';

void main() async {
  AppRouter.setup();
  setUrlStrategy(PathUrlStrategy());

  // // ignore: undefined_prefixed_name
  // ui.platformViewRegistry.registerViewFactory(
  //     'googlemap',
  //         (int viewId) => IFrameElement()
  //       ..width = '640'
  //       ..height = '360'
  //       ..src = 'https://www.google.com/maps/embed/v1/place?key=AIzaSyDwh06g-fRW_9uQb99WGP_bUSYpfZTgJN0&q=%E5%A4%A7%E5%9C%8B%E9%AD%82%E7%A5%9E%E7%A4%BE%22'
  //       ..style.border = 'none');

  initializeDateFormatting("ja-JP",null);


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
