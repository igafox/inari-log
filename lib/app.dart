import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/app_router.dart';

class MyApp extends HookWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '稲荷ログ',
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: FontFamily.NOTOSANS_REGULAR,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "/post/create",
        onGenerateRoute: AppRouter.router.generator);
  }

}
