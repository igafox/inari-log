import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';

import 'app.dart';

void main() {
  AppRouter.setup();
  setUrlStrategy(PathUrlStrategy());

  runApp(ProviderScope(child: MyApp()));
}
