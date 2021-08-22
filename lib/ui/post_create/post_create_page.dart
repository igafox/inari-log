import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/extension/date_time_ext.dart';
import 'package:inari_log/ui/global_menu/global_menu.dart';
import 'package:inari_log/ui/modal/select_location_modal.dart';
import 'package:inari_log/ui/post_create/post_create_view_model.dart';
import 'package:inari_log/ui/widget/loading_view.dart';
import 'package:inari_log/widget/iframe_view.dart';

class PostCreatePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(postViewModelProvider);

    //住所フォーム上書き
    final adressTextController = TextEditingController();
    adressTextController.value = adressTextController.value.copyWith(
      text: viewModel.address,
    );

    print(viewModel.loading);

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60), child: GlobalMenu()),
        body: LoadingView(
            progress: viewModel.loading,
            child: SingleChildScrollView(
                child: Container(
                    alignment: Alignment.center,
                    child: Container(
                        padding: EdgeInsets.only(top: 50, left: 16, right: 16),
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 800),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "新しい稲荷神社を投稿",
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
                                  onChanged: (text) {
                                    viewModel.onChangeName(text);
                                  }),
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
                                    decoration:
                                        InputDecoration(hintText: "住所を追加"),
                                    controller: adressTextController,
                                    onChanged: (text) {
                                      viewModel.onChangeAddress(text);
                                    },
                                  )),
                                  IconButton(
                                    icon: Icon(Icons.map),
                                    onPressed: () async {
                                      final latLng = await Navigator.of(context)
                                          .push(SelectLocationModal(
                                              viewModel.location));
                                      if (latLng != null) {
                                        viewModel.onChangeLocation(latLng);
                                      }
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  SizedBox(
                                    width: 220,
                                    height: 220,
                                    child: IframeView(
                                      source:
                                          "https://maps.google.co.jp/maps?output=embed&q=${viewModel.location.latitude},${viewModel.location.longitude}",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  // SizedBox(
                                  //   width: 220,
                                  //   height: 220,
                                  //   child: IframeView(
                                  //     source:
                                  //     "https://www.google.com/maps/embed/v1/streetview?location=${viewModel.location.latitude},${viewModel.location.longitude}&fov=80&heading=70&pitch=0&key=AIzaSyDwh06g-fRW_9uQb99WGP_bUSYpfZTgJN0",
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("参拝日")
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      viewModel.visitedAt.format("yyyy/MM/dd")),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    child: Text("日付選択"),
                                    style: ElevatedButton.styleFrom(),
                                    onPressed: () async {
                                      final DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: new DateTime(2000),
                                              lastDate: new DateTime.now());
                                      if (pickedDate == null) return;
                                      viewModel.onChangeVisitedAt(pickedDate);
                                    },
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
                              // ConstrainedBox(
                              //   constraints: BoxConstraints(maxHeight: 200),
                              //   child: TextField(
                              //     keyboardType: TextInputType.multiline,
                              //     maxLines: null,
                              //     decoration:
                              //         InputDecoration(hintText: "メモを追加"),
                              //     onChanged: (text) {
                              //       viewModel.onChangeMemo(text);
                              //     },
                              //   ),
                              // ),
                              SizedBox(
                                height: 25,
                              ),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     Icon(Icons.photo_library),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     // Text(
                              //     //     "画像\n画像形式:JPEG/PNG\n推奨サイズ:4x3\nファイルサイズ5MB,5枚まで投稿可能"),
                              //     // Text("画像"),
                              //     // SizedBox(
                              //     //   width: 10,
                              //     // ),
                              //     // SizedBox(
                              //     //   height: 28,
                              //     //   width: 160,
                              //     //   child: ElevatedButton.icon(
                              //     //     icon: Icon(Icons.upload_rounded),
                              //     //     label: Text("ファイルを選択"),
                              //     //     style: ElevatedButton.styleFrom(),
                              //     //     onPressed: () async {
                              //     //       final fromPicker =
                              //     //           await ImagePickerWeb.getMultiImages(
                              //     //                   outputType: ImageType.bytes)
                              //     //               as List<Uint8List>;
                              //     //       print(fromPicker.length.toString());
                              //     //       viewModel.addUploadImage(fromPicker);
                              //     //     },
                              //     //   ),
                              //     // )
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              SizedBox(height: 20),
                              ListView.builder(
                                itemCount: viewModel.memosTexts.length,
                                itemBuilder: (context, index) {
                                  return _buildMemo(context, index);
                                },
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                              ),
                              // GridView.count(
                              //     physics: NeverScrollableScrollPhysics(),
                              //     crossAxisCount: Responsive.value(
                              //             context: context,
                              //             desktop: 1,
                              //             tablet: 1,
                              //             mobile: 1)
                              //         .toInt(),
                              //     mainAxisSpacing: 15,
                              //     crossAxisSpacing: 15,
                              //     shrinkWrap: true,
                              //     children: _buildMemos(context)),
                              SizedBox(
                                height: 40,
                              ),
                              Visibility(
                                  visible: (viewModel.memoImages.length >= 1)
                                      ? true
                                      : false,
                                  child: SizedBox(
                                    height: 28,
                                    width: 160,
                                    child: ElevatedButton.icon(
                                      icon: Icon(Icons.upload_rounded),
                                      label: Text("メモを追加"),
                                      style: ElevatedButton.styleFrom(),
                                      onPressed: () async {
                                        final image =
                                            await ImagePickerWeb.getImage(
                                                    outputType: ImageType.bytes)
                                                as Uint8List;
                                        viewModel.addNewMemo("", image);
                                      },
                                    ),
                                  )),
                              Row(
                                children: [
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
                                        viewModel.post(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ]))))));
  }

  Widget _buildMemo(BuildContext context, int index) {
    final memoImage = context.read(postViewModelProvider).memoImages[index];

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 300),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo, size: 40),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "画像を追加",
                        style: TextStyle(
                            fontFamily: FontFamily.NOTOSANS_BOLD, fontSize: 16),
                      )
                    ],
                  ),
                ),
                if (memoImage != null) Image.memory(memoImage)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 200),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(hintText: "メモを追加"),
                onChanged: (text) {
                  context
                      .read(postViewModelProvider)
                      .onChangeMemoText(index, text);
                },
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
        final image = await ImagePickerWeb.getImage(outputType: ImageType.bytes)
            as Uint8List;
        log("メモ画像が選択されました");
        context.read(postViewModelProvider).onChangeMemoImage(index, image);
      },
    );
  }
}
