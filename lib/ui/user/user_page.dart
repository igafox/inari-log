import 'package:collection/src/iterable_extensions.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/responsive.dart';
import 'package:inari_log/ui/global_menu/global_menu.dart';
import 'package:inari_log/ui/user/user_view_model.dart';
import 'package:inari_log/ui/widget/circle_image.dart';

class UserPage extends HookWidget {
  UserPage({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(userViewModelProvider(userId));

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
              AppRouter.router.navigateTo(
                context,
                "/post/create",
              );
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
                                image: NetworkImage(
                                    viewModel.user?.iconUrl ?? "")),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              viewModel.user?.name ?? "",
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
                        Text("紹介文",
                            style: TextStyle(
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                if (viewModel.posts.isNotEmpty)
                  Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                          ),
                          itemCount: viewModel.posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == viewModel.posts.length - 1 &&
                                viewModel.hasNext) {
                              viewModel.loadNext();
                            }
                            return _buildPost(context, viewModel.posts[index]);
                          })),
                if (viewModel.posts.isEmpty)
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text("投稿がありません")
                    ],
                  )
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
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      post.name,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(overflow: TextOverflow.ellipsis),
                    ),
                    Text(post.address,
                        style: Theme.of(context).textTheme.caption)
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
