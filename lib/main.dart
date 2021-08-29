import 'dart:html';

import 'package:firebase_remote_config/firebase_remote_config.dart';
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

  initializeDateFormatting("ja-JP",null);

  runApp(ProviderScope(child: MyApp(false)));
}