import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/responsive.dart';
import 'package:inari_log/ui/top/top_view_model.dart';
import 'package:inari_log/ui/widget/circle_image.dart';

enum Menu {
  MY_PAGE,
  EDIT_PROFILE,
  LOGOUT,
}

class DetailPage extends HookWidget {
  DetailPage({required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(topViewModelProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          title: Text('おいなりログ'),
          actions: [
            TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.only(left: 15, right: 15))),
                child: Text(
                  '神社一覧',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                )),
            PopupMenuButton<Menu>(
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
                assetImage: AssetImage("images/icon.png"),
                size: 42,
              ),
              iconSize: 42,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              child: Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(children: [
                        CircleImage(
                            size: 40,
                            assetImage: AssetImage("images/icon.png")),
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
                              "装束稲荷神社",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: FontFamily.NOTOSANS_REGULAR),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text("東京都北区",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: FontFamily.NOTOSANS_REGULAR))
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ]),
                    ),
                    Container(
                        height: Responsive.value(
                                context: context,
                                desktop: 390,
                                tablet: 390,
                                mobile: 250)
                            .toDouble(),
                        child: Stack(
                          children: [
                            Image.asset(
                              "images/syouzoku.jpg",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 40),
                              child: Align(
                                alignment: Alignment.centerLeft,
                              ),
                            )
                          ],
                        )),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "メモ",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: FontFamily.NOTOSANS_BOLD),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                              child: Container(
                            padding: EdgeInsets.all(12),
                            height: 250,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: Text("毎年大晦日の夜に行われる「王子狐の行列」の出発地点となる稲荷神社")),
                                Text("2021/08/05 14:67")
                              ],
                            ),
                          )),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))),
    );
  }

  Widget _createItem(
      BuildContext context, String name, String address, String imageName) {
    return Card(
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
              CircleImage(size: 45, assetImage: AssetImage("images/icon.png")),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text("iga",
                      style: TextStyle(
                          fontSize: 13, fontFamily: FontFamily.NOTOSANS_BOLD)),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 15, fontFamily: FontFamily.NOTOSANS_REGULAR),
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
    );
  }

  Widget _buildMore(String title, String message, String imageName) {
    return Column(
      children: [
        Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                imageName,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: FontFamily.NOTOSANS_BOLD, fontSize: 18),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(message),
              ],
            ),
          ),
        ),
      ],
      mainAxisSize: MainAxisSize.min,
    );
  }
}
