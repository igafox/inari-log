import 'dart:developer';
import 'dart:typed_data';

import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/model/post_memo.dart';
import 'package:inari_log/repository/image_repository.dart';
import 'package:inari_log/repository/image_repository_imp.dart';
import 'package:inari_log/repository/post_repository.dart';
import 'package:inari_log/repository/post_repository_imp.dart';
import 'package:tuple/tuple.dart';

final postViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => PostViewModel(ref.read));

class PostViewModel extends ChangeNotifier {
  PostViewModel(this._reader);

  final Reader _reader;

  // late final AuthRepository _repository = _reader(authRepositoryProvider);

  late final PostRepository _poreRepository = _reader(postRepositoryProvider);

  late final ImageRepository _imageRepository =
      _reader(imageRepositoryProvider);

  String _name = "";

  String get name => _name;

  String _address = "";

  String get address => _address;

  LatLng _location = LatLng(35.680400, 139.769017);

  LatLng get location => _location;

  List<Tuple2<String, Uint8List?>> _memos = [Tuple2("", null)];

  List<Tuple2<String, Uint8List?>> get memos => _memos;

  List<String> _memoTexts = [""];

  List<String> get memosTexts => _memoTexts;

  List<Uint8List?> _memoImages = [null];

  List<Uint8List?> get memoImagess => _memoImages;

  bool _loading = false;

  bool get loading => _loading;

  Set<Marker> _marker = {
    Marker(
      position: LatLng(35.680400, 139.769017),
      markerId: MarkerId("pin"),
    )
  };

  Set<Marker> get marker => _marker;

  // void changeAddress(String address) async {
  //   print(address);
  //   var locations = await locationFromAddress(address);
  //   _location = LatLng(locations.first.latitude, locations.first.longitude);
  //   notifyListeners();
  // }

  void onChangeName(String text) {
    _name = text;
  }

  void onChangeAddress(String text) {
    _address = text;
  }

  void removeMemo() {}

  void addMemo(String text,Uint8List image) {
    memos.add(Tuple2(text, image));
    notifyListeners();
  }

  void onChangeMemoText(int index, String text) {}

  void onChangeMemoImage(int index, Uint8List image) {
    final text = memos[index].item1;
    _memos[index] = _memos[index].withItem2(image);
    log(_memos.toString());
    notifyListeners();
  }

  // void changeLocation(LatLng latLng) async {
  //   _location = latLng;
  //   // var places =
  //   //     await placemarkFromCoordinates(_location.latitude, _location.longitude);
  //   // var place = places.first;
  //   // _address = place.street ?? "";
  //
  //   _marker = {
  //     Marker(
  //       position: latLng,
  //       markerId: MarkerId(DateTime.now().toIso8601String()),
  //     )
  //   };
  //
  //   print(marker.first.position.latitude.toString());
  //
  //   _address = latLng.latitude.toString() + ":" + latLng.longitude.toString();
  //
  //   notifyListeners();
  // }

  // void addUploadImage(List<Uint8List> imgs) {
  //   _uploadImages = imgs.take(5).toList();
  //   notifyListeners();
  // }

  void post(BuildContext context) async {
    _loading = true;
    notifyListeners();

    final postId = await _poreRepository.generateId();

    final hasNoImageMemo = memos.where((element) => element.item2 == null).isNotEmpty;
    if(hasNoImageMemo) {
      log("画像が設定されていないメモがあります");
      return;
    }

    final uploadMemos = await Future.wait(memos.map((memo) async {
      final imageUrl = await _imageRepository.uploadImage(postId, memo.item2!);
      return PostMemo(text: memo.item1, imageUrl: imageUrl);
    }).toList());

    final post = Post(
      id: postId,
      name: _name,
      address: _address,
      memos: uploadMemos,
    );
    await _poreRepository.create(post);

    AppRouter.router.pop(context);

    _loading = false;
    notifyListeners();
  }
}
