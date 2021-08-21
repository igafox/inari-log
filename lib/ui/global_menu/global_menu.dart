import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/provider/user_provider.dart';
import 'package:inari_log/ui/global_menu/global_menu_view_model.dart';
import 'package:inari_log/ui/widget/circle_image.dart';

enum Menu {
  MY_PAGE,
  EDIT_PROFILE,
  LOGOUT,
}

class GlobalMenu extends HookWidget {
  final user = useProvider(userProvider);
  final viewModel = useProvider(globalMenuViewModelProvider);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: const Text('稲荷ログ'),
      actions: [
        TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.only(left: 15, right: 15))),
            child:const Text(
              '神社一覧',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            onPressed: () {
              AppRouter.router.navigateTo(context, "/post");
            }),
        Visibility(
          visible: user.data?.value?.id?.isNotEmpty ?? false,
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
            icon: CircleImage(
              image: NetworkImage(user.data?.value?.iconUrl ?? ""),
              size: 42,
            ),
            iconSize: 42,
            onSelected: (value) {
              switch (value) {
                case Menu.MY_PAGE:
                  AppRouter.router.navigateTo(
                      context, "/user/${user.data?.value?.id}",);
                  break;

                case Menu.EDIT_PROFILE:
                  break;

                case Menu.LOGOUT:
                  viewModel.logout(context);
                  break;
              }
            },
          ),
        ),
        Visibility(
            visible: user.data?.value?.id?.isEmpty ?? true,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                child: const Text("ログイン"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  AppRouter.router.navigateTo(context, "/login",);
                },
              ),
            )),
      ],
    );
  }
}
