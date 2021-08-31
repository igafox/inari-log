import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                              "メールアドレスで登録",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: FontFamily.NOTOSANS_BOLD),
                            ),
                            Divider(
                              height: 40,
                              thickness: 2,
                              color: Colors.black26,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "おいなりログへようこそ",
                                style: TextStyle(
                                  fontFamily: FontFamily.NOTOSANS_BOLD,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            CircleImage(
                              size: 100,
                              image: AssetImage("images/icon.png"),
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
                            TextField(
                              maxLines: 1,
                              decoration: InputDecoration(
                                  hintText: "ユーザー名",
                                  contentPadding: EdgeInsets.zero,
                                  prefixIcon: Icon(Icons.account_circle),
                                  border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white24))),
                              onChanged: (text) {
                                viewModel.setUserName(text);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              maxLines: 1,
                              decoration: InputDecoration(
                                  hintText: "メールアドレス",
                                  contentPadding: EdgeInsets.zero,
                                  prefixIcon: Icon(Icons.mail_outline),
                                  border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white24))),
                              onChanged: (text) {
                                viewModel.setEmail(text);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              maxLines: 1,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "パスワード",
                                  contentPadding: EdgeInsets.zero,
                                  prefixIcon: Icon(Icons.lock_outline_rounded),
                                  border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white24))),
                              onChanged: (text) {
                                viewModel.setPassword(text);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              maxLines: 1,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "パスワード(確認)",
                                  contentPadding: EdgeInsets.zero,
                                  prefixIcon: Icon(Icons.lock_outline_rounded),
                                  border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white24))),
                              onChanged: (text) {
                                viewModel.setConfirmPassword(text);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                child: const Text("登録する",
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
                            Divider(
                              height: 40,
                              thickness: 2,
                              color: Colors.black26,
                            ),
                            Text("または"),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.twitter,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Twitterでログイン",
                                        style: TextStyle(
                                          fontFamily: FontFamily.NOTOSANS_BOLD,
                                        ))
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.lightBlue,
                                  onPrimary: Colors.white,
                                ),
                                onPressed: () async {
                                  //viewModel.login();
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.google,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Googleでログイン",
                                        style: TextStyle(
                                          fontFamily: FontFamily.NOTOSANS_BOLD,
                                        ))
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  onPrimary: Colors.white,
                                ),
                                onPressed: () async {
                                  //viewModel.login();
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                child: Row(
                                  children: [
                                    Icon(Icons.mail_outline),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "メールアドレスで登録する",
                                      style: TextStyle(
                                        fontFamily: FontFamily.NOTOSANS_BOLD,
                                      ),
                                    )
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.black,
                                ),
                                onPressed: () async {
                                  //viewModel.login();
                                },
                              ),
                            )
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