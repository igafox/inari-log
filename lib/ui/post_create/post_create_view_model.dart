import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inari_log/app_router.dart';
import 'package:inari_log/model/post.dart';
import 'package:inari_log/model/post_memo.dart';
import 'package:inari_log/repository/address_repository.dart';
import 'package:inari_log/repository/address_repository_imp.dart';
import 'package:inari_log/repository/image_repository.dart';
import 'package:inari_log/repository/image_repository_imp.dart';
import 'package:inari_log/repository/post_repository.dart';
import 'package:inari_log/repository/post_repository_imp.dart';

final postViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => PostViewModel(ref.read));

class PostViewModel extends ChangeNotifier {
  PostViewModel(this._reader);

  final Reader _reader;

  // late final AuthRepository _repository = _reader(authRepositoryProvider);

  late final PostRepository _poreRepository = _reader(postRepositoryProvider);

  late final AddressRepository _addressRepository =
      _reader(addressRepositoryProvider);

  late final ImageRepository _imageRepository =
      _reader(imageRepositoryProvider);

  String _name = "";

  String get name => _name;

  String _address = "";

  String get address => _address;

  LatLng _location = LatLng(35.680400, 139.769017);

  LatLng get location => _location;

  DateTime _visitedDate = DateTime.now();

  DateTime get visitedDate => _visitedDate;

  List<String> _memoTexts = [""];

  List<String> get memosTexts => _memoTexts;

  List<Uint8List?> _memoImages = [null];

  List<Uint8List?> get memoImages => _memoImages;

  bool _loading = false;

  bool get loading => _loading;

  // Set<Marker> _marker = {
  //   Marker(
  //     position: LatLng(35.680400, 139.769017),
  //     markerId: MarkerId("pin"),
  //   )
  // };
  //
  // Set<Marker> get marker => _marker;

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

  void onChangeVisitedAt(DateTime date) {
    _visitedDate = date;
    notifyListeners();
  }

  void removeMemo(int index) {
    _memoTexts.removeAt(index);
    _memoImages.removeAt(index);
    notifyListeners();
  }

  void addNewMemo(String text, Uint8List image) {
    _memoTexts.add(text);
    _memoImages.add(image);
    notifyListeners();
  }

  void onChangeMemoText(int index, String text) {
    log(text);
    _memoTexts[index] = text;
    notifyListeners();
  }

  void onChangeMemoImage(int index, Uint8List image) {
    _memoImages[index] = image;
    notifyListeners();
  }

  void onChangeLocation(LatLng latLng) async {
    _location = latLng;

    var newAddress = await _addressRepository.findByLocation(
        latLng.latitude, latLng.longitude);

    _address = newAddress;

    print(address);

    notifyListeners();
  }

  // void addUploadImage(List<Uint8List> imgs) {
  //   _uploadImages = imgs.take(5).toList();
  //   notifyListeners();
  // }

  void post(BuildContext context) async {
    _loading = true;
    notifyListeners();

    final postId = await _poreRepository.generateId();

    //未設定画像判定
    final hasNoImageMemo =
        memoImages.where((element) => element == null).isNotEmpty;
    if (hasNoImageMemo) {
      log("画像が設定されていないメモがあります");
      return;
    }

    log(_memoImages.length.toString());

    //画像アップロード処理
    final uploadMemos =
        await Future.wait(_memoImages.mapIndexed((index, image) async {
      final imageUrl = await _imageRepository.uploadImage(postId, image!);
      final text = _memoTexts[index];
      return PostMemo(text: text, imageUrl: imageUrl);
    }).toList());

    //投稿データ作成
    final post = Post(
      id: postId,
      name: _name,
      address: _address,
      location: GeoPoint(_location.latitude,_location.longitude),
      memos: uploadMemos,
      visitedDate: _visitedDate
    );
    //データ登録
    await _poreRepository.create(post);

    //前の画面に戻る
    AppRouter.router.pop(context);

    _loading = false;
    notifyListeners();
  }
}
