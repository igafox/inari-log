import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/ui/maintenance/maintenance_page.dart';

class MyApp extends HookWidget {
  final bool isUnderMaintenance;

  MyApp(this.isUnderMaintenance);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (isUnderMaintenance) {
      return MaterialApp(
        title: '稲荷ログ',
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: FontFamily.NOTOSANS_REGULAR,
        ),
        debugShowCheckedModeBanner: false,
        home: MaintenancePage(),
      );
    }

    return MaterialApp(
        title: '稲荷ログ',
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: FontFamily.NOTOSANS_REGULAR,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "user/edit",
        onGenerateRoute: AppRouter.router.generator);
  }
}
