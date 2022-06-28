import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/extension/date_time_ext.dart';
import 'package:inari_log/ui/global_menu/global_menu.dart';
import 'package:inari_log/ui/modal/select_location_modal.dart';
import 'package:inari_log/ui/post_edit/post_edit_view_model.dart';
import 'package:inari_log/ui/post_edit/post_image_source.dart';
import 'package:inari_log/ui/widget/loading_view.dart';
import 'package:inari_log/widget/iframe_view.dart';

class PostEditPage extends HookWidget {
  PostEditPage({required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(postEditViewModelProvider(postId));

    //名前フォーム用
    final nameTextController = TextEditingController();
    nameTextController.value = nameTextController.value.copyWith(
      text: viewModel.name,
    );

    //県フォーム用
    final prefectureTextController = TextEditingController();
    prefectureTextController.value = prefectureTextController.value.copyWith(
      text: viewModel.prefecture,
    );

    //市区町村フォーム用
    final municipalityTextController = TextEditingController();
    municipalityTextController.value =
        municipalityTextController.value.copyWith(
      text: viewModel.municipality,
    );

    //丁目番地号フォーム用
    final localTextController = TextEditingController();
    localTextController.value = localTextController.value.copyWith(
      text: viewModel.houseNumber,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      switch (viewModel.currentDialogType) {
        case PostEditDialogType.PERMISSION_ERROR:
          await showAlertDialog(
              context,
              "権限エラー",
              "この投稿を編集する権限がありません",
              "OK",
              () =>
                  AppRouter.router.navigateTo(context, "/", clearStack: true));
          break;
        case PostEditDialogType.FAILED_LOAD_DATA:
          await showAlertDialog(
              context, "エラー", "データの読み込みに失敗しました", "再試行", () => viewModel.load());
          break;
        case PostEditDialogType.FILE_SIZE_OVER_ERROR:
          await showAlertDialog(context, "ファイルサイズが大きすぎます",
              "1画像のファイルサイズ上限は5MB以内です", "OK", () => Navigator.of(context).pop());
          break;
        case PostEditDialogType.SUCCESS_POST:
          await showAlertDialog(context, "", "投稿が完了しました", "OK",
              () => Navigator.of(context).pop());
          break;
        default:
          break;
      }
      viewModel.onCompleteShowDialog();
    });

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
                                "投稿を編集",
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
                                children: [
                                  Icon(Icons.bookmark),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "名前",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  )
                                ],
                              ),
                              TextField(
                                  decoration: InputDecoration(
                                    hintText: "名前を追加",
                                  ),
                                  controller: nameTextController,
                                  onChanged: (text) {
                                    viewModel.onChangeName(text);
                                  }),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.place),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "位置",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  if (viewModel.location != null)
                                    Expanded(
                                      child: SizedBox(
                                        width: 200,
                                        height: 300,
                                        child: IframeView(
                                          source:
                                              "https://maps.google.co.jp/maps?output=embed&q=${viewModel.location!.latitude},${viewModel.location!.longitude}",
                                        ),
                                      ),
                                    )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 40,
                                child: ElevatedButton(
                                  child: Text("マーカーを選択"),
                                  onPressed: () async {
                                    final latLng = await Navigator.of(context)
                                        .push(SelectLocationModal(
                                            viewModel.location!));
                                    if (latLng != null) {
                                      viewModel.onChangeLocation(latLng);
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.home_filled),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "住所",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(labelText: '県'),
                                    controller: prefectureTextController,
                                    onChanged: (text) {
                                      viewModel.onChangePrefecture(text);
                                    },
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: "市区町村"),
                                    controller: municipalityTextController,
                                    onChanged: (text) {
                                      viewModel.onChangeMunicipality(text);
                                    },
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: "丁目番地号"),
                                    controller: localTextController,
                                    onChanged: (text) {
                                      viewModel.onChangeLocalSection(text);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.access_time_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "訪れた日付",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(viewModel.visitedDate
                                      .format("yyyy年MM月dd日")),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: ElevatedButton(
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
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.image),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "画像",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("形式:JPEG/PNG"),
                                  Text("ファイルサイズ:5MB以内"),
                                  Text("5枚までアップロード可能です"),
                                ],
                              ),
                              SizedBox(height: 20),
                              ListView.builder(
                                itemCount: viewModel.postImages.length,
                                itemBuilder: (context, index) {
                                  final postImage = viewModel.postImages[index];
                                  return _buildMemo(
                                      context, index, postImage, viewModel);
                                },
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                  visible: (viewModel.postImages.length < 5)
                                      ? true
                                      : false,
                                  child: Align(
                                    child: SizedBox(
                                      height: 40,
                                      width: double.infinity,
                                      child: ElevatedButton.icon(
                                        icon: Icon(Icons.add),
                                        label: Text("画像を追加"),
                                        style: ElevatedButton.styleFrom(),
                                        onPressed: () async {
                                          //選択ダイアログ表示
                                          final image =
                                              await ImagePickerWeb.getImage(
                                                  outputType: ImageType
                                                      .bytes) as Uint8List?;

                                          if (image == null) return;

                                          viewModel.addNewMemo("", image);
                                        },
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 50,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                  width: 100,
                                  height: 35,
                                  child: ElevatedButton(
                                    child: const Text("投稿"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.orange,
                                      onPrimary: Colors.white,
                                    ),
                                    onPressed: () async {
                                      // viewModel.post(context);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ]))))));
  }

  Widget _buildMemo(BuildContext context, int index, PostImageSource source,
      PostEditViewModel viewModel) {
    final textInputController = new TextEditingController();
    textInputController.text = source.text;

    return GestureDetector(
      child: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Stack(
                children: [
                  if (!source.hasImage())
                    Align(
                      alignment: Alignment.center,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 300),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.photo, size: 40),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "画像を選択",
                              style: TextStyle(
                                  fontFamily: FontFamily.NOTOSANS_BOLD,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (source is ByteImageSource)
                    Image.memory(
                      source.data,
                      width: double.infinity,
                    ),
                  if (source is UrlImageSource)
                    Image.network(
                      source.url,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          viewModel.onRemoveMemo(index);
                        }),
                  ),
                  //if (memoImage != null) Image.memory(memoImage)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 200),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "テキストを入力",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white24,
                    ),
                  ),
                ),
                controller: textInputController,
                onChanged: (text) {
                  viewModel.onChangeMemoText(index, text);
                  // context
                  //     .read(postViewModelProvider)
                  //     .onChangeMemoText(index, text);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      onTap: () async {
        final image = await ImagePickerWeb.getImage(outputType: ImageType.bytes)
            as Uint8List?;
        if (image == null) return;
        log("メモ画像が選択されました");
        viewModel.onChangeMemoImage(index, image);
        //context.read(postEditViewModelProvider(postId)).onChangeMemoImage(index, image);
      },
    );
  }

  Future showAlertDialog(BuildContext context, String title, String message,
      String? buttonText, Function()? buttonFunction) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
                child: Text(buttonText ?? "OK"),
                onPressed: buttonFunction ??
                    () {
                      Navigator.pop(context);
                    }),
          ],
        );
      },
    );
  }
}
