import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/responsive.dart';
import 'package:inari_log/ui/global_menu/global_menu.dart';
import 'package:inari_log/ui/post_list/post_list_view_model.dart';
import 'package:inari_log/ui/widget/circle_image.dart';
import 'package:collection/collection.dart';

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
              AppRouter.router
                  .navigateTo(
                    context,
                    "/post/create",
                  )
                  .then((value) => viewModel.load());
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
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                        ),
                        itemCount: viewModel.post.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildPost(context, viewModel.post[index]);
                        }))
              ])),
        ));
  }

  Widget _buildPost(BuildContext context, Post post) {
    return Card(
      child: InkWell(
        onTap: () {
          AppRouter.router.navigateTo(
            context,
            "/post/" + post.id,
          );
        },
        child: Column(
          children: [
            Expanded(
                child: Image.network(
              post.memos.firstOrNull?.imageUrl ?? "",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            )),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(children: [
                CircleImage(size: 45, image: NetworkImage(post.userIconUrl)),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(post.userName,
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: FontFamily.NOTOSANS_BOLD)),
                    Text(
                      post.name,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: FontFamily.NOTOSANS_REGULAR),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(post.address,
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
