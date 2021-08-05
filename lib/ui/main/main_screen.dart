import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../top/top_page.dart';
import 'main_view_model.dart';

class MainPage extends HookWidget {

  @override
  Widget build(BuildContext context) {

    final viewModel = useProvider(mainViewModelProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          title: Text('おいなりログ'),
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  '新規登録',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                )),
            SizedBox(
              width: 10,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  '投稿一覧',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                )),
            SizedBox(
              width: 10,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'iga',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ))
          ],
        ),
      ),
      body: _buildBodyWidget(viewModel.currentPageType),
    );
  }

  Widget _buildBodyWidget(PageType pageType) {
    switch(pageType) {

      case PageType.Top:
        return TopPage();

    }
  }

}