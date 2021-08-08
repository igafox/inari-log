import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/responsive.dart';
import 'package:inari_log/ui/global_menu/global_menu.dart';
import 'package:inari_log/ui/top/top_view_model.dart';
import 'package:inari_log/ui/widget/circle_image.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

import 'detail_view_model.dart';

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
    final viewModel = useProvider(detailViewModelProvider(postId));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: GlobalMenu(),
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
                            size: 40, image: AssetImage("images/icon.png")),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text(viewModel.post?.userName ?? "",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: FontFamily.NOTOSANS_BOLD)),
                            Text(
                              viewModel.post?.name ?? "",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: FontFamily.NOTOSANS_REGULAR),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(viewModel.post?.address ?? "",
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
                            Image.network(
                              viewModel.post?.imageUrls.firstOrNull ?? "",
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
                                Expanded(
                                    child: Text(viewModel.post?.memo ?? "")),
                                Text((DateFormat('yyyy/MM/dd/ HH:mm')).format(viewModel.post!.createdAt ?? DateTime.now()))
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
              CircleImage(size: 45, image: AssetImage("images/icon.png")),
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
