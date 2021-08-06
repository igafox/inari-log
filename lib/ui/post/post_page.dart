import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/responsive.dart';
import 'package:inari_log/ui/global_menu/global_menu.dart';
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
    final viewModel = useProvider(postViewModelProvider);

    //住所フォーム上書き
    final adressTextController = TextEditingController();
    adressTextController.value = adressTextController.value.copyWith(
      text: viewModel.address,
    );

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: GlobalMenu()),
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
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Icon(Icons.bookmark),
                              SizedBox(
                                width: 5,
                              ),
                              Text("名前")
                            ],
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
                            children: [
                              Icon(Icons.place),
                              SizedBox(
                                width: 5,
                              ),
                              Text("場所")
                            ],
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
                            children: [
                              Icon(Icons.edit),
                              SizedBox(
                                width: 5,
                              ),
                              Text("メモ")
                            ],
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 200),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(hintText: "メモを追加"),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.photo_library),
                              SizedBox(
                                width: 10,
                              ),
                              // Text(
                              //     "画像\n画像形式:JPEG/PNG\n推奨サイズ:4x3\nファイルサイズ5MB,5枚まで投稿可能"),
                              Text("画像"),
                              SizedBox(width: 10,),
                              SizedBox(
                                height: 28,
                                width: 160,
                                child: ElevatedButton.icon(
                                  icon: Icon(Icons.upload_rounded),
                                  label: Text("ファイルを選択"),
                                  style: ElevatedButton.styleFrom(),
                                  onPressed: () async {
                                    final fromPicker =
                                    await ImagePickerWeb.getMultiImages(
                                        outputType: ImageType.bytes)
                                    as List<Uint8List>;
                                    print(fromPicker.length.toString());
                                    viewModel.addUploadImage(fromPicker);
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text("画像形式:JPEG,PNG\n推奨サイズ:4x3\nファイルサイズ:5枚まで可能"),
                          SizedBox(height: 20),
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
                                  _buildUploadImages(viewModel.imagePaths)),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: 100,
                            height: 35,
                            child: ElevatedButton(
                              child: const Text("投稿"),
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
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ])))));
  }

  List<Widget> _buildUploadImages(List<Uint8List> imagePaths) {
    if (imagePaths.isEmpty) {
      final empty = Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Icon(Icons.photo, size: 40),
      );
      return [empty];
    }

    final images = imagePaths.map((image) => Image.memory(image)).toList();
    return images;
  }
}
