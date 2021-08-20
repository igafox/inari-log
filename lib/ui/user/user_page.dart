import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/responsive.dart';
import 'package:inari_log/ui/global_menu/global_menu.dart';
import 'package:inari_log/ui/user/user_view_model.dart';
import 'package:inari_log/ui/widget/circle_image.dart';

enum Menu {
  MY_PAGE,
  EDIT_PROFILE,
  LOGOUT,
}

class UserPage extends HookWidget {
  UserPage({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(userViewModelProvider);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: GlobalMenu(),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.orangeAccent,
            label: Text(
              '新規投稿',
              style: TextStyle(
                  fontFamily: FontFamily.NOTOSANS_BOLD, color: Colors.white),
            ),
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              AppRouter.router.navigateTo(context, "/post/create",
                  transition: TransitionType.native);
            }),
        body: Container(
          alignment: Alignment.topCenter,
          child: Container(
              margin: EdgeInsets.only(top: 30, right: 30, left: 30, bottom: 24),
              constraints: BoxConstraints(minWidth: 100, maxWidth: 800),
              child: Column(children: [
                Card(
                  child: Container(
                    height: 180,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleImage(
                                size: 45,
                                image: AssetImage("images/icon.png")),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "iga",
                              style: TextStyle(
                                fontFamily: FontFamily.NOTOSANS_BOLD,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                            "福ノ島会津出身のお狐 狐面/着物/写真/ドライブ/📷NikonZ6,SIGMAfp/🚗86/📦https://t.co/juwFaNIWQN",
                            style: TextStyle(
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Align(
                  child: Text(
                    "投稿一覧",
                    style: TextStyle(
                        fontSize: 20, fontFamily: FontFamily.NOTOSANS_BOLD),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: GridView.count(
                        childAspectRatio: Responsive.value(
                            context: context,
                            desktop: 1 / 1,
                            tablet: 1 / 1,
                            mobile: 1 / 1),
                        crossAxisCount: Responsive.value(
                                context: context,
                                desktop: 3,
                                tablet: 3,
                                mobile: 1)
                            .toInt(),
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        children: [
                    ]))
              ])),
        ));
  }

  Widget _createItem(
      BuildContext context, String name, String address, String imageName) {
    return Card(
      child: InkWell(
        onTap: () {
          AppRouter.router.navigateTo(context, "/post/1",
              transition: TransitionType.native);
        },
        child: Column(
          children: [
            Expanded(
                child: Image.asset(
              imageName,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            )),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(children: [
                CircleImage(
                    size: 45, image: AssetImage("images/icon.png")),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text("iga",
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: FontFamily.NOTOSANS_BOLD)),
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: FontFamily.NOTOSANS_REGULAR),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(address,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: FontFamily.NOTOSANS_REGULAR))
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
