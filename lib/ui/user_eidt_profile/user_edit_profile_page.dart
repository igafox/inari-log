import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:inari_log/constant.dart';
import 'package:inari_log/ui/global_menu/global_menu.dart';
import 'package:inari_log/ui/user_eidt_profile/user_edit_profile_view_model.dart';
import 'package:inari_log/ui/widget/circle_image.dart';
import 'package:inari_log/ui/widget/loading_view.dart';

class UserEditProfilePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(userEditProfileViewModelProvider);

    useEffect(() {
      viewModel.load();
    },[viewModel]);

    final nameTextController = TextEditingController();
    nameTextController.value = nameTextController.value.copyWith(
      text: viewModel.userName,
    );

    final locationTextController = TextEditingController();
    locationTextController.value = locationTextController.value.copyWith(
      text: viewModel.location,
    );

    final commentTextController = TextEditingController();
    commentTextController.value =
        commentTextController.value.copyWith(
          text: viewModel.comment,
        );

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: GlobalMenu(),
        ),
        body: LoadingView(
          progress: viewModel.loading,
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topCenter,
              child: Container(
                  margin:
                      EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 24),
                  constraints: BoxConstraints(maxWidth: 450),
                  child: Column(children: [
                    Container(
                      child: Text(
                        viewModel.errorMessage,
                        style: TextStyle(fontSize: 15, color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              "プロフィール変更",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: FontFamily.NOTOSANS_BOLD),
                            ),
                            Divider(
                              height: 40,
                              thickness: 2,
                              color: Colors.black26,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            if (viewModel.profileImage != null)
                              CircleImage(
                                size: 100,
                                image: MemoryImage(viewModel.profileImage!),
                              ),
                            if (viewModel.profileImage == null)
                              CircleImage(
                                size: 100,
                                image: NetworkImage(
                                    viewModel.user?.imageUrl ?? ""),
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                child: Text("プロフィール画像を変更"),
                                onPressed: () async {
                                  final fromPicker =
                                      await ImagePickerWeb.getImage(
                                              outputType: ImageType.bytes)
                                          as Uint8List;
                                  viewModel.setUserImage(fromPicker);
                                }),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              maxLines: 1,
                              decoration: InputDecoration(
                                  labelText: "ユーザー名",
                                  contentPadding: EdgeInsets.zero,
                                  prefixIcon: Icon(Icons.account_circle),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white24))),
                              onChanged: (text) {
                                viewModel.setUserName(text);
                              },
                              controller: nameTextController,
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
                                  labelText: "地域",
                                  prefixIcon: Icon(Icons.location_on),
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (text) {
                                  viewModel.setLocation(text);
                                },
                                controller: locationTextController,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 125),
                              child: TextFormField(
                                minLines: 4,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  labelText: "自己紹介",
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (text) {
                                  viewModel.setComment(text);
                                },
                                controller: commentTextController,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                child: const Text("変更",
                                    style: TextStyle(
                                      fontFamily: FontFamily.NOTOSANS_BOLD,
                                    )),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  onPrimary: Colors.white,
                                ),
                                onPressed: () async {
                                  viewModel.onClickRegisterButton(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ])),
            ),
          ),
        ));
  }
}
