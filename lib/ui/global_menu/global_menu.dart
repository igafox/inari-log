import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/ui/global_menu/global_menu_view_model.dart';
import 'package:inari_log/ui/widget/circle_image.dart';

enum Menu {
  MY_PAGE,
  EDIT_PROFILE,
  LOGOUT,
}

class GlobalMenu extends HookWidget {
  final viewModel = useProvider(globalMenuViewModelProvider);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text('おいなりログ'),
      actions: [
        TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.only(left: 15, right: 15))),
            child: Text(
              '神社一覧',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            onPressed: () {
              AppRouter.router.navigateTo(context, "/post",
                  transition: TransitionType.native);
            }),
        Visibility(
          visible: viewModel.isLogin,
          child: PopupMenuButton<Menu>(
            itemBuilder: (context) {
              var list = <PopupMenuEntry<Menu>>[
                PopupMenuItem(
                  child: Text("マイページ"),
                  value: Menu.MY_PAGE,
                ),
                PopupMenuItem(
                  child: Text("プロフィール編集"),
                  value: Menu.EDIT_PROFILE,
                ),
                PopupMenuItem(
                  child: Text("ログアウト"),
                  value: Menu.LOGOUT,
                )
              ];
              return list;
            },
            icon: const CircleImage(
              image: AssetImage("images/icon.png"),
              size: 42,
            ),
            iconSize: 42,
          ),
        ),
        Visibility(
            visible: !viewModel.isLogin,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                child: const Text("ログイン"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  AppRouter.router.navigateTo(context, "/login",
                      transition: TransitionType.native);
                },
              ),
            )),
      ],
    );
  }
}
