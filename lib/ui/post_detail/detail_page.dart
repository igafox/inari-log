import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/model/post_memo.dart';
import 'package:inari_log/responsive.dart';
import 'package:inari_log/ui/global_menu/global_menu.dart';
import 'package:inari_log/ui/top/top_view_model.dart';
import 'package:inari_log/ui/widget/circle_image.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

import 'detail_view_model.dart';

class DetailPage extends HookWidget {
  DetailPage({required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(detailViewModelProvider(postId));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: GlobalMenu(),
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(top: 16, bottom: 24),
              alignment: Alignment.center,
              child: Card(
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
                            size: 48,
                            image: NetworkImage(
                                viewModel.post?.userIconUrl ?? "")),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(viewModel.post?.userName ?? "",
                                style:Theme.of(context).textTheme.bodyText1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("10分前に投稿",
                                    style: Theme.of(context).textTheme.caption,)
                              ],
                            ),
                            // Text(
                            //   viewModel.post?.name ?? "",
                            //   style: TextStyle(
                            //       fontSize: 15,
                            //       fontFamily: FontFamily.NOTOSANS_REGULAR),
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                            // Text(viewModel.post?.address ?? "",
                            //     style: TextStyle(
                            //         fontSize: 12,
                            //         fontFamily: FontFamily.NOTOSANS_REGULAR))
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                        IconButton(
                          onPressed: () {
                            AppRouter.router.navigateTo(
                                context, "/post/edit/$postId",);
                          },
                          icon: Icon(Icons.edit),
                        )
                      ]),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            itemCount: viewModel.post?.memos.length ?? 0,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return _buildFirstMemo(context, viewModel.post!,
                                    viewModel.post!.memos[index]);
                              } else {
                                return _buildMemo(
                                    context, viewModel.post!.memos[index]);
                              }
                            },
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )))),
    );
  }

  Widget _buildFirstMemo(BuildContext context, Post post, PostMemo memo) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            memo.imageUrl,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.name,
                  style: TextStyle(
                      fontSize: 17, fontFamily: FontFamily.NOTOSANS_BOLD),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      size: 18,
                    ),
                    Text(post.address,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: FontFamily.NOTOSANS_REGULAR)),
                  ],
                ),
                SizedBox(height: 3),
                Row(
                  children: [
                    SizedBox(
                      width: 1,
                    ),
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text("参拝:2018/10/11",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: FontFamily.NOTOSANS_REGULAR))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: Text(memo.text)),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMemo(BuildContext context, PostMemo memo) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            memo.imageUrl,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: Text(memo.text)),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
