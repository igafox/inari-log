import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/ui/detail/detail_page.dart';
import 'package:inari_log/ui/post/post_page.dart';

import 'ui/top/top_page.dart';

class MyApp extends HookWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'おいなりログ',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: FontFamily.NOTOSANS_REGULAR,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/':(_) => new TopPage(),
        '/post':(_) => new DetailPage(),
        '/post/create':(_) => new PostPage()
      },
    );
  }
}