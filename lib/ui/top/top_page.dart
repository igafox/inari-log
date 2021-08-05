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
              icon: CircleImage(
                assetImage: AssetImage("images/icon.png"),
                size: 42,
              ),
              iconSize: 42,
            ),
          ],

          // actions: [
          //   // PopupMenuButton(itemBuilder: (context) {
          //   //   var list = List<PopupMenuEntry<Object>>();
          //   // })
          // ],
          // actions: [
          //   TextButton(
          //       onPressed: () {},
          //       child: Text(
          //         '新規登録',
          //         style: TextStyle(fontSize: 15, color: Colors.white),
          //       )),
          //   SizedBox(
          //     width: 10,
          //   ),
          //   TextButton(
          //       onPressed: () {},
          //       child: Text(
          //         '投稿一覧',
          //         style: TextStyle(fontSize: 15, color: Colors.white),
          //       )),
          //   SizedBox(
          //     width: 10,
          //   ),
          //   TextButton(
          //       onPressed: () {},
          //       child: Text(
          //         'iga',
          //         style: TextStyle(fontSize: 15, color: Colors.white),
          //       ))
          // ],
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
          onPressed: () => {}),
      body: SingleChildScrollView(
          child: Container(
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
                    Container(
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
                              style:
                                  TextStyle(fontSize: 20.0, letterSpacing: 1.0),
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
                                onPressed: () {},
                              ),
                            )
                          ],
                          mainAxisSize: MainAxisSize.min,
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
                  GridView.count(
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
                        _createItem(context, "王子稲荷神社","東京都北区","images/ouji.jpg"),
                        _createItem(context, "装束稲荷神社", "東京都北区","images/syouzoku.jpg"),
                        _createItem(context, "高屋敷稲荷神社","福島県郡山市","images/takayasiki.jpg"),
                      ]),
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
                      "おすすめ",
                      style: TextStyle(
                          fontSize: 27, fontFamily: FontFamily.NOTOSANS_BOLD),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GridView.count(
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
                        _createItem(context, "殺生石稲荷神社","福島県大沼郡会津美里町","images/sessyouseki.jpg"),
                        _createItem(context, "道の駅天栄の近くにある稲荷神社", "福島県岩瀬郡天栄村","images/tenei.jpg"),
                        _createItem(context, "萬蔵稲荷神社","宮城県白石市","images/manzou.jpg"),
                      ]),
                  SizedBox(
                    height: 50,
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
                  GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: Responsive.value(
                          context: context,
                          desktop: 1 / 0.8,
                          tablet: 1 / 0.6,
                          mobile: 1 / 0.7),
                      crossAxisCount: Responsive.value(
                              context: context,
                              desktop: 3,
                              tablet: 1,
                              mobile: 1)
                          .toInt(),
                      mainAxisSpacing: 15,
                      shrinkWrap: true,
                      children: [
                        Container(
                            child: _buildMore("気になる稲荷を見つけよう", "地域やキーワードから探せます。",
                                "images/torii.jpg")),
                        Container(
                            child: _buildMore(
                                "気になる稲荷がすぐわかる",
                                "投稿された神社の画像や説明を見ることができます",
                                "images/komagitune.jpg")),
                        Container(
                            child: _buildMore(
                                "稲荷を登録しよう",
                                "稲荷神社に訪れたら、思い出として登録して、みんなと共有しましょう。マイページでは、投稿履歴を見ることができます。",
                                "images/torii.jpg")),
                      ]),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      )),
    );
  }

  Widget _createItem(BuildContext context, String name, String address,String imageName) {
    return Card(
      child: Column(
        children: [
          Expanded(child:  Image.asset(
            imageName,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          )),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(children: [
              CircleImage(size: 45, assetImage: AssetImage("images/icon.png")),
              SizedBox(width: 10,),
              Column(children: [
                Text("iga",style: TextStyle(
                    fontSize: 13, fontFamily: FontFamily.NOTOSANS_BOLD)),
                Text(name,
                    style: TextStyle(
                        fontSize: 15, fontFamily: FontFamily.NOTOSANS_REGULAR),overflow: TextOverflow.ellipsis,),
                Text(address,
                    style: TextStyle(
                        fontSize: 12, fontFamily: FontFamily.NOTOSANS_REGULAR))
              ],crossAxisAlignment: CrossAxisAlignment.start,),
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
