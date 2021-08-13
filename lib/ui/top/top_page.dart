import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/responsive.dart';
import 'package:inari_log/ui/global_menu/global_menu.dart';
import 'package:inari_log/ui/top/top_view_model.dart';
import 'package:inari_log/ui/widget/circle_image.dart';
import 'package:collection/collection.dart';

class TopPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(topViewModelProvider);

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
                                    AppRouter.router.navigateTo(
                                        context, "/post/create",
                                        transition: TransitionType.native);
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
                          children: _buildPostItems(context, viewModel.post))),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    child: SizedBox(
                      height: 40,
                      width: 130,
                      child: TextButton(
                          child: Text(
                            "もっと見る",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          onPressed: () {
                            AppRouter.router.navigateTo(
                              context,
                              "/post",
                              transition: TransitionType.native,
                            );
                          }),
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
                              child: _buildMore(
                                  "稲荷を探しましょう",
                                  "他の人が訪れた神社を新着順や地域毎に探すことができます。",
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

  List<Widget> _buildPostItems(BuildContext context, List<Post> list) {
    return list.map((item) {
      print(item.id);
      return Card(
        child: InkWell(
          onTap: () {
            AppRouter.router.navigateTo(context, "/post/" + item.id,
                transition: TransitionType.native);
          },
          child: Column(
            children: [
              Expanded(
                  child: CachedNetworkImage(
                imageUrl: item.imageUrls.firstOrNull ?? "",
                fit: BoxFit.cover,
              )),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(children: [
                  CircleImage(size: 45, image: AssetImage("images/icon.png")),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(item.userName,
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: FontFamily.NOTOSANS_BOLD)),
                      Text(
                        item.name,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: FontFamily.NOTOSANS_REGULAR),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(item.address,
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
    }).toList();
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
