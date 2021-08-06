import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/responsive.dart';
import 'package:inari_log/ui/post_list/post_list_view_model.dart';
import 'package:inari_log/ui/top/top_view_model.dart';
import 'package:inari_log/ui/widget/circle_image.dart';

enum Menu {
  MY_PAGE,
  EDIT_PROFILE,
  LOGOUT,
}

class PostListPage extends HookWidget {

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(postListViewModelProvider);

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
                icon: const CircleImage(
                  assetImage: AssetImage("images/icon.png"),
                  size: 42,
                ),
                iconSize: 42,
              ),
            ],
          ),
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
              Navigator.pushNamed(context, "/post/create");
            }),
        body: Container(
          alignment: Alignment.topCenter,
          child: Container(
              margin: EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 24),
              constraints: BoxConstraints(minWidth: 100, maxWidth: 800),
              child: Column(children: [
                Align(
                  child: Text(
                    "投稿一覧",
                    style: TextStyle(
                        fontSize: 27, fontFamily: FontFamily.NOTOSANS_BOLD),
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
                          _createItem(
                              context, "王子稲荷神社", "東京都北区", "images/ouji.jpg"),
                          _createItem(context, "装束稲荷神社", "東京都北区",
                              "images/syouzoku.jpg"),
                          _createItem(context, "高屋敷稲荷神社", "福島県郡山市",
                              "images/takayasiki.jpg"),
                          _createItem(
                              context, "王子稲荷神社", "東京都北区", "images/ouji.jpg"),
                          _createItem(context, "装束稲荷神社", "東京都北区",
                              "images/syouzoku.jpg"),
                          _createItem(context, "高屋敷稲荷神社", "福島県郡山市",
                              "images/takayasiki.jpg"),
                          _createItem(
                              context, "王子稲荷神社", "東京都北区", "images/ouji.jpg"),
                          _createItem(context, "装束稲荷神社", "東京都北区",
                              "images/syouzoku.jpg"),
                          _createItem(context, "高屋敷稲荷神社", "福島県郡山市",
                              "images/takayasiki.jpg"),
                          _createItem(
                              context, "王子稲荷神社", "東京都北区", "images/ouji.jpg"),
                          _createItem(context, "装束稲荷神社", "東京都北区",
                              "images/syouzoku.jpg"),
                          _createItem(context, "高屋敷稲荷神社", "福島県郡山市",
                              "images/takayasiki.jpg"),
                          _createItem(
                              context, "王子稲荷神社", "東京都北区", "images/ouji.jpg"),
                          _createItem(context, "装束稲荷神社", "東京都北区",
                              "images/syouzoku.jpg"),
                          _createItem(context, "高屋敷稲荷神社", "福島県郡山市",
                              "images/takayasiki.jpg"),
                          _createItem(
                              context, "王子稲荷神社", "東京都北区", "images/ouji.jpg"),
                          _createItem(context, "装束稲荷神社", "東京都北区",
                              "images/syouzoku.jpg"),
                          _createItem(context, "高屋敷稲荷神社", "福島県郡山市",
                              "images/takayasiki.jpg")
                        ]))
              ])),
        ));
  }

  Widget _createItem(
      BuildContext context, String name, String address, String imageName) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/post/1");
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
                    size: 45, assetImage: AssetImage("images/icon.png")),
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
