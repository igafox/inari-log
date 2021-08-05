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

class TopPage extends HookWidget {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: Responsive.value(
                        context: context,
                        desktop: 390,
                        tablet: 390,
                        mobile: 210)
                    .toDouble(),
                child: Stack(
                  children: [
                    Image.asset(
                      "images/torii.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Align(
                      child: Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 1300),
                        padding: EdgeInsets.only(left: 40),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "稲荷を見つけよう",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  letterSpacing: 1.0,
                                  fontFamily: FontFamily.NOTOSANS_BOLD,
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Text(
                                "あなたの好きな稲荷神社は？",
                                style: TextStyle(
                                    fontSize: 20.0, letterSpacing: 1.0),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 130,
                                height: 40,
                                child: ElevatedButton(
                                  child: const Text("神社を投稿する"),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.orange,
                                    onPrimary: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "/post/create");
                                  },
                                ),
                              )
                            ],
                            mainAxisSize: MainAxisSize.min,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Container(
              margin: EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 24),
              constraints: BoxConstraints(minWidth: 100, maxWidth: 1300),
              child: Column(
                children: [
                  Align(
                    child: Text(
                      "新着",
                      style: TextStyle(
                          fontSize: 27, fontFamily: FontFamily.NOTOSANS_BOLD),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
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
                          shrinkWrap: true,
                          children: [
                        _createItem(
                            context, "王子稲荷神社", "東京都北区", "images/ouji.jpg"),
                        _createItem(
                            context, "装束稲荷神社", "東京都北区", "images/syouzoku.jpg"),
                        _createItem(context, "高屋敷稲荷神社", "福島県郡山市",
                            "images/takayasiki.jpg"),
                      ])),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    child: Text(
                      "もっとみる",
                      style: TextStyle(fontSize: 15),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    child: Text(
                      "おいなりログとは",
                      style: TextStyle(
                          fontSize: 27, fontFamily: FontFamily.NOTOSANS_BOLD),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: Responsive.value(
                            context: context,
                            desktop: 1 / 0.9,
                            tablet: 1 / 0.6,
                            mobile: 1 / 0.7),
                        crossAxisCount: Responsive.value(
                                context: context,
                                desktop: 3,
                                tablet: 1,
                                mobile: 1)
                            .toInt(),
                        mainAxisSpacing: 15,
                        children: [
                          Container(
                              child: _buildMore(
                                  "稲荷神社に特化",
                                  "稲荷神社に特化した神社投稿サービスです。",
                                  "images/komagitune.jpg")),
                          Container(
                              child: _buildMore("あたらしい稲荷神社を探せる", "他の人が訪れた神社を知ることができます。",
                                  "images/torii2.jpg")),
                          Container(
                              child: _buildMore(
                                  "共有しましょう",
                                  "神社に訪れたら、思い出として登録して、みんなと共有しましょう。",
                                  "images/gosyuin.jpg")),
                        ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _createItem(
      BuildContext context, String name, String address, String imageName) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/post");
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

  Widget _buildMore(String title, String message, String imageName) {
    return Column(
      children: [
        Expanded(
            flex: 2,
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
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: FontFamily.NOTOSANS_BOLD, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
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
