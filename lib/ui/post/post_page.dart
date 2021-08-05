import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/responsive.dart';
import 'package:inari_log/ui/post/post_view_model.dart';
import 'package:inari_log/ui/widget/circle_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum Menu {
  MY_PAGE,
  EDIT_PROFILE,
  LOGOUT,
}

class PostPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    print("build");
    final viewModel = useProvider(postViewModelProvider);

    //住所フォーム上書き
    final adressTextController = TextEditingController();
    adressTextController.value = adressTextController.value.copyWith(
      text: viewModel.address,
    );

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
                    padding: EdgeInsets.only(top: 50, left: 16, right: 16),
                    constraints: BoxConstraints(minWidth: 100, maxWidth: 800),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "新しい稲荷を投稿",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: FontFamily.NOTOSANS_BOLD),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Divider(
                            height: 1,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [Icon(Icons.bookmark), Text("名前")],
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "名前を追加",
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [Icon(Icons.place), Text("場所")],
                          ),
                          Row(
                            children: [
                              Flexible(
                                  child: TextField(
                                decoration: InputDecoration(hintText: "住所を追加"),
                                controller: adressTextController,
                                onSubmitted: (text) {
                                  viewModel.changeAddress(text);
                                },
                              )),
                              IconButton(
                                icon: Icon(Icons.my_location),
                                onPressed: () {},
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          // Container(
                          //   height: 300,
                          //   width: double.infinity,
                          //   child: AbsorbPointer(
                          //     absorbing: true,child:GoogleMap(
                          //       gestureRecognizers: {
                          //         Factory<OneSequenceGestureRecognizer>(() => ScaleGestureRecognizer()),
                          //       },
                          //     initialCameraPosition: CameraPosition(
                          //         target: viewModel.location, zoom: 17),
                          //     myLocationButtonEnabled: true,
                          //
                          //     onTap: (latLng) {
                          //       viewModel.changeLocation(latLng);
                          //     },
                          //     markers: viewModel.marker,
                          //   ),
                          // )),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [Icon(Icons.edit), Text("メモ")],
                          ),
                          TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(hintText: "メモを追加"),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Icon(Icons.photo_library),
                              Text("写真(5枚までアップロード可能)"),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),ElevatedButton(
                            child: const Text("フォルダから選択"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              onPrimary: Colors.white,
                            ),
                            onPressed: () async {
                              final fromPicker =
                              await ImagePickerWeb.getMultiImages(
                                  outputType: ImageType.bytes)
                              as List<Uint8List>;
                              print(fromPicker.length.toString());
                              viewModel.addUploadImage(fromPicker);
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              childAspectRatio: Responsive.value(
                                  context: context,
                                  desktop: 4 / 3,
                                  tablet: 4 / 3,
                                  mobile: 4 / 3),
                              crossAxisCount: Responsive.value(
                                      context: context,
                                      desktop: 3,
                                      tablet: 3,
                                      mobile: 2)
                                  .toInt(),
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              shrinkWrap: true,
                              children:
                                  _buildUploadImages(viewModel.imagePaths))
                        ])))));
  }

  List<Widget> _buildUploadImages(List<Uint8List> imagePaths) {
    final images = imagePaths.map((image) => Image.memory(image)).toList();
    return images;
  }
}
